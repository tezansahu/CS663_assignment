%% MyMainScript
clear;
close all;

import mlreportgen.report.*
import mlreportgen.dom.*

cd ../report/
R = Report('Report 4.2: Reconstruction and Eigenfaces', 'pdf');
open(R)
cd ../code/

T = Text("Assignment 4: Mini Face Recognition System");
T.Bold = true;
T.FontSize = '26';
headingObj = Heading1(T);
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading5("Tezan Sahu [170100035] & Siddharth Saha [170100025]");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading6("Due Date: 16/10/2019");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

headingObj = Heading3("Q2: Reconstruction and Eigenfaces");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

sec = Section;
T = Text("Plots");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;

tic;
%% ORL Dataset
% Training
N = 32*6; d = 112*92;
X = zeros(d, N); % Matrix of all the images d x N
x_bar = zeros(d, 1); % Average image d x 1
cd ../../..;
for i=1:32 
    D = strcat('ORL_dataset/s',int2str(i));
    S = dir(fullfile(D,'*.pgm'));
    for j=1:6
        F = fullfile(D, S(j).name);
        I = im2double(imread(F));
        X(:, (i-1)*6+j) = I(:);
        x_bar = x_bar + I(:);
    end
end
x_bar = x_bar./N;
for i=1:N
    X(:, i) = X(:, i) - x_bar;
end

[U_k, ~] = svds(X, 175); % U-Left singular vectors d x k; S-Singular value matrix d x k; [U, S]
alpha_k = U_k'*X(:,1); % Eigencoefficients k x 1; X is d x N
% alpha_k has been calculated only for first datapoint

kvals = [2, 10, 20, 50, 75, 100, 125, 150, 175];
len_k = length(kvals);

% Reconstructing first datapoint in X
fig1 = figure(1);
for k_idx = 1:len_k
    k = kvals(k_idx);
    reconst_img = U_k(:,1:k)*alpha_k(1:k,1);
    I = reshape(reconst_img,[],92);
    subplot(3,3,k_idx), imshow(I);
    title(strcat('k=',num2str(k)));
end

caption = Paragraph("Fig 1: Face Reconstruction of the first person in the ORL database using increasing values of k");
caption.Style = {HAlign('center')};

add(sec, Figure(fig1))
add(sec, caption);


% Plotting first 25 eigenfaces
fig2 = figure(2);
for k=1:25
    I = histeq(reshape(U_k(:,k),[],92));
    subplot(5,5,k), imshow(I);
    title(strcat('Order=',num2str(k)));
end

caption = Paragraph("Fig 2: Eigenfaces corresponding to the 25 largest eigenvalues");
caption.Style = {HAlign('center')};

add(sec, Figure(fig2))
add(sec, caption);


add(R, sec);

toc; % Nearly 11 seconds
close(R);