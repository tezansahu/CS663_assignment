%% MyMainScript

tic;
%% Your code here

bird = imread('../data/bird.jpg');
scaling = 0.4;
bird = imresize(bird, scaling);
flower = imread('../data/flower.jpg');
scaling2 = 0.7;
flower = imresize(flower, scaling2);

tic;
%% For bird ->
d_thres = 40;
r_min = round(75*scaling);
r_max = round(650*scaling);
c_min = round(230*scaling);
c_max = round(770*scaling);
threshold = 180;
[D, img_mask, bg_mask, img] = mySpatiallyVaryingKernel(bird, d_thres, r_min, r_max, c_min, c_max, threshold);
foreground = double(img);
background = double(img);
chan = size(img, 3);
for i=1:chan
   foreground(:,:,i) = immultiply(img_mask, img(:,:,i));
   background(:,:,i) = immultiply(bg_mask, img(:,:,i));
end

figure(1);
subplot(1,3,1);
color(img_mask);
title('a) Mask M');
subplot(1,3,2);
color(foreground);
title('b) Foreground');
subplot(1,3,3);
color(background);
title('c) Background');

% imwrite(img_mask, '../images/bird_mask.png');
% imwrite(foreground, '../images/bird_foreground.png');
% imwrite(background, '../images/bird_background.png');
% pause(2);
% close;

figure(2);
contour(flipud(D), 'ShowText', 'on');
% saveas(gcf, '../images/bird_contour.png');
% pause(2);

%figure(3);
% Need to display these...
% fspecial('disk', round(0.2*d_thres))
% pause(2);
% fspecial('disk', round(0.4*d_thres))
% pause(2);
% fspecial('disk', round(0.6*d_thres))
% pause(2);
% fspecial('disk', round(0.8*d_thres))
% pause(2);
% fspecial('disk', round(d_thres))
% pause(2);

figure(4);
color(img);
title('Spatially varying blurred image');
% imwrite(img, '../images/bird_blurred.png');
% pause(2);
toc;

%% For flower ->
d_thres = 20;
r_min = round(65*scaling2);
r_max = round(215*scaling2);
c_min = round(150*scaling2);
c_max = round(280*scaling2);
threshold = 100;
[D, img_mask, bg_mask, img] = mySpatiallyVaryingKernel(flower, d_thres, r_min, r_max, c_min, c_max, threshold);
foreground = double(img);
background = double(img);
chan = size(img, 3);
for i=1:chan
   foreground(:,:,i) = immultiply(img_mask, img(:,:,i));
   background(:,:,i) = immultiply(bg_mask, img(:,:,i));
end
figure(5);
subplot(1,3,1);
color(img_mask);
title('a) Mask M');
subplot(1,3,2);
color(foreground);
title('b) Foreground');
subplot(1,3,3);
color(background);
title('c) Background');
% imwrite(img_mask, '../images/flower_mask.png');
% imwrite(foreground, '../images/flower_foreground.png');
% imwrite(background, '../images/flower_background.png');
% pause(2);
% close;

figure(6);
contour(flipud(D), 'ShowText', 'on');
% saveas(gcf, '../images/flower_contour.png');
% pause(2);

% figure(7)
% fspecial('disk', round(0.2*d_thres))
% pause(2);
% fspecial('disk', round(0.4*d_thres))
% pause(2);
% fspecial('disk', round(0.6*d_thres))
% pause(2);
% fspecial('disk', round(0.8*d_thres))
% pause(2);
% fspecial('disk', round(d_thres))
% pause(2);

figure(8);
color(img);
title('Spatially varying blurred image');
% imwrite(img, '../images/flower_blurred.jpg');
% pause(2);
toc;
