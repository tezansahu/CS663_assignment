%% MyMainScript

tic;
%% Your code here
I = zeros(300);
I(50:100, 50:120) = 255;
J = zeros(300);
J(120:170, 20:90) = 255;
figure(1);
subplot(121); imshow(I); title("Image I"); subplot(122); imshow(J); title("Image J");

f1 = fftshift(fft2(I)); f2 = fftshift(fft2(J));
f = (f1 .* conj(f2))./(abs(f1 .* f2));
lf = log(abs(f) + 1);
figure(2); imshow(lf, [min(lf(:)), max(lf(:))]); colormap jet; colorbar; impixelinfo; title("log(|F(u,v)| + 1) [This should be constant]")
g = real(ifft2(f));
figure(3);
imshow(g/max(g(:))); title("Shift neede for Restoration")
impixelinfo;


toc;
