%% Solution to A5 - Q5
close all

%report
import mlreportgen.report.*
import mlreportgen.dom.*

cd ../report/
R = Report('Report 5.4: Image Denoising using PCA', 'pdf');
open(R)
cd ../code/

T = Text("Assignment 5: Image Restoration");
T.Bold = true;
T.FontSize = '26';
headingObj = Heading1(T);
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading5("Tezan Sahu [170100035] & Siddharth Saha [170100025]");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading6("Due Date: 03/11/2019");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading3("Q4: Image Denoising using PCA");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

sec = Section;
T = Text("Part A");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;
%report

tic;
%% Solution
cd ../data;
im_barbara = double(imread("barbara256-part.png"));
im_stream = double(imread("stream.png"));
cd ../code;

%% For barbara256-part.png:
im_len = size(im_barbara, 1);

% Part (a)

% Adding zero mean Gaussian noise of sd=20
% im1 = min(255, im + uint8(randn(size(im))*20));
im1 = im_barbara + randn(size(im_barbara)) * 20;
im2 = myPCADenoising1(im1, 20);

figure(1)
subplot(131); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title("Original Image"); impixelinfo;
subplot(132); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(133); imshow(im2, [min(im2(:)), max(im2(:))]); title("Denoised Image"); impixelinfo;

% RMSE of noisy image wrt original image
% RMSE of denoised image wrt original image

% RMSE = sqrt(sum(sum(im1 - im_barbara).^2)) / sqrt(sum(sum(im_barbara.^2)));
% RMSE = sqrt(sum(sum(im2 - im_barbara).^2)) / sqrt(sum(sum(im_barbara.^2)));

RMSE = norm(im1-im_barbara)/(norm(im_barbara)*im_len)
RMSE = norm(im2-im_barbara)/(norm(im_barbara)*im_len)

% RMSE = sqrt(immse(im1,im_barbara)/sum(sum((im_barbara).^2)))
% RMSE = sqrt(immse(im2,im_barbara)/sum(sum((im_barbara).^2)))

%% Part (b)
% im1 from part (a) has zero mean Gaussian noise of sd=20
% im1 = im_barbara + randn(size(im_barbara)) * 20;
im2 = myPCADenoising2(im1, 20);

% Trying random stuff
% im2 = im2.*norm(im_barbara)/norm(im2);
% im_barbara = rescale(im_barbara, 0, 255);
% im1 = rescale(im1, 0, 255);
% im2 = rescale(im2, min(im_barbara(:)), max(im_barbara(:)));

figure(2)
subplot(131); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title("Original Image"); impixelinfo;
subplot(132); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(133); imshow(im2, [min(im2(:)), max(im2(:))]); title("Denoised Image"); impixelinfo;

% RMSE of noisy image wrt original image
% RMSE of denoised image wrt original image

% RMSE = sqrt(sum(sum(im1 - im_barbara).^2)) / sqrt(sum(sum(im_barbara.^2)));
% RMSE = sqrt(sum(sum(im2 - im_barbara).^2)) / sqrt(sum(sum(im_barbara.^2)));

RMSE = norm(im1-im_barbara)/(norm(im_barbara)*im_len)
RMSE = norm(im2-im_barbara)/(norm(im_barbara)*im_len)

% RMSE = sqrt(immse(im1,im_barbara)/sum(sum((im_barbara).^2)))
% RMSE = sqrt(immse(im2,im_barbara)/sum(sum((im_barbara).^2)))

toc;
tic;
%% Part (c)
im2 = myBilateralFiltering(im1./max(im1), 7, 1, 0.4);
figure(3)
subplot(131); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title("Original Image"); impixelinfo;
subplot(132); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(133); imshow(im2, [min(im2(:)), max(im2(:))]); title("Bilateral Filtered Image"); impixelinfo;

%% Part (d)
im1 = poissrnd(im_barbara);
im1 = sqrt(im1+3/8);
shifted_im2 = myPCADenoising2(im1, 1/4);
im2 = shifted_im2.^2 - 3/8;

figure(4)
subplot(231); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title("Original Image (poissrnd(im))"); impixelinfo;
subplot(232); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image (poissrnd(im))"); impixelinfo;
subplot(233); imshow(im2, [min(im2(:)), max(im2(:))]); title("Denoised Image (poissrnd(im))"); impixelinfo;

RMSE = norm(im1-im_barbara)/(norm(im_barbara)*im_len)
RMSE = norm(im2-im_barbara)/(norm(im_barbara)*im_len)

% Second subpart - with lower exposure time
im1 = poissrnd(im_barbara./20);
im1 = sqrt(im1+3/8);
shifted_im2 = myPCADenoising2(im1, 1/4);
im2 = shifted_im2.^2 - 3/8;

subplot(234); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title("Original Image (poissrnd(im/20))"); impixelinfo;
subplot(235); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image (poissrnd(im/20))"); impixelinfo;
subplot(236); imshow(im2, [min(im2(:)), max(im2(:))]); title("Denoised Image (poissrnd(im/20))"); impixelinfo;

RMSE = norm(im1-im_barbara)/(norm(im_barbara)*im_len)
RMSE = norm(im2-im_barbara)/(norm(im_barbara)*im_len)



%% For stream.png:
%% Part (a)
% Adding zero mean Gaussian noise of sd=20
% im1 = min(255, im + uint8(randn(size(im))*20));
% im1 = im_stream + randn(size(im_stream)) * 20;
% % imshow(im1, [min(im1(:)), max(im1(:))]); impixelinfo;
% im2 = myPCADenoising1(im1, 20);
% figure(5)
% subplot(131); imshow(im_stream, [min(im_stream(:)), max(im_stream(:))]); title("Original Image"); impixelinfo;
% subplot(132); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
% subplot(133); imshow(im2, [min(im2(:)), max(im2(:))]); title("Denoised Image"); impixelinfo;
% 
% % RMSE of noisy image wrt original image
% % RMSE = sqrt(sum(sum(im1 - im_stream).^2)) / sqrt(sum(sum(im_stream.^2)));
% RMSE = norm(im1-im_stream)/norm(im_stream)
% 
% % RMSE of denoised image wrt original image
% % RMSE = sqrt(sum(sum(im2 - im_stream).^2)) / sqrt(sum(sum(im_stream.^2)));
% RMSE = norm(im2-im_stream)/norm(im_stream)

%% Part (b)


%% Part (c)

% im2 = myBilateralFiltering(im1./max(im1), 7, 1, 0.4);
% figure(7)
% subplot(131); imshow(im_stream, [min(im_stream(:)), max(im_stream(:))]); title("Original Image"); impixelinfo;
% subplot(132); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
% subplot(133); imshow(im2, [min(im2(:)), max(im2(:))]); title("Bilateral Filtered Image"); impixelinfo;

%% Part (d)



%report
add(R, sec)

close(R)
%report
toc;
