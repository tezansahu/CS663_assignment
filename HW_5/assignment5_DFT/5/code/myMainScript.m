%% Solution to A5 - Q5
close all

tic;
%% Solution
cd ../data;
im = (imread("barbara256.png"));
cd ../code;
% Adding zero mean Gaussian noise of sd=20
im1 = min(255, im + uint8(randn(size(im))*20));


toc;
