%% MyMainScript

%% Your code here

%% Part (a): Image Shrinking
tic;
img_a = imread("../data/circles_concentric.png");
showImage(img_a, "Original Image");
%%pause(2);
d = [2, 3];
for i = 1:1:size(d)(2)
  smallImage = myShrinkImageByFactorD(img_a, d(i));
  heading = strcat("Image Shrinking [d=", num2str(i), "]");
  showImage(smallImage, heading);
  %%pause(2);
endfor;
toc;


%% Part (b): Image Enlarging by Bilear Interpolation
tic;
img_b = imread("../data/barbaraSmall.png");
showImage(img_b, "Original Image");
%%pause(2);
newImg = myBilinearInterpolation(img_b);
showImage(newImg, "Image Enlarging using Bilear Interpolation");
%%pause(2);
toc;
