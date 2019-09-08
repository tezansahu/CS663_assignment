import mlreportgen.report.*
import mlreportgen.dom.*

cd ../report/
R = Report('Report 3.2: Mean Shift Segmentation', 'pdf');
open(R)
cd ../code/

T = Text("Assignment 3: Segmentation");
T.Bold = true;
T.FontSize = '26';
headingObj = Heading1(T);
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading5("Tezan Sahu [170100035] & Siddharth Saha [170100025]");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

% headingObj = Heading5("Siddharth Saha");
% headingObj.Style = { HAlign('center') };
% add(R, headingObj)

headingObj = Heading6("Due Date: 08/09/2019");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading3("Q2: Mean Shift Segmentation");
headingObj.Style = { HAlign('center') };
add(R, headingObj)


sec = Section;
T = Text("Images");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;
%% Image Segmentation Using Mean Shift
tic;

img = imread("../data/flower.png");
h_space = 100;
h_color = 1;
num_neighbors = 200;
max_iter = 15;

out_img = myMeanShiftSegmentation(img, h_space, h_color, num_neighbors, max_iter);
image = Image("../images/flower.png");
add(R, image);
fig1 = figure(1);
subplot(1,2,1);
color(img);
title("Original Image");
subplot(1,2,2);
color(out_img);
title("Segmented Image");
caption = Paragraph("Fig 1: Mean Shift Segmentation applied to flower.png");
caption.Style = {HAlign('center')};

toc;

add(sec, Figure(fig1));
add(sec, caption);


fig2 = figure(2);
subplot(1,2,1);
plotIntensities(double(img)/255);
title("Original Pixel Intensities");
subplot(1,2,2);
plotIntensities(out_img);
title("Pixel Intensities after Segmentation");
caption = Paragraph("Fig 2: Pixel intensities before & after applying segmentation");
caption.Style = {HAlign('center')};
add(sec, Figure(fig2));
add(sec, caption);
add(R, sec);


sec = Section;
T0 = Text("Parameters Used:");
T1 = Text("Gaussian kernel bandwidth for the color feature: " + num2str(h_color));
T2 = Text("Gaussian kernel bandwidth for the spatial feature: " + num2str(h_space));
T3 = Text("Number of iterations: " + num2str(max_iter));
T4 = Text("Number of Nearest Neighbors considered: "+ num2str(num_neighbors));

T0.Bold = true;
T0.FontSize = '18';
T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';
T4.FontSize = '14';

sec.Title = T0;

ul = UnorderedList({T1, T2, T4, T3});
add(sec, ul);
add(R, sec);
% add(R, T1)
% add(R, T2)
% add(R, T3)
% add(R, T4)
close(R)
