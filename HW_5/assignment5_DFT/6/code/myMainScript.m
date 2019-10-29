%% MyMainScript

tic;
%% Your code here
I = zeros(300);
I(50:100, 50:120) = 255;
J = zeros(300);
J(120:170, 20:90) = 255;
figure(1);
subplot(121); imshow(I); title("Image I"); subplot(122); imshow(J); title("Image J");

f1 = fftshift(fft2(I)); f2 = fftshift(fft2(J));
f = (f1 .* conj(f2))./(abs(f1 .* f2));
lf = log(abs(f) + 1);
figure(2); imshow(lf, [min(lf(:)), max(lf(:))]); colormap jet; colorbar; impixelinfo; title("log(|F(u,v)| + 1) [This should be constant]")
g = real(ifft2(f));
figure(3);
imshow(g/max(g(:))); title("Shift neede for Restoration")
impixelinfo;


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
