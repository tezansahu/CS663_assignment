import mlreportgen.report.*
import mlreportgen.dom.*

cd ../report/
R = Report('Report 3.2: Mean Shift Segmentation', 'pdf');
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
%% Image Segmentation Using Mean Shift
tic;

img = imread("../data/flower.png");
out_img = myMeanShiftSegmentation(img, 20, 1, 100, 25);

figure(1);
subplot(1,2,1);
color(img);
title("Original Image");
subplot(1,2,2);
color(out_img);
title("Segmented Image");

toc;

add(R, Figure)

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
