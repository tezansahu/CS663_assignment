%% MyMainScript

tic;
%% Your code here

clear;
close all;
A = zeros(512);
B = A;
A(50:100,50:100) = 1;
B(120:170,20:70) = 1;

figure(1); imshow(A); figure(2); imshow(B);

FA = fftshift(fft2(A));
lFA = log(abs(FA)+1); figure(3); imshow(lFA,[min(lFA(:)) max(lFA(:))]); colormap('jet'); colorbar;
FB = fftshift(fft2(B));
lFB = log(abs(FB)+1); figure(4); imshow(lFB,[min(lFB(:)) max(lFB(:))]); colormap('jet'); colorbar;
pause(1);

FC = ((FA)'.*FB)./(abs(FA.*FB));
C = ifft2((FC));
figure; imshow(C/max(C(:)));
impixelinfo;


% In probability theory and statistics, a collection of random variables is independent and identically 
% distributed if each random variable has the same probability distribution as the others and all are mutually
% independent. This property is usually abbreviated as i.i.d. or iid or IID

% How to add zero mean Gaussian noise of sd=20
% im1 = im + randn(size(im))*20;


toc;
