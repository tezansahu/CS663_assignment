%% MyMainScript

tic;
%% Solution
cd ../data;
im = imread("barbara256-part.png");

% Adding zero mean Gaussian noise of sd=20
im1 = im + randn(size(im))*20;


toc;
