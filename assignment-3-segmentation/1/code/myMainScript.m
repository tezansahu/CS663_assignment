%% MyMainScript
import mlreportgen.report.*
import mlreportgen.dom.*

r = Report('../report/Report', 'pdf');

tp = TitlePage; 
tp.Title = 'Assignment 3: Segmentation'; 
tp.Subtitle = 'Q1: Harris Corner Detection'; 
tp.Author = 'Tezan Sahu [170100035], Siddharth Saha [170100025]'; 
add(r,tp); 


tic;
%% Your code here
img = load("../data/boat.mat");
img = double(img.imageOrig)/255;
[dX, dY, eig1, eig2, cornerness] = myHarrisCornerDetector(img, 2/3, 1, 0.001);

fig1 = figure(1);
subplot(1,2,1);
greyscale(dX);
title("Derivative along X axis");
subplot(1,2,2);
greyscale(dY);
title("Derivative along Y axis");
fig = Figure(fig1);
fig.Snapshot.Caption = "Derivatives of boat.mat along X and Y axes";
add(r, fig);


fig2 = figure(2);
subplot(1,2,1);
greyscale(eig1);
title("1st Eigenvalue of Structure Tensor");
subplot(1,2,2);
greyscale(eig2);
title("2nd Eigenvalue of Structure Tensor");
fig = Figure(fig2);
fig.Snapshot.Caption = "Eigenvalues of Structure Tensor for boat.mat";
add(r, fig);

fig3 = figure(3);
subplot(1,2,1);
greyscale(img);
title("Original Image");
subplot(1,2,2);
greyscale(cornerness);
title("Harris Cornerness"); 
fig = Figure(fig3);
fig.Snapshot.Caption = "Corners detected using Harric Corner Detection Algorithm";
add(r, fig);

toc;

close(r);
% rptview(r);