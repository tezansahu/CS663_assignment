%% MyMainScript
cd ..;
mkdir images/;
cd codes/;
tic;
% images = [imread("../data/barbara.png"), imread("../data/TEM.png"), imread("../data/canyon.png"), ...
%     imread("../data/retina.png"), imread("../data/church.png"), imread("../data/chestXray.png"),...
%     imread("../data/statue.png")];
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

img = imread("../data/barbara.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myLinearContrastStretching(img, ones(size(img,1), size(img,2))), "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/TEM.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myLinearContrastStretching(img, ones(size(img,1), size(img,2))), "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/canyon.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myLinearContrastStretching(img, ones(size(img,1), size(img,2))), "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/church.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myLinearContrastStretching(img, ones(size(img,1), size(img,2))), "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/chestXray.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myLinearContrastStretching(img, ones(size(img,1), size(img,2))), "Linear Contrast Stretched Image", 200);
pause(2);

    
img = imread("../data/statue.png");
imgMask = imread("../data/retinaMask.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myLinearContrastStretching(img, imgMask), "Linear Contrast Stretched Image", 200);
pause(2);

toc;
% function [newImg] = myLinearContrastStretching(img, mask)

%% Part (c) Histogram Equalisation
tic;

img = imread("../data/barbara.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myHE(img, ones(size(img,1), size(img,2))), "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/TEM.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myHE(img, ones(size(img,1), size(img,2))), "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/canyon.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myHE(img, ones(size(img,1), size(img,2))), "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/church.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myHE(img, ones(size(img,1), size(img,2))), "Linear Contrast Stretched Image", 200);
pause(2);

img = imread("../data/chestXray.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myHE(img, ones(size(img,1), size(img,2))), "Linear Contrast Stretched Image", 200);
pause(2);

    
img = imread("../data/statue.png");
imgMask = imread("../data/retinaMask.png");
subplot(1,2,1), showImage(img, "Original Image", 200);
subplot(1,2,2), showImage(myHE(img, imgMask), "Linear Contrast Stretched Image", 200);
pause(2);


toc;
% function [newImg] = myHE(img, mask)

%% Part (d) Histogram Matching
tic;
    img = imread("../data/retina.png");
    imgMask = imread("../data/retinaMask.png");
    ref = imread("../data/retinaRef.png");
    refMask = imread("../data/retinaRefMask.png");
    subplot(1,3,1), showImage(img, "Original Image", 200);
    subplot(1,3,2), showImage(myHM(img, imgMask, ref, refMask), "Histogram Matched Image", 200);
    subplot(1,3,3), showImage(myHE(img, imgMask), "Histogram Equalised Image", 200);
%     cd ../images/;
%     save mask.mat mask;
%     save masked_image.mat masked_image;
%     cd ../codes;
    pause(2);
toc;
% function [newImg] = myHM(img, imgMask, ref, refMask)

%% Part (e) Contrast Limited Adaptive Histogram Equalisation
tic;
% inputs = [1 2 3 6];

    img = imread("../data/barbara.png");
    windowsize = [30 30];
    windowsizelarge = [100 100];
    windowsizesmall = [5 5];
    cliplimit = 4;
    subplot(1,2,1), showImage(img, "Original Image", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsize, cliplimit), "CLAHE Enhanced Image", 200);
    pause(2);
    subplot(1,2,1), showImage(myCLAHE(img, windowsizesmall, cliplimit), "Larger Window Size 100x100", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsizesmall, cliplimit), "Smaller Window Size 5x5", 200);
    pause(2);
    subplot(1,2,1), showImage(myCLAHE(img, windowsize, cliplimit), "CLAHE Enhanced Image with Initial Clip Limit", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsize, cliplimit/2), "CLAHE Enhanced Image with Clip Limit Halved", 200);
    pause(2);
    
    img = imread("../data/TEM.png");
    windowsize = [30 30];
    windowsizelarge = [100 100];
    windowsizesmall = [5 5];
    cliplimit = 4;
    subplot(1,2,1), showImage(img, "Original Image", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsize, cliplimit), "CLAHE Enhanced Image", 200);
    pause(2);
    subplot(1,2,1), showImage(myCLAHE(img, windowsizesmall, cliplimit), "Larger Window Size 100x100", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsizesmall, cliplimit), "Smaller Window Size 5x5", 200);
    pause(2);
    subplot(1,2,1), showImage(myCLAHE(img, windowsize, cliplimit), "CLAHE Enhanced Image with Initial Clip Limit", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsize, cliplimit/2), "CLAHE Enhanced Image with Clip Limit Halved", 200);
    pause(2);
    
    img = imread("../data/canyon.png");
    windowsize = [30 30];
    windowsizelarge = [100 100];
    windowsizesmall = [5 5];
    cliplimit = 4;
    subplot(1,2,1), showImage(img, "Original Image", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsize, cliplimit), "CLAHE Enhanced Image", 200);
    pause(2);
    subplot(1,2,1), showImage(myCLAHE(img, windowsizesmall, cliplimit), "Larger Window Size 100x100", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsizesmall, cliplimit), "Smaller Window Size 5x5", 200);
    pause(2);
    subplot(1,2,1), showImage(myCLAHE(img, windowsize, cliplimit), "CLAHE Enhanced Image with Initial Clip Limit", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsize, cliplimit/2), "CLAHE Enhanced Image with Clip Limit Halved", 200);
    pause(2);
    
    img = imread("../data/chestXray.png");
    windowsize = [30 30];
    windowsizelarge = [100 100];
    windowsizesmall = [5 5];
    cliplimit = 4;
    subplot(1,2,1), showImage(img, "Original Image", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsize, cliplimit), "CLAHE Enhanced Image", 200);
    pause(2);
    subplot(1,2,1), showImage(myCLAHE(img, windowsizesmall, cliplimit), "Larger Window Size 100x100", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsizesmall, cliplimit), "Smaller Window Size 5x5", 200);
    pause(2);
    subplot(1,2,1), showImage(myCLAHE(img, windowsize, cliplimit), "CLAHE Enhanced Image with Initial Clip Limit", 200);
    subplot(1,2,2), showImage(myCLAHE(img, windowsize, cliplimit/2), "CLAHE Enhanced Image with Clip Limit Halved", 200);
    pause(2);

toc;
toc;

% D = dir('*.jpg');
% imcell = cell(1,numel(D));
% for i = 1:numel(D)
%   imcell{i} = imread(D(i).name);
% end


