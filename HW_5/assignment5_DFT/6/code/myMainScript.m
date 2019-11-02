import mlreportgen.report.*
import mlreportgen.dom.*

%% MyMainScript
clear;
close all;



cd ../report/
R = Report('Report 5.6: FFT-Based Image Registration', 'pdf');
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

headingObj = Heading3("Q6: FFT-Based Image Registration");
headingObj.Style = { HAlign('center') };
add(R, headingObj)

tic;
%% Applying the algorithm for Original Images

sec = Section;
T = Text("Implementation on Images [Not Noisy]");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;


I = zeros(300);
I(50:100, 50:120) = 255;
J = zeros(300);
J(120:170, 20:90) = 255;
fig1 = figure(1);
subplot(121); greyscale(I); title("Image I");
subplot(122); greyscale(J); title("Image J");
caption = Paragraph("Fig 1: Images I & J [ J is obtained by translation of rectangle in I by (t_x = -30, t_y = 70)]");
caption.Style = {HAlign('center')};
add(sec, Figure(fig1))
add(sec, caption);


f1 = fftshift(fft2(I)); f2 = fftshift(fft2(J));
f = (f1 .* conj(f2))./(abs(f1 .* f2));
lf = log(abs(f) + 1);
fig2 = figure(2);
color(lf);
title("log(|F(u,v)| + 1) [This should be constant]");
caption = Paragraph("Fig 2: Logarithm of the Fourier magnitude of the cross-power spectrum");
caption.Style = {HAlign('center')};
add(sec, Figure(fig2))
add(sec, caption);

g = ifft2(f);
fig3 = figure(3);
greyscale(g/max(g(:))); title("Shift needed on Image J for Restoration");
caption = Paragraph("Fig 3: Shift needed on Image J for Restoration");
caption.Style = {HAlign('center')};
add(sec, Figure(fig3))
add(sec, caption);

add(R, sec);

%% Applying the same for the Noisy Images

sec = Section;
T = Text("Implementation on Images [Noisy]");
T.Bold = true;
T.FontSize = '18';

sec.Title = T;

I_noisy = I + rand(size(I)) * 20;
J_noisy = J + rand(size(I)) * 20;
fig4 = figure(4);
subplot(121); greyscale(I_noisy); title("Image I (Noisy)");
subplot(122); greyscale(J_noisy); title("Image J (Noisy)");
caption = Paragraph("Fig 4: Noisy variants of images I & J [ J is obtained by translation of rectangle in I by (t_x = -30, t_y = 70)]");
caption.Style = {HAlign('center')};
add(sec, Figure(fig4))
add(sec, caption);

f1_noisy = fftshift(fft2(I_noisy)); f2_noisy = fftshift(fft2(J_noisy));
f_noisy = (f1_noisy .* conj(f2_noisy))./(abs(f1_noisy .* f2_noisy));
lf_noisy = log(abs(f_noisy) + 1);
fig5 = figure(5); 
color(lf_noisy); title("log(|F(u,v)| + 1) [This should be constant]");
caption = Paragraph("Fig 5: Logarithm of the Fourier magnitude of the cross-power spectrum");
caption.Style = {HAlign('center')};
add(sec, Figure(fig5))
add(sec, caption);

g_noisy = ifft2(f_noisy);
fig6 = figure(6);
greyscale(g_noisy/max(g_noisy(:))); title("Shift needed on Image J (Noisy) for Restoration");
caption = Paragraph("Fig 6: Shift needed on Noisy Image J for Restoration");
caption.Style = {HAlign('center')};
add(sec, Figure(fig6))
add(sec, caption);

add(R, sec);

toc;

%% Verification of results

sec = Section;

T0 = Paragraph("Verification of result produced using Cross-Power Spectrum:");
T1 = Text("Figure 3 shows a spike at (31, 231), which could be interpreted as as (31, -71) on applying a wrap-around on the image of size 300 * 300 while translation. This clearly is the translation to restore Image J back to Image I since the initial translation applied was (-30, 70). Note that the extra '1' is due to the MATLAB indexing.");
T2 = Text("Similar to the previous case, figure 6 shows a spike at (31, 231), which could be interpreted as as (31, -71) on applying a wrap-around on the image of size 300 * 300 while translation. But this time, due to the noise present, the spike is not a clean spike, but surrounded by other frequencies of non-zero magnitude. Moreover, the relative magnitude of the spike w.r.t. surrounding region is not as high as the previous case compared");
T3 = Text("We also see that the plots of logarithm of the Fourier magnitudes is a constant of value = log(2) because the result of the cross-power spectrum is a compex number of unit magnitude always.");
T0.Bold = true;
T0.FontSize = '18';
T1.FontSize = '14';
T2.FontSize = '14';
T3.FontSize = '14';

sec.Title = T0;

ul = UnorderedList({T1, T2, T3});
add(sec, ul);

add(R, sec);

%% Analysis of time complexities

sec = Section;

T0 = Paragraph("Analysis of Time Complexities:");
T1 = Text("For an Image of size N * N, using the cross-power spectrum to predict translation required for restoration involves the calculation of Fourier transforms using FFT [each being of O(N log(N))] followed by a conjugation [O(N)] & vectorized pointwise multiplication & division [O(1)]. Thus, the overall time complexity is O(N log N).");
T2 = Text("If we use pixel-wise image comparison for an N * N image, the time complexity of predicting the translation would be O(N^2)");

% T3 = Text("We also see that the plots of logarithm of the Fourier magnitudes is a constant of value = log(2) because the result of the cross-power spectrum is a compex number of unit magnitude always.");
T0.Bold = true;
T0.FontSize = '18';
T1.FontSize = '14';
T2.FontSize = '14';

sec.Title = T0;

ul = UnorderedList({T1, T2});
add(sec, ul);

add(R, sec);

%% Rotation Correction mentioned in the paper

sec = Section;

T0 = Paragraph("Approach for Correcting Rotation between Images:");
Note = Paragraph("[Here in the analysis, we consider correction if pure rotation of the image & ignore any translation or scaling]");
P1 = Paragraph("If f2(x,y) is a rotated version of  f1(x, y) [with a rotation of θo], doing a Fourier Transform in the cartesian coordinates would yield F2(u, v) = F1(ucos(θo) + vsin(θo), -usin(θo) + vcos(θo)). Clearly, their magnitudes are the same. So, we can use the same concept of cross-power spectrum as before by converting the rotation by θo into a translation. This can be achieved by converting the images into polar coordinates & taking their Fourier Transform:");
P2 = Paragraph("f2(r, θ) = f1(r, θ-θo)");
P3 = Paragraph("F2(m, n) = exp(-2πj(n.θo)) * F1(m, n)");
P4 = Paragraph("Thus, cross-power spectrum of F1(m, n) & F2(m, n) would yield exp(2πj(n.θo)), using which we can calculate the rotation.");
P5 = Paragraph("Any translation in x & y would lead to a change in r by ro, such that the cross power spectrum would yield exp(2πj(m.ro + n.θo)). Hence, displacement & rotation can be figured out. The exact (x, y) translations can be figured out using the original cross-power spectrum in the cartesian coordinates.");
T0.Bold = true;
T0.FontSize = '18';
Note.FontSize = '14';
P1.FontSize = '14';
P2.FontSize = '14';
P3.FontSize = '14';
P4.FontSize = '14';
P5.FontSize = '14';

sec.Title = T0;

add(sec, Note);
add(sec, P1);
add(sec, P2);
add(sec, P3);
add(sec, P4);
add(sec, P5);

add(R, sec);



close(R);