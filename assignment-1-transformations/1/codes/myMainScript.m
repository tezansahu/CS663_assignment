%% MyMainScript
%% Running this script will create an 'output' folder, which will contain all
%% the processed images for Q1
pkg load image
%% Your code here
cd ..;
mkdir images;
cd codes;
%% Part (a): Image Shrinking
tic;
img_a = imread("../data/circles_concentric.png");
d = [2, 3];
for i = 1:1:size(d)(2)
  smallImage = myShrinkImageByFactorD(img_a, d(i));
  heading = strcat("Image Shrinking [d=", num2str(d(i)), "]");
  subplot(1,2,1), showImage(img_a, "Original Image");
  subplot(1,2,2), showImage(smallImage, heading);
  cd ../images/;
  imwrite(smallImage, strcat("circles_concentric_d_", num2str(d(i))), "png");
  %% save ("-", strcat("circles_concentric_d_", num2str(d(i)), ".mat"), "smallImage");
  cd ../codes;
  pause(2);
endfor;
toc;


%% Part (b): Image Enlarging by Bilinear Interpolation
tic;
img_b = imread("../data/barbaraSmall.png");
newImg = myBilinearInterpolation(img_b);
subplot(1,2,1), showImage(img_b, "Original Image");
subplot(1,2,2), showImage(newImg, "Image Enlarging using Bilinear Interpolation");
cd ../images/;
imwrite(newImg, "barbaraEnlargedBilinearInterpolation", "png");
%% save "barbaraEnlargedBilinearInterpolation.mat" newImg;
cd ../codes;
pause(2);
toc;

%% Part (c): Image Enlarging by Nearest Neighbor Interpolation
tic;
img_c = imread("../data/barbaraSmall.png");
newImg = myNearestNeighborInterpolation(img_c);
subplot(1,2,1), showImage(img_c, "Original Image");
subplot(1,2,2), showImage(newImg, "Image Enlarging using Nearest Neighbor Interpolation");
cd ../images/;
imwrite(newImg, "barbaraEnlargedNearestNeighborInterpolation", "png");
%% save "barbaraEnlargedNearestNeighborInterpolation.mat" newImg;
cd ../codes;
pause(2);
toc;
