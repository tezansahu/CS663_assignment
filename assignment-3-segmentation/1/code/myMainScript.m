%% MyMainScript

tic;
%% Your code here
img = load("../data/boat.mat");
img = double(img.imageOrig)/255;
[dX, dY, eig1, eig2, cornerness] = myHarrisCornerDetector(img, 1, 2, 0.005);

figure(1);
subplot(1,2,1);
greyscale(dX);
title("Derivative along X axis");
subplot(1,2,2);
greyscale(dY);
title("Derivative along Y axis");

figure(2);
subplot(1,2,1);
greyscale(eig1);
title("1st Eigenvalue of Structure Tensor");
subplot(1,2,2);
greyscale(eig2);
title("2nd Eigenvalue of Structure Tensor");

figure(3);
subplot(1,2,1);
greyscale(img);
title("Original Image");
subplot(1,2,2);
greyscale(cornerness);
title("Harris Cornerness"); 

toc;
