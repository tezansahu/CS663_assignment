%% MyMainScript

tic;
%% Your code here

%% Part (a): Image Shrinking
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
