import mlreportgen.report.*
import mlreportgen.dom.*

cd ../report/
R = Report('Report 3.1: Harris Corner Detection', 'pdf');
open(R)
cd ../code/

T = Text("Mean Shift Segmentation");
T.Bold = true;
T.FontSize = '26';
headingObj = Heading1(T);
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading5("Tezan Sahu");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading5("Siddharth Saha");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading6("Due Date: 08/09/2019");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

%% Harris Corner Detection
tic;

img = load("../data/boat.mat");
img = double(img.imageOrig)/255;
[dX, dY, eig1, eig2, cornerness] = myHarrisCornerDetector(img, 1, 2, 0.005);

figure(1);
subplot(1,2,1);
greyscale(dX);
title("Derivative along X axis");
subplot(1,2,2);
greyscale(dY);
title("Derivative along Y axis");
add(R, Figure)

figure(2);
subplot(1,2,1);
greyscale(eig1);
title("1st Eigenvalue of Structure Tensor");
subplot(1,2,2);
greyscale(eig2);
title("2nd Eigenvalue of Structure Tensor");
add(R, Figure)

figure(3);
subplot(1,2,1);
greyscale(img);
title("Original Image");
subplot(1,2,2);
greyscale(cornerness);
title("Harris Cornerness"); 
add(R, Figure)
toc;

T1 = Text("Gaussian kernel bandwidth for the color feature: 20");
T2 = Text("Gaussian kernel bandwidth for the spatial feature: 1");
T3 = Text("Number of iterations: 25");
T4 = Text("Time taken to execute: "+toc);
T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';
T4.FontSize = '14';
add(R, T1)
add(R, T2)
add(R, T3)
add(R, T4)
close(R)
