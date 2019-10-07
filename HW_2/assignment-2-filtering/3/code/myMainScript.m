%% MyMainScript

%% Patch-Based Filtering for grass.png
tic;
img = load("../data/barbara.mat");
img = double(img.imageOrig)/100;
img = conv2(img, fspecial('gaussian', 5, 2/3), 'same'); % Smoothing of image before shrinking
img_small = img(1:2:size(img,1), 1:2:size(img, 2)); % Shrinking of image to speed up filtering
img_noisy = corruptImgGaussian(img_small);
img_filtered = myPatchBasedFiltering(img_noisy, 0.14);
% disp(getRMSD(img_filtered, img);
figure(1);
subplot(1,3,1);
greyscale(img);
title('Original Image'); 
subplot(1,3,2); 
greyscale(img_noisy);
title('Corrupted Image');
subplot(1,3,3); 
greyscale(img_filtered);
title('Filtered Image');
toc;

%% Patch-Based Filtering for grass.png
tic;
img = imread("../data/grass.png");
img = double(img)/double(max(max(img)));
% img.imageOrig = double(img.imageOrig)/max(max(img.imageOrig));
img_noisy = corruptImgGaussian(img);
img_filtered = myPatchBasedFiltering(img_noisy, 0.13);
% disp(getRMSD(img_filtered, img);
figure(2);
subplot(1,3,1);
greyscale(img);
title('Original Image'); 
subplot(1,3,2); 
greyscale(img_noisy);
title('Corrupted Image');
subplot(1,3,3); 
greyscale(img_filtered);
title('Filtered Image');
toc;

%% Patch-Based Filtering for honeyCombReal.png
tic;
img = imread("../data/honeyCombReal.png");
img = double(img)/255;
% img.imageOrig = double(img.imageOrig)/max(max(img.imageOrig));
img_noisy = corruptImgGaussian(img);
img_filtered = myPatchBasedFiltering(img_noisy, 0.16);
% disp(getRMSD(img_filtered, img);
figure(3);
subplot(1,3,1);
greyscale(img);
title('Original Image'); 
subplot(1,3,2); 
greyscale(img_noisy);
title('Corrupted Image');
subplot(1,3,3); 
greyscale(img_filtered);
title('Filtered Image');
toc;

%% Show mask used to make patches isotropic 
figure(4);
patch_size = 9;
sigma = 4/3;
[x,y] = meshgrid(-floor(patch_size/2):floor(patch_size/2), -floor(patch_size/2):floor(patch_size/2));
G_p = exp(-(x.^2 + y.^2)/(2*sigma^2));
greyscale(G_p);
