%% MyMainScript

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

[U_k, ~] = svds(X, 175); % U-Left singular vectors d x k; S-Singular value matrix d x k; [U, S]
alpha_k = U_k'*X(:,1); % Eigencoefficients k x 1; X is d x N
% alpha_k has been calculated only for first datapoint

kvals = [2, 10, 20, 50, 75, 100, 125, 150, 175];
len_k = length(kvals);

% Reconstructing first datapoint in X
figure(1);
for k_idx = 1:len_k
    k = kvals(k_idx);
    reconst_img = U_k(:,1:k)*alpha_k(1:k,1);
    I = reshape(reconst_img,[],92);
    subplot(3,3,k_idx), imshow(I);
end

% Plotting first 25 eigenfaces
figure(2);
for k=1:25
    I = histeq(reshape(U_k(:,k),[],92));
    subplot(5,5,k), imshow(I);
end


toc;
