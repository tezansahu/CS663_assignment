%% MyMainScript
clear;
close all;
tic;
%% ORL Dataset
% Training
N = 32*6; d = 112*92;
X = zeros(d, N); % Matrix of all the images d x N
x_bar = zeros(d, 1); % Average image d x 1
cd ../../..;
for i=1:32
    D = strcat('ORL_dataset/s',int2str(i));
    S = dir(fullfile(D,'*.pgm'));
    for j=1:6
        F = fullfile(D, S(j).name);
        I = im2double(imread(F));
        X(:, (i-1)*6+j) = I(:);
        x_bar = x_bar + I(:);
    end
end
x_bar = x_bar./N;
for i=1:N
    X(:, i) = X(:, i) - x_bar;
end


% Using svd function
[U, ~, ~] = svd(X, 0); % U-Left singular vectors d x N; S-Singular value matrix d x N; [U, S, V]

kvals = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];

len_k = length(kvals);
success_rate = zeros(1,len_k);

for k_idx = 1:len_k
    k = kvals(k_idx);
    % For k largest eigenvalues
    U_k = U(:, 1:k); % d x k
    alpha_k = U_k'*X; % Eigencoefficients k x N

    % Testing
    test_N = 32*4;
    success = 0;
    for i=1:32 
        D = strcat('ORL_dataset/s',int2str(i));
        S = dir(fullfile(D,'*.pgm'));
        for j=7:10
            F = fullfile(D, S(j).name);
            I = im2double(imread(F));
            z_p = I(:) - x_bar; % Mean probe image
            alpha_p = U_k'*z_p; % Eigencoefficient of probe image
            min_index = 1;
            min_dist = norm(alpha_p - alpha_k(:,1));
            for l = 2:N
                if norm(alpha_p - alpha_k(:,l)) < min_dist
                    min_dist = norm(alpha_p - alpha_k(:,l));
                    min_index = ceil(l/6);
                end
            end
            if min_index == i
                success = success + 1;
            end
        end
    end
    success_rate(1,k_idx) = success/test_N;
end
figure(1);
plot(kvals, success_rate);

% Using eig function

kvals = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];

% kvals =  [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
len_k = length(kvals);
success_rate = zeros(1,len_k);

for k_idx = 1:len_k
    k = kvals(k_idx);
    L = X'*X; % Reduced complexity matrix N x N
    [W, eigen] = eigs(L, k); % W-Right eigenvectors of L N x N; Eigenvalue matrix N x N
    V = X*W; % Eigenvectors of C d x N
    for col=1:size(V,2)
        V(:,col) = V(:,col)./norm(V(:,col));
    end

    % For k largest eigenvalues
    V_k = V(:, 1:k); % d x k
    alpha_k = V_k'*X; % Eigencoefficients k x N

    % Testing
    test_N = 32*4;
    success = 0;
    for i=1:32 
        D = strcat('ORL_dataset/s',int2str(i));
        S = dir(fullfile(D,'*.pgm'));
        for j=7:10
            F = fullfile(D, S(j).name);
            I = im2double(imread(F));
            z_p = I(:) - x_bar; % Mean probe image
            alpha_p = V_k'*z_p; % Eigencoefficient of probe image
            min_index = 1;
            min_dist = norm(alpha_p - alpha_k(:,1));
            for l = 2:N
                if norm(alpha_p - alpha_k(:,l)) < min_dist
                    min_dist = norm(alpha_p - alpha_k(:,l));
                    min_index = ceil(l/6);
                end
            end
            if min_index == i
                success = success + 1;
            end
        end
    end
    success_rate(1,k_idx) = success/test_N;
end
figure(2);
plot(kvals, success_rate);

%% Yale Dataset
% Training
N = 38*40; d = 192*168;
X = zeros(d, N); % Matrix of all the images d x N
x_bar = zeros(d, 1); % Average image d x 1

for i=1:39
    if i==14 % Since person 14 is not there
        continue
    elseif i<10
        str_zero='0';
    else
        str_zero = '';
    end
    D = strcat('CroppedYale/yaleB',str_zero,int2str(i));
    S = dir(fullfile(D,'*.pgm'));
    for j=1:40
        F = fullfile(D, S(j).name);
        if i>14
            no_persons = i-2;
        else
            no_persons = i-1;
        end
        index = no_persons*40+j;
        I = im2double(imread(F));
        X(:, index) = I(:);
        x_bar = x_bar + I(:);
    end
end
x_bar = x_bar./N;
for i=1:N
    X(:, i) = X(:, i) - x_bar;
end

% k is 1003
[U_k, ~] = svds(X, 1003); % U-Left singular vectors d x k; S-Singular value matrix d x k; [U, S]

kvals =  [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];

len_k = length(kvals);
success_rate = zeros(1,len_k);
success_rate_remove3 = zeros(1,len_k);

alpha_k = U_k'*X; % Eigencoefficients k x N; X is d x N

for k_idx = 1:len_k
%     tic;
    k = kvals(k_idx);
    
    % Testing
    test_N = 38*20;
    success = 0;
    success_remove3 = 0;
    for i=1:39
        if i==14 % Since person 14 is not there
            continue
        elseif i<10
            str_zero='0';
        else
            str_zero = '';
        end
        D = strcat('CroppedYale/yaleB',str_zero,int2str(i));
        S = dir(fullfile(D,'*.pgm'));
        for j=41:60
            F = fullfile(D, S(j).name);
            I = im2double(imread(F));
            z_p = I(:) - x_bar; % Mean probe image d x 1
            alpha_p = U_k'*z_p; % Eigencoefficient of probe image K x 1
            min_index = 1;
            min_index_remove3 = 1;
            min_dist = norm(alpha_p(1:k) - alpha_k(1:k,1));
            min_dist_remove3 = norm(alpha_p(4:k+3) - alpha_k(4:k+3,1));
            for l = 2:N
                if norm(alpha_p(1:k) - alpha_k(1:k,l)) < min_dist
                    min_dist = norm(alpha_p(1:k) - alpha_k(1:k,l));
                    min_index = ceil(l/40);
                end
                if norm(alpha_p(4:k+3) - alpha_k(4:k+3,l)) < min_dist_remove3
                    min_dist_remove3 = norm(alpha_p(4:k+3) - alpha_k(4:k+3,l));
                    min_index_remove3 = ceil(l/40);
                end
            end
            
            if min_index == i - (i>14)
                success = success + 1;
            end
            if min_index_remove3 == i - (i>14)
                success_remove3 = success_remove3 + 1;
            end
        end
    end
    success_rate(1,k_idx) = success/test_N;
    success_rate_remove3(1,k_idx) = success_remove3/test_N;
%     toc; % Nearly 20 seconds for each k (there are 17 k's)
end
figure(3);
plot(kvals, success_rate);
figure(4);
plot(kvals, success_rate_remove3);
toc;