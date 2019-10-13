%% MyMainScript

tic;

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

[U, ~, ~] = svd(X, 0); % U-Left singular vectors d x N; S-Singular value matrix d x N; [U, S, V]

k = 100;
% For k largest eigenvalues
U_k = U(:, 1:k); % d x k
alpha_k = U_k'*X; % Eigencoefficients k x N

deviation_per_person = zeros(32,1); % Deviation from eigencoefficient per person

for i=1:32
    for j=1:5
        for m=j+1:6
            if norm(alpha_k(:,(i-1)*6+j) - alpha_k(:,(i-1)*6+m)) > deviation_per_person(i)
                deviation_per_person(i) = norm(alpha_k(:,(i-1)*6+j) - alpha_k(:,(i-1)*6+m));
            end
        end        
    end
end

thres_devn = 0.85*min(deviation_per_person);
% thres_devn = 0;

% Testing for false negatives
test_N = 32*4;
false_neg = 0;
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
            end
        end
        if min_dist > thres_devn
            false_neg = false_neg + 1;
        end
    end
end
false_neg = false_neg/test_N;
fprintf ('For k= %d, false negative rate = %f\n',k,100*false_neg);

% Testing for false negatives
test_N = 8*10;
false_pos = 0;
for i=33:40 
    D = strcat('ORL_dataset/s',int2str(i));
    S = dir(fullfile(D,'*.pgm'));
    for j=1:10
        F = fullfile(D, S(j).name);
        I = im2double(imread(F));
        z_p = I(:) - x_bar; % Mean probe image
        alpha_p = U_k'*z_p; % Eigencoefficient of probe image
        min_index = 1;
        min_dist = norm(alpha_p - alpha_k(:,1));
        for l = 2:N
            if norm(alpha_p - alpha_k(:,l)) < min_dist
                min_dist = norm(alpha_p - alpha_k(:,l));
            end
        end
        if min_dist < thres_devn
            false_pos = false_pos + 1;
        end
    end
end
false_pos = false_pos/test_N;
fprintf ('For k= %d, false positive rate = %f\n',k,100*false_pos);

toc;
