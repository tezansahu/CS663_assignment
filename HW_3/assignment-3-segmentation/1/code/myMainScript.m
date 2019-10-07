import mlreportgen.report.*
import mlreportgen.dom.*

cd ../report/
R = Report('Report 3.1: Harris Corner Detection', 'pdf');
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

% headingObj = Heading5("");
% headingObj.Style = { HAlign('center') };
% add(R, headingObj)

headingObj = Heading6("Due Date: 08/09/2019");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading3("Q1: Harris Corner Detection");
headingObj.Style = { HAlign('center') };
add(R, headingObj)



sec = Section;
T = Text("Images");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;
%% Harris Corner Detection
tic;

img = load("../data/boat.mat");
img = double(img.imageOrig)/255;

sigma1 = 2/3;
sigma2 = 1.2;
k = 0.001;

[dX, dY, eig1, eig2, cornerness] = myHarrisCornerDetector(img, sigma1, sigma2, k);

image = Image("../images/boat.png");
add(R,image);

fig1 = figure(1);
subplot(1,2,1);
greyscale(dX);
title("Derivative along X axis");
subplot(1,2,2);
greyscale(dY);
title("Derivative along Y axis");
caption = Paragraph("Fig 1: Derivatives of boat.mat along X and Y axes");
caption.Style = {HAlign('center')};


add(sec, Figure(fig1))
add(sec, caption);


fig2 = figure(2);
subplot(1,2,1);
greyscale(eig1);
title("1st Eigenvalue of Structure Tensor");
subplot(1,2,2);
greyscale(eig2);
title("2nd Eigenvalue of Structure Tensor");
caption = Text("Fig 2: Eigenvalues of Structure Tensor for boat.mat");
caption.Style = {HAlign('center')};

add(sec, Figure(fig2))
add(sec, caption)

fig3 = figure(3);
% subplot(1,2,1);
% greyscale(img);
% title("Original Image");
% subplot(1,2,2);
greyscale(cornerness);
title("Harris Cornerness"); 
caption = Text("Fig 3: Corners detected using Harris Corner Detection Algorithm");
caption.Style = {HAlign('center')};

add(sec, Figure(fig3))
add(sec, caption)
add(R, sec);
toc;

sec = Section;
T0 = Text("Parameters Used:");
T1 = Text("Sigma for 1st Gaussian smoothing: " + num2str(sigma1));
T2 = Text("Sigma for 1st Gaussian smoothing: " + num2str(sigma2));
T3 = Text("Constant 'k' in the cornerness measure: " + num2str(k));
T4 = Text("Time taken to execute: "+toc);


T0.Bold = true;
T0.FontSize = '18';

T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';
T4.FontSize = '14';

sec.Title = T0;

ul = UnorderedList({T1, T2, T3});
add(sec, ul);
add(R, sec);

close(R)

