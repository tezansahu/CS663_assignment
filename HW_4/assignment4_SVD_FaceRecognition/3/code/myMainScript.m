%% MyMainScript
clear;
close all;

import mlreportgen.report.*
import mlreportgen.dom.*

cd ../report/
R = Report('Report 4.3: Detection of known and unknown faces', 'pdf');
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

headingObj = Heading3("Q3: Detection of known and unknown faces");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

%% Section 1
sec = Section;
T = Text("Detection Mechanism");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;

textObj = Text("For a particular value of k, compute eigencoefficients corresponding to k highest eigenvalues for all persons in the training set. For different images of the same person in training set, find maximum norm of difference in eigencoefficient vectors. Let this be maximum deviation per person. Take a mean of the deviation per person across all persons and assign it as the threshold deviation (A scaling constant may be multiplied to optimise detection rates). If the minimum norm of difference in eigencoefficient vectors of the probe image with the training images is below the threshold value, the person is classified as a known face, otherwise unknown.");
add(sec, textObj);

add(R, sec);

%% Section 2
sec = Section;
T = Text("Results");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;

tic;

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

[U, ~, ~] = svd(X, 0); % U-Left singular vectors d x N; S-Singular value matrix d x N; [U, S, V]

k = 100;
% For k largest eigenvalues
U_k = U(:, 1:k); % d x k
alpha_k = U_k'*X; % Eigencoefficients k x N

deviation_per_person = zeros(32,1); % Deviation from eigencoefficient per person

for i=1:32
    for j=1:5
        for m=j+1:6
            if norm(alpha_k(:,(i-1)*6+j) - alpha_k(:,(i-1)*6+m)) > deviation_per_person(i)
                deviation_per_person(i) = norm(alpha_k(:,(i-1)*6+j) - alpha_k(:,(i-1)*6+m));
            end
        end        
    end
end

thres_devn = 0.85*min(deviation_per_person);
% thres_devn = 0;

% Testing for false negatives
test_N = 32*4;
false_neg = 0;
for i=1:32 
    D = strcat('ORL_dataset/s',int2str(i));
    S = dir(fullfile(D,'*.pgm'));
    for j=7:10
        F = fullfile(D, S(j).name);
        I = im2double(imread(F));
        z_p = I(:) - x_bar; % Mean probe image
        alpha_p = U_k'*z_p; % Eigencoefficient of probe image
        min_index = 1;
        min_dist = norm(alpha_p - alpha_k(:,1));
        for l = 2:N
            if norm(alpha_p - alpha_k(:,l)) < min_dist
                min_dist = norm(alpha_p - alpha_k(:,l));
            end
        end
        if min_dist > thres_devn
            false_neg = false_neg + 1;
        end
    end
end
false_neg = false_neg/test_N;
fprintf ('For k= %d, false negative rate = %f\n',k,100*false_neg);
textObj = Text("For k= "+num2str(k)+", false negative rate = "+num2str(100*false_neg)+"%");
add(sec,textObj);

% Testing for false negatives
test_N = 8*10;
false_pos = 0;
for i=33:40 
    D = strcat('ORL_dataset/s',int2str(i));
    S = dir(fullfile(D,'*.pgm'));
    for j=1:10
        F = fullfile(D, S(j).name);
        I = im2double(imread(F));
        z_p = I(:) - x_bar; % Mean probe image
        alpha_p = U_k'*z_p; % Eigencoefficient of probe image
        min_index = 1;
        min_dist = norm(alpha_p - alpha_k(:,1));
        for l = 2:N
            if norm(alpha_p - alpha_k(:,l)) < min_dist
                min_dist = norm(alpha_p - alpha_k(:,l));
            end
        end
        if min_dist < thres_devn
            false_pos = false_pos + 1;
        end
    end
end
false_pos = false_pos/test_N;
fprintf ('For k= %d, false positive rate = %f\n',k,100*false_pos);
textObj = Text("For k= "+num2str(k)+", false positive rate = "+num2str(100*false_pos)+"%");
add(sec,textObj);

textObj = Text("Threshold distance value (Norm of deviation from eigencoefficients)= "+num2str(thres_devn));
add(sec,textObj);

add(R, sec);

toc; % Nearly 1 second
close(R);