%% MyMainScript
clear;
close all;

import mlreportgen.report.*
import mlreportgen.dom.*

cd ../report/
R = Report('Report 4.1: Face Recognition Rates', 'pdf');
open(R)
cd ../code/

T = Text("Assignment 4: Mini Face Recognition System");
T.Bold = true;
T.FontSize = '26';
headingObj = Heading1(T);
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading5("Tezan Sahu [170100035] & Siddharth Saha [170100025]");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading6("Due Date: 16/10/2019");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading3("Q1: Image Recognition Rate Plots");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

sec = Section;
T = Text("Plots");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;

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
                dist = norm(alpha_p - alpha_k(:,l));
                if dist < min_dist
                    min_dist = dist;
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

fig1 = figure(1);
plot(kvals, success_rate);
title("ORL Dataset");
xlabel('1 < k < 170') 
ylabel('Face Recognition Rate') 

caption = Paragraph("Fig 1: Face Recognition Rates using svd function on ORL dataset");
caption.Style = {HAlign('center')};

add(sec, Figure(fig1))
add(sec, caption);


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
                dist = norm(alpha_p - alpha_k(:,l));
                if dist < min_dist
                    min_dist = dist;
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

fig2 = figure(2);
plot(kvals, success_rate);
title("ORL Dataset");
xlabel('1 < k < 170') 
ylabel('Face Recognition Rate')

caption = Paragraph("Fig 2: Face Recognition Rates using eig function on ORL dataset");
caption.Style = {HAlign('center')};

add(sec, Figure(fig2))
add(sec, caption);



% Yale Dataset
% Training
N = 38*40; d = 192*168;
X = zeros(d, N); % Matrix of all the training images d x N
x_bar = zeros(d, 1); % Average image d x 1
id = zeros(N,1);
% Populating X with training images as column vectors each
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
        id(index) = i;
    end
end
x_bar = x_bar./N;
for i=1:N
    X(:, i) = X(:, i) - x_bar;
end

% k is 1003 (the highest value of k accessed later is 1000+3)
[U_k, ~] = svds(X, 1003); % U-Left singular vectors d x k; S-Singular value matrix d x k; [U, S]
alpha_k = U_k'*X; % Eigencoefficients k x N; X is d x N


% Testing
N_Testing = 38*20;
X_Testing = zeros(d, N_Testing); % Matrix of all the testing images d x N_testing
id_Testing = zeros(N_Testing,1);

kvals =  [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
len_k = length(kvals);
success_rate = zeros(1,len_k);
success_rate_remove3 = zeros(1,len_k);

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
        if i>14
            no_persons = i-2;
        else
            no_persons = i-1;
        end
        index = no_persons*20+j;
        I = im2double(imread(F));
        X_Testing(:, index) = I(:) - x_bar;        
        id_Testing(index) = i;
    end
end

alpha_Testing = U_k'*X_Testing; % Eigencoefficients of Testing images k x N_Testing; X_Testing is d x N_Testing

for k_idx = 1:len_k
%     tic;
    k = kvals(k_idx);    
    success = 0;
    success_remove3 = 0;    
    for i=1:N_Testing
%         tic;
        dist_per_component = alpha_k - repmat(alpha_Testing(:,i),1,N);
        dist = sum(dist_per_component(1:k,:).^2,1);
        [~,min_index] = min(dist); % id(minindex) dis the identity of the nearest neighbor
        success = success + (id_Testing(i) == id(min_index));

        dist = sum(dist_per_component(4:k+3,:).^2,1);
        [~,min_index] = min(dist); % id(minindex) dis the identity of the nearest neighbor
        success_remove3 = success_remove3 + (id_Testing(i) == id(min_index));
%         toc;
    end
    success_rate(1,k_idx) = success/N_Testing;
    success_rate_remove3(1,k_idx) = success_remove3/N_Testing;
%     toc; % Nearly 8 seconds for each k (there are 17 k's)
end

fig3 = figure(3);
plot(kvals, success_rate);
title("Yale Dataset");
xlabel('1 < k < 1000') 
ylabel('Face Recognition Rate')

caption = Paragraph("Fig 3.A: Face Recognition Rates on Yale dataset using squared differences between all eigencoefficients");
caption.Style = {HAlign('center')};

add(sec, Figure(fig3))
add(sec, caption);

fig4 = figure(4);
plot(kvals, success_rate_remove3);
title("Yale Dataset");
xlabel('1 < k < 1000') 
ylabel('Face Recognition Rate')

caption = Paragraph("Fig 3.B: Face Recognition Rates on Yale dataset using squared differences between all except the eigencoefficients corresponding to the three largest eigenvalues");
caption.Style = {HAlign('center')};

add(sec, Figure(fig4))
add(sec, caption);

add(R, sec);

toc; % Nearly 130 seconds
close(R);