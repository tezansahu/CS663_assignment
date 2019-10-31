%% Solution to A5 - Q5
close all

tic;
%% Solution
cd ../data;
im_barbara = double(imread("barbara256.png"));
im_stream = double(imread("stream.png"));
cd ../code;

%% For barbara256.png:
%% Part (a)

% Adding zero mean Gaussian noise of sd=20
% im1 = min(255, im + uint8(randn(size(im))*20));
im1 = im_barbara + randn(size(im_barbara)) * 20;
% imshow(im1, [min(im1(:)), max(im1(:))]); impixelinfo;
im2 = myPCADenoising1(im1, 20);
figure(1)
subplot(131); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title("Original Image"); impixelinfo;
subplot(132); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(133); imshow(im2, [min(im2(:)), max(im2(:))]); title("Denoised Image"); impixelinfo;

% RMSE of noisy image wrt original image
RMSE = sqrt(sum(sum(im1 - im_barbara).^2)) / sqrt(sum(sum(im_barbara.^2)));
RMSE
% RMSE of denoised image wrt original image
RMSE = sqrt(sum(sum(im2 - im_barbara).^2)) / sqrt(sum(sum(im_barbara.^2)));
RMSE

%% Part (b)


%% Part (c)
im2 = myBilateralFiltering(im1./max(im1), 7, 1, 0.4);
figure(3)
subplot(131); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title("Original Image"); impixelinfo;
subplot(132); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(133); imshow(im2, [min(im2(:)), max(im2(:))]); title("Bilateral Filtered Image"); impixelinfo;

%% Part (d)


%% For stream.png:
%% Part (a)
% Adding zero mean Gaussian noise of sd=20
% im1 = min(255, im + uint8(randn(size(im))*20));
im1 = im_stream + randn(size(im_stream)) * 20;
% imshow(im1, [min(im1(:)), max(im1(:))]); impixelinfo;
im2 = myPCADenoising1(im1, 20);
figure(5)
subplot(131); imshow(im_stream, [min(im_stream(:)), max(im_stream(:))]); title("Original Image"); impixelinfo;
subplot(132); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(133); imshow(im2, [min(im2(:)), max(im2(:))]); title("Denoised Image"); impixelinfo;

% RMSE of noisy image wrt original image
RMSE = sqrt(sum(sum(im1 - im_stream).^2)) / sqrt(sum(sum(im_stream.^2)));
RMSE
% RMSE of denoised image wrt original image
RMSE = sqrt(sum(sum(im2 - im_stream).^2)) / sqrt(sum(sum(im_stream.^2)));
RMSE

%% Part (b)


%% Part (c)

im2 = myBilateralFiltering(im1./max(im1), 7, 1, 0.4);
figure(7)
subplot(131); imshow(im_stream, [min(im_stream(:)), max(im_stream(:))]); title("Original Image"); impixelinfo;
subplot(132); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(133); imshow(im2, [min(im2(:)), max(im2(:))]); title("Bilateral Filtered Image"); impixelinfo;

%% Part (d)
toc;
