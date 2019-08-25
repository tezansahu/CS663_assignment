%% MyMainScript

tic;
%% Your code here
img = imread("../data/test.png");
newImg = myBiHistogramEqualization(img);

cd ../
mkdir images
cd images
save test_biHE.mat newImg;

toc;
