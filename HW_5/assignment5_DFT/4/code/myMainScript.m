%% Solution to A5 - Q4
clear;
close all;

%report
import mlreportgen.report.*
import mlreportgen.dom.*

cd ../report/
R = Report('Report 5.4: Low Pass Filters', 'pdf');
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

headingObj = Heading3("Q4: Low Pass Filters");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

sec = Section;
T = Text("Output Images");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;
%report

tic;
%% Your code here
cd ../data;
Z = imread('barbara256.png');
cd ../code;

fig1 = figure(1); imshow(Z, [min(Z(:)) max(Z(:))]); 
title('Original Image');
pause(1);

%report
caption = Paragraph("Fig 1: Original Image");
caption.Style = {HAlign('center')};

add(sec, Figure(fig1))
add(sec, caption);
%report

Z = padarray(Z,[128 128],0);
FZ = fftshift(fft2(Z));
% lFZ = log(abs(FZ)+1);
% figure(2); imshow(lFZ, [min(lFZ(:)) max(lFZ(:))]); colormap('jet'); colorbar;
% title('Original Fourier Transform (Log Magnitude)');
% pause(1);

% Cutoff frequencies/Standard deviations
r = [40, 80];
H1 = zeros(512); % Ideal with cutoff=40
H2 = zeros(512); % Ideal with cutoff=80
H3 = zeros(512); % Gaussian with sd=40
H4 = zeros(512); % Gaussian with sd=80

center = size(H1,1)/2;
for i=1:size(H1,1)
    for j=1:size(H1,2)
        if ((i-center)^2+(j-center)^2) <= r(1)^2
            H1(i, j) = 1;
        end
        if ((i-center)^2+(j-center)^2) <= r(2)^2
            H2(i, j) = 1;
        end
        H3(i, j) = exp(-((i-center)^2+(j-center)^2)/(2*r(1)^2));
        H4(i, j) = exp(-((i-center)^2+(j-center)^2)/(2*r(2)^2));
    end
end

fig2 = figure(2);
new_FZ = FZ.*H1;
new_Z = ifft2(ifftshift(new_FZ));
final_img = new_Z(129:384, 129:384); % Removed padding
subplot(2,2,1); imshow(final_img, [ min(abs(final_img(:))) max(abs(final_img(:))) ]);
title('Ideal (r = 40)');

new_FZ = FZ.*H2;
new_Z = ifft2(ifftshift(new_FZ));
final_img = new_Z(129:384, 129:384); % Removed padding
subplot(2,2,2); imshow(final_img, [ min(abs(final_img(:))) max(abs(final_img(:))) ]);
title('Ideal (r = 80)');

new_FZ = FZ.*H3;
new_Z = ifft2(ifftshift(new_FZ));
final_img = new_Z(129:384, 129:384); % Removed padding
subplot(2,2,3); imshow(final_img, [ min(abs(final_img(:))) max(abs(final_img(:))) ]);
title('Gaussian (\sigma = 40)');

new_FZ = FZ.*H4;
new_Z = ifft2(ifftshift(new_FZ));
final_img = new_Z(129:384, 129:384); % Removed padding
subplot(2,2,4); imshow(final_img, [ min(abs(final_img(:))) max(abs(final_img(:))) ]);
title('Gaussian (\sigma = 80)');

%report
caption = Paragraph("Fig 2: Effect on original image corresponding to filters and parameters");
caption.Style = {HAlign('center')};

add(sec, Figure(fig2))
add(sec, caption);
%report

fig3 = figure(3); 
subplot(2,2,1); imshow(H1, [min(H1(:)) max(H1(:))]); colormap('jet'); colorbar;
title('Ideal (r = 40)');
subplot(2,2,2); imshow(H2, [min(H2(:)) max(H2(:))]); colormap('jet'); colorbar;
title('Ideal (r = 80)');
subplot(2,2,3); imshow(H3, [min(H3(:)) max(H3(:))]); colormap('jet'); colorbar;
title('Gaussian (\sigma = 40)');
subplot(2,2,4); imshow(H4, [min(H4(:)) max(H4(:))]); colormap('jet'); colorbar;
title('Gaussian (\sigma = 80)');
pause(1.5);

%report
caption = Paragraph("Fig 3: Frequency response (in log Fourier format) corresponding to the filters");
caption.Style = {HAlign('center')};

add(sec, Figure(fig3))
add(sec, caption);
%report


%report
add(R, sec)

sec = Section;
T = Text("Differences in Filtered Outputs");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;

T1 = Text("The ideal low-pass filter of smaller radius (r = 40) produces more blur that that with the larger radius (r = 80) since it only allows smaller frequency componentes to pass through.");
T2 = Text("The Gaussian low-pass filter with σ = 40 produces more blur than the filter with σ = 80 because a smaller σ in the frequency domain corresponds to convolution with a Gaussian of larger σ in the spatial domain, leading to more blurring");
T3 = Text("On applying the ideal low-pass filter, the output images clearly show undesirable 'ringing' artifacts as expected due the convolution with the corresponding Sombrero function in the spatial domain");
T4 = Text("These ringing artifacts are not present on using a Gaussian low-pass filter. Thus, Gaussian low-pass filters are an effective solution to avoid ringing (ripple) artifacts in low-pass filtering.");
% txt = Text("Yes, they're different");
T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';
T4.FontSize = '14';

ul = UnorderedList({T1, T2, T3, T4});
add(sec, ul);
% add(sec, txt)
add(R, sec)

close(R)
%report

toc; % Nearly 11 sec