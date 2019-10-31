%% MyMainScript
clear;
close all;

tic;
%% Applying the algorithm for Original Images

I = zeros(300);
I(50:100, 50:120) = 255;
J = zeros(300);
J(120:170, 20:90) = 255;
figure(1);
subplot(121); imshow(I); title("Image I"); subplot(122); imshow(J); title("Image J");

f1 = fftshift(fft2(I)); f2 = fftshift(fft2(J));
f = (f1 .* conj(f2))./(abs(f1 .* f2));
lf = log(abs(f) + 1);

figure(2); 
imshow(lf, [min(lf(:)), max(lf(:))]); colormap jet; colorbar; impixelinfo; title("log(|F(u,v)| + 1) [This should be constant]")
g = ifft2(f);

figure(3);
imshow(g/max(g(:))); title("Shift needed on Image J for Restoration")
impixelinfo;

%% Applying the same for the Noisy Images

I_noisy = I + rand(size(I)) * 20;
J_noisy = J + rand(size(I)) * 20;
figure(4);
subplot(121); imshow(I_noisy, [min(I_noisy(:)), max(I_noisy(:))]); title("Image I [Noisy]"); subplot(122); imshow(J_noisy, [min(J_noisy(:)), max(J_noisy(:))]); title("Image J [Noisy]");
impixelinfo

f1_noisy = fftshift(fft2(I_noisy)); f2_noisy = fftshift(fft2(J_noisy));
f_noisy = (f1_noisy .* conj(f2_noisy))./(abs(f1_noisy .* f2_noisy));
lf_noisy = log(abs(f_noisy) + 1);

figure(5); 
imshow(lf_noisy, [min(lf_noisy(:)), max(lf_noisy(:))]); colormap jet; colorbar; impixelinfo; title("log(|F(u,v)| + 1) [This should be constant]")

g_noisy = ifft2(f_noisy);
figure(6);
imshow(g_noisy/max(g_noisy(:))); title("Shift needed on Image J (Noisy) for Restoration")
impixelinfo;


toc;
