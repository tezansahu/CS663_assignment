%% MyMainScript
cd ..;
mkdir images/;
cd codes/;
tic;
%% Part (a) Foreground Mask
tic;
img = imread("../data/statue.png");
[mask, masked_image] = myForegroundMask(img);
subplot(1,3,1), showImage(img, "Original Image", 200);
subplot(1,3,2), showImage(mask, "Binary Mask", 200);
subplot(1,3,3), showImage(masked_image, "Masked Image", 200);
cd ../images/;
save mask.mat mask;
save masked_image.mat masked_image;
cd ../codes;
pause(2);
toc;

%% Part (b) Linear Contrast Stretching
tic;

toc;

%% Part (c) Histogram Equalisation
tic;

toc;

%% Part (d) Histogram Matching
tic;

toc;

%% Part (e) Contrast Limited Adaptive Histogram Equalisation
tic;


toc;
toc;
