%% MyMainScript
cd ..;
mkdir images/;
cd codes/;
tic;
%% Part (a) Foreground Mask
tic;
img = imread("../data/statue.png");
[mask, masked_image] = myForegroundMask(img, 4);
subplot(1,3,1), showImage(img, "Original Image", 200);
subplot(1,3,2), showImage(mask, "Binary Mask", 200);
subplot(1,3,3), showImage(masked_image, "Masked Image", 200);
mask = logical(mask);
cd ../images/;
save mask.mat mask;
save masked_image.mat masked_image;
cd ../codes;
pause(2);
toc;

%% Part (b) Linear Contrast Stretching
tic;

img = imread("../data/barbara.png");
newImg = myLinearContrastStretching(img, ones(size(img,1), size(img,2)));
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/TEM.png");
newImg = myLinearContrastStretching(img, ones(size(img,1), size(img,2)));
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/canyon.png");
newImg = myLinearContrastStretching(img, ones(size(img,1), size(img,2)));
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/church.png");
newImg = myLinearContrastStretching(img, ones(size(img,1), size(img,2)));
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/chestXray.png");
newImg = myLinearContrastStretching(img, ones(size(img,1), size(img,2)));
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Linear Contrast Stretched Image", 200);
pause(2);

    
img = imread("../data/statue.png");
imgMask = mask;
newImg = myLinearContrastStretching(img, imgMask);
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Linear Contrast Stretched Image", 200);
pause(2);

toc;
% function [newImg] = myLinearContrastStretching(img, mask)

%% Part (c) Histogram Equalisation
tic;

img = imread("../data/barbara.png");
mask = logical(ones(size(img,1), size(img,2)));
newImg = myHE(img, mask);
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Histogram Equalized Image", 200);
pause(2);

img = imread("../data/TEM.png");
mask = logical(ones(size(img,1), size(img,2)));
newImg = myHE(img, mask);
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Histogram Equalized Image", 200);
pause(2);

img = imread("../data/canyon.png");
newImg = myHE(img, logical(ones(size(img,1), size(img,2))));
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Histogram Equalized Image", 200);
pause(2);

img = imread("../data/church.png");
newImg = myHE(img, logical(ones(size(img,1), size(img,2))));
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Histogram Equalized Image", 200);
pause(2);

img = imread("../data/chestXray.png");
mask = logical(ones(size(img,1), size(img,2)));
newImg = myHE(img, mask);
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Histogram Equalized Image", 200);
pause(2);

    
img = imread("../data/statue.png");
[imgMask, ~] = myForegroundMask(img, 4); 
newImg = myHE(img, imgMask);
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(newImg, "Histogram Equalized Image", 200);
pause(2);


toc;
% function [newImg] = myHE(img, mask)

%% Part (d) Histogram Matching
tic;
    img = imread("../data/retina.png");
    imgMask = imread("../data/retinaMask.png");
    ref = imread("../data/retinaRef.png");
    refMask = imread("../data/retinaRefMask.png");
    img_hm = myHM(img, imgMask, ref, refMask);
    img_he = myHE(img, imgMask);
    subplot(1,3,1), showImage(img, "Original Image", 200);
    subplot(1,3,2), showImage(img_hm, "Histogram Matched Image", 200);
    subplot(1,3,3), showImage(img_he, "Histogram Equalised Image", 200);
    pause(2);
toc;
% function [newImg] = myHM(img, imgMask, ref, refMask)

%% Part (e) Contrast Limited Adaptive Histogram Equalisation
tic;

    img = imread("../data/barbara.png");
    windowsize = [30 30];
    windowsizelarge = [100 100];
    windowsizesmall = [5 5];
    cliplimit = 4;
    newImg_1 = myCLAHE(img, windowsize, cliplimit);
    subplot(1,2,1), showImage(img, "Original Image", 200);
    subplot(1,2,2), showImage(newImg_1, "CLAHE Enhanced Image", 200);
    pause(2);
    newImg_2 = myCLAHE(img, windowsizelarge, cliplimit);
    newImg_3 = myCLAHE(img, windowsizesmall, cliplimit)
    subplot(1,2,1), showImage(newImg_2, "Larger Window Size 100x100", 200);
    subplot(1,2,2), showImage(newImg_3, "Smaller Window Size 5x5", 200);
    pause(2);
    newImg_4 = myCLAHE(img, windowsize, cliplimit);
    newImg_5 = myCLAHE(img, windowsize, cliplimit/2);
    subplot(1,2,1), showImage(newImg_4, "CLAHE Enhanced Image with Initial Clip Limit", 200);
    subplot(1,2,2), showImage(newImg_5, "CLAHE Enhanced Image with Clip Limit Halved", 200);
    pause(2);
    
    img = imread("../data/TEM.png");
    windowsize = [30 30];
    windowsizelarge = [150 150];
    windowsizesmall = [5 5];
    cliplimit = 10;
    newImg_1 = myCLAHE(img, windowsize, cliplimit);
    subplot(1,2,1), showImage(img, "Original Image", 200);
    subplot(1,2,2), showImage(newImg_1, "CLAHE Enhanced Image", 200);
    pause(2);
    newImg_2 = myCLAHE(img, windowsizelarge, cliplimit);
    newImg_3 = myCLAHE(img, windowsizesmall, cliplimit);
    subplot(1,2,1), showImage(newImg_2, "Larger Window Size 150x150", 200);
    subplot(1,2,2), showImage(newImg_3, "Smaller Window Size 5x5", 200);
    pause(2);
    newImg_4 = myCLAHE(img, windowsize, cliplimit);
    newImg_5 = myCLAHE(img, windowsize, cliplimit/2);
    subplot(1,2,1), showImage(newImg_4, "CLAHE Enhanced Image with Initial Clip Limit", 200);
    subplot(1,2,2), showImage(newImg_5, "CLAHE Enhanced Image with Clip Limit Halved", 200);
    pause(2);

    
    img = imread("../data/chestXray.png");
    windowsize = [30 30];
    windowsizelarge = [100 100];
    windowsizesmall = [10 10];
    cliplimit = 20;
    newImg_1 = myCLAHE(img, windowsize, cliplimit);
    subplot(1,2,1), showImage(img, "Original Image", 200);
    subplot(1,2,2), showImage(newImg_1, "CLAHE Enhanced Image", 200);
    pause(2);
    newImg_2 = myCLAHE(img, windowsizelarge, cliplimit);
    newImg_3 = myCLAHE(img, windowsizesmall, cliplimit),;
    subplot(1,2,1), showImage(newImg_2, "Larger Window Size 100x100", 200);
    subplot(1,2,2), showImage(newImg_3, "Smaller Window Size 10x10", 200);
    pause(2);
    newImg_4 = myCLAHE(img, windowsize, cliplimit);
    newImg_5 = myCLAHE(img, windowsize, cliplimit/2);
    subplot(1,2,1), showImage(newImg_4, "CLAHE Enhanced Image with Initial Clip Limit", 200);
    subplot(1,2,2), showImage(newImg_5, "CLAHE Enhanced Image with Clip Limit Halved", 200);
    pause(2);

toc;
toc;

% D = dir('*.jpg');
% imcell = cell(1,numel(D));
% for i = 1:numel(D)
%   imcell{i} = imread(D(i).name);
% end


