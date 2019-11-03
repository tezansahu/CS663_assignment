%% Solution to A5 - Q5
close all

%report
import mlreportgen.report.*
import mlreportgen.dom.*

cd ../report/
R = Report('Report 5.5: Image Denoising using PCA', 'pdf');
open(R)
cd ../code/

T = Text("Assignment 5: Discrete Fourier Transform");
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

headingObj = Heading3("Q5: Image Denoising using PCA");
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
im_stream = im_stream(1:128,1:128);
cd ../code;
im_len = 128; % = size(im_barbara, 1) = size(im_stream, 1)

%% Part (a)

% BARBARA

% Adding zero mean Gaussian noise of sd=20
im1 = im_barbara + randn(size(im_barbara)) * 20;
im2 = myPCADenoising1(im1, 20);

fig1 = figure(1);
subplot(231); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title("Original Image"); impixelinfo;
subplot(232); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(233); imshow(im2, [min(im2(:)), max(im2(:))]); title("Denoised Image"); impixelinfo;

RMSE_1 = norm(im1-im_barbara)/(norm(im_barbara))
RMSE_2 = norm(im2-im_barbara)/(norm(im_barbara))

% STREAM

% Adding zero mean Gaussian noise of sd=20
im1 = im_stream + randn(size(im_stream)) * 20;
im2 = myPCADenoising1(im1, 20);

subplot(234); imshow(im_stream, [min(im_stream(:)), max(im_stream(:))]); title("Original Image"); impixelinfo;
subplot(235); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(236); imshow(im2, [min(im2(:)), max(im2(:))]); title("Denoised Image"); impixelinfo;

RMSE_3 = norm(im1-im_stream)/(norm(im_stream))
RMSE_4 = norm(im2-im_stream)/(norm(im_stream))

%report
caption = Paragraph("Fig 1: Global PCA Denoising of zero mean white Gaussian noise");
caption.Style = {HAlign('center')};

add(sec, Figure(fig1))
add(sec, caption);

T_bar = Text("For Barbara");
T_str = Text("For Stream");
T1 = Text("RMSE of Noisy image: " + RMSE_1);
T2 = Text("RMSE of Denoised image: " + RMSE_2);
T3 = Text("RMSE of Noisy image: " + RMSE_3);
T4 = Text("RMSE of Denoised image: " + RMSE_4);
T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';
T4.FontSize = '14';

ul = UnorderedList({T1, T2});
add(sec, T_bar);
add(sec, ul);

ul = UnorderedList({T3, T4});
add(sec, T_str);
add(sec, ul);
add(R, sec);

sec = Section;
T = Text("Part B");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;
%report

%% Part (b)

% BARBARA

% Adding zero mean Gaussian noise of sd=20
im1 = im_barbara + randn(size(im_barbara)) * 20;
im2 = myPCADenoising2(im1, 20);

fig2 = figure(2);
subplot(231); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title("Original Image"); impixelinfo;
subplot(232); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(233); imshow(im2, [min(im2(:)), max(im2(:))]); title("Denoised Image"); impixelinfo;

RMSE_1 = norm(im1-im_barbara)/(norm(im_barbara))
RMSE_2 = norm(im2-im_barbara)/(norm(im_barbara))

% STREAM

% Adding zero mean Gaussian noise of sd=20
im1 = im_stream + randn(size(im_stream)) * 20;
im2 = myPCADenoising2(im1, 20);

subplot(234); imshow(im_stream, [min(im_stream(:)), max(im_stream(:))]); title("Original Image"); impixelinfo;
subplot(235); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(236); imshow(im2, [min(im2(:)), max(im2(:))]); title("Denoised Image"); impixelinfo;

RMSE_3 = norm(im1-im_stream)/(norm(im_stream))
RMSE_4 = norm(im2-im_stream)/(norm(im_stream))

%report
caption = Paragraph("Fig 2: Local PCA Denoising of zero mean white Gaussian noise");
caption.Style = {HAlign('center')};

add(sec, Figure(fig2))
add(sec, caption);

T_bar = Text("For Barbara");
T_str = Text("For Stream");
T1 = Text("RMSE of Noisy image: " + RMSE_1);
T2 = Text("RMSE of Denoised image: " + RMSE_2);
T3 = Text("RMSE of Noisy image: " + RMSE_3);
T4 = Text("RMSE of Denoised image: " + RMSE_4);
T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';
T4.FontSize = '14';

ul = UnorderedList({T1, T2});
add(sec, T_bar);
add(sec, ul);

ul = UnorderedList({T3, T4});
add(sec, T_str);
add(sec, ul);
add(R, sec);

sec = Section;
T = Text("Part C");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;
%report

%% Part (c)

% BARBARA

% Adding zero mean Gaussian noise of sd=20
im1 = im_barbara + randn(size(im_barbara)) * 20;
im2 = myBilateralFiltering(im1./max(im1), 7, 1, 0.4);

fig3 = figure(3);
subplot(231); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title("Original Image"); impixelinfo;
subplot(232); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(233); imshow(im2, [min(im2(:)), max(im2(:))]); title("Bilateral Filtered Image"); impixelinfo;

% STREAM

% Adding zero mean Gaussian noise of sd=20
im1 = im_stream + randn(size(im_stream)) * 20;
im2 = myBilateralFiltering(im1./max(im1), 7, 1, 0.4);

subplot(234); imshow(im_stream, [min(im_stream(:)), max(im_stream(:))]); title("Original Image"); impixelinfo;
subplot(235); imshow(im1, [min(im1(:)), max(im1(:))]); title("Noisy Image"); impixelinfo;
subplot(236); imshow(im2, [min(im2(:)), max(im2(:))]); title("Bilateral Filtered Image"); impixelinfo;

%report
caption = Paragraph("Fig 3: Bilateral Filtering");
caption.Style = {HAlign('center')};

add(sec, Figure(fig3))
add(sec, caption);

T_bar = Text("Comparison between PCA based approach results with that of the bilateral filter:");
T1 = Text("There is significantly higher degree of staircasing artifacts in the bilateral filter output. In addition, there is a lot more undesired smoothing of textures in case of bilateral filtering. PCA approach does a better job at denoising.");
T2 = Text("In general, bilateral filter has the limitations that texture softer than the intensity-kernel standard deviation are removed and staircase artifacts are introduced.");
T3 = Text("Bilateral filter relies on the assumption that original image is piecewise constant in intensity.");
T4 = Text("PCA based approach makes no such assumption as above. It assumes that given a small enough patch, there exist other patches in the image that are similar to it in structure. It uses the Wiener filter update that attenuates eigencoefficients corresponding to noise and leaves the original image textures unharmed.");
T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';
T4.FontSize = '14';

ul = UnorderedList({T1, T2, T3, T4});
add(sec, T_bar);
add(sec, ul);

add(R, sec);


sec = Section;
T = Text("Part D");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;
%report

%% Part (d)

% BARBARA

% First subpart
im1 = poissrnd(im_barbara);
im1 = sqrt(im1+3/8);
shifted_im2 = myPCADenoising2(im1, 1/4);
im2 = shifted_im2.^2 - 3/8;

fig4 = figure(4);
subplot(231); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title({'a. Original Image', '(poissrnd(im))'}); impixelinfo;
subplot(232); imshow(im1, [min(im1(:)), max(im1(:))]); title({'a. Noisy Image', '(poissrnd(im))'}); impixelinfo;
subplot(233); imshow(im2, [min(im2(:)), max(im2(:))]); title({'a. Denoised Image', '(poissrnd(im))'}); impixelinfo;

RMSE_11 = norm(im1-im_barbara)/(norm(im_barbara)*im_len)
RMSE_12 = norm(im2-im_barbara)/(norm(im_barbara)*im_len)

% Second subpart - with lower exposure time
im1 = poissrnd(im_barbara./20);
im1 = sqrt(im1+3/8);
shifted_im2 = myPCADenoising2(im1, 1/4);
im2 = shifted_im2.^2 - 3/8;

subplot(234); imshow(im_barbara, [min(im_barbara(:)), max(im_barbara(:))]); title({'b. Original Image', '(poissrnd(im/20))'}); impixelinfo;
subplot(235); imshow(im1, [min(im1(:)), max(im1(:))]); title({'b. Noisy Image', '(poissrnd(im/20))'}); impixelinfo;
subplot(236); imshow(im2, [min(im2(:)), max(im2(:))]); title({'b. Denoised Image', '(poissrnd(im/20))'}); impixelinfo;

RMSE_21 = norm(im1-im_barbara)/(norm(im_barbara)*im_len)
RMSE_22 = norm(im2-im_barbara)/(norm(im_barbara)*im_len)

%report
caption = Paragraph("Fig 4: Local PCA Denoising of Poisson noise (barbara)");
caption.Style = {HAlign('center')};

add(sec, Figure(fig4))
add(sec, caption);

T_bar = Text("For Barbara");
T1 = Text("Part a. RMSE of Noisy image: " + RMSE_11);
T2 = Text("Part a. RMSE of Denoised image: " + RMSE_12);
T3 = Text("Part b. RMSE of Noisy image: " + RMSE_21);
T4 = Text("Part b. RMSE of Denoised image: " + RMSE_22);
T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';
T4.FontSize = '14';

ul = UnorderedList({T1, T2, T3, T4});
add(sec, T_bar);
add(sec, ul);
%report

% STREAM

% First subpart
im1 = poissrnd(im_stream);
im1 = sqrt(im1+3/8);
shifted_im2 = myPCADenoising2(im1, 1/4);
im2 = shifted_im2.^2 - 3/8;

fig5 = figure(5);
subplot(231); imshow(im_stream, [min(im_stream(:)), max(im_stream(:))]); title({'a. Original Image', '(poissrnd(im))'}); impixelinfo;
subplot(232); imshow(im1, [min(im1(:)), max(im1(:))]); title({'a. Noisy Image', '(poissrnd(im))'}); impixelinfo;
subplot(233); imshow(im2, [min(im2(:)), max(im2(:))]); title({'a. Denoised Image', '(poissrnd(im))'}); impixelinfo;

RMSE_13 = norm(im1-im_stream)/(norm(im_stream)*im_len)
RMSE_14 = norm(im2-im_stream)/(norm(im_stream)*im_len)

% Second subpart - with lower exposure time
im1 = poissrnd(im_stream./20);
im1 = sqrt(im1+3/8);
shifted_im2 = myPCADenoising2(im1, 1/4);
im2 = shifted_im2.^2 - 3/8;

subplot(234); imshow(im_stream, [min(im_stream(:)), max(im_stream(:))]); title({'b. Original Image', '(poissrnd(im/20))'}); impixelinfo;
subplot(235); imshow(im1, [min(im1(:)), max(im1(:))]); title({'b. Noisy Image', '(poissrnd(im/20))'}); impixelinfo;
subplot(236); imshow(im2, [min(im2(:)), max(im2(:))]); title({'b. Denoised Image', '(poissrnd(im/20))'}); impixelinfo;

RMSE_23 = norm(im1-im_stream)/(norm(im_stream)*im_len)
RMSE_24 = norm(im2-im_stream)/(norm(im_stream)*im_len)


%report
caption = Paragraph("Fig 5: Local PCA Denoising of Poisson noise (stream)");
caption.Style = {HAlign('center')};

add(sec, Figure(fig5))
add(sec, caption);

T_str = Text("For Stream");
T1 = Text("Part a. RMSE of Noisy image: " + RMSE_11);
T2 = Text("Part a. RMSE of Denoised image: " + RMSE_12);
T3 = Text("Part b. RMSE of Noisy image: " + RMSE_21);
T4 = Text("Part b. RMSE of Denoised image: " + RMSE_22);
T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';
T4.FontSize = '14';

ul = UnorderedList({T1, T2, T3, T4});
add(sec, T_bar);
add(sec, ul);

T_bar = Text("Comparison between poissrnd(im) and poissrnd(im/20):");
T1 = Text("The latter actually represents image acquisition with a lower acquisition time and hence lower brightness.");
T2 = Text("We observe that denoising is highly successful in the latter case (corroborated by RMSE values).");
T3 = Text("One possible justification could be that as lower intensity brightness is captured, the magnitude of Poisson noise becomes more and more comparable.");
T4 = Text("In addition, the Anscombe model is more accurate as I(signal variable) tends to infinity. Here we have drastically downscaled the pixel intensities leading to errors in the modelling assumption.");
T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';
T4.FontSize = '14';

ul = UnorderedList({T1, T2, T3, T4});
add(sec, T_bar);
add(sec, ul);

add(R, sec);


sec = Section;
T = Text("Part E");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;

T_bar = Text("Effect of clamping the values in the noisy image 'im1' to the [0,255] range,:");
T1 = Text("");
T2 = Text("");
T3 = Text("");
T4 = Text("");
T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';
T4.FontSize = '14';

ul = UnorderedList({T1, T2, T3, T4});
add(sec, T_bar);
add(sec, ul);

add(R, sec);

close(R)
%report
toc;
