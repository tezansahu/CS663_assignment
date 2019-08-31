%% MyMainScript

%% Bilateral Filtering for barbara.mat
tic;
img = load("../data/barbara.mat");
img.imageOrig = double(img.imageOrig)/max(max(img.imageOrig));
img_noisy = corruptImgGaussian(img.imageOrig);
img_filtered = myBilateralFiltering(img_noisy, 7, 1.6, 0.1); 
figure(1);
subplot(1,3,1);
greyscale(img.imageOrig);
title('Original Image'); 
subplot(1,3,2); 
greyscale(img_noisy);
title('Corrupted Image');
subplot(1,3,3); 
greyscale(img_filtered);
title('Filtered Image');
toc;

%% Bilateral Filtering for grass.mat
tic;
img = imread("../data/grass.png");
img = double(img)/double(max(max(img)));
% img.imageOrig = double(img.imageOrig)/max(max(img.imageOrig));
img_noisy = corruptImgGaussian(img);
img_filtered = myBilateralFiltering(img_noisy, 7, 0.77, 0.18);
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

%% Bilateral Filtering for honeyCombReal.mat
tic;
img = imread("../data/honeyCombReal.png");
img = double(img)/double(max(max(img)));
% img.imageOrig = double(img.imageOrig)/max(max(img.imageOrig));
img_noisy = corruptImgGaussian(img);
img_filtered = myBilateralFiltering(img_noisy, 15, 0.88, 0.162);
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
