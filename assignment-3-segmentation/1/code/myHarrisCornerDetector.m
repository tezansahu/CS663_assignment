function [dX, dY, eig1, eig2, cornerness] = myHarrisCornerDetector(img, sigma_1, sigma_2, k)

    G1 = fspecial('gaussian', 5, sigma_1);
    [dG1_dx, dG1_dy] = gradient(G1);
    % For x & y derivatives
    dX = conv2(img, dG1_dx, 'same');
    dY = conv2(img, dG1_dy, 'same');
    
    dXX = dX .* dX;
    dYY = dY .* dY;
    dXY = dX .* dY;
    
    gauss_smooth = fspecial('gaussian', 5, sigma_2);
    Ixx = conv2(dXX, gauss_smooth, 'same');
    Iyy = conv2(dYY, gauss_smooth, 'same');
    Ixy = conv2(dXY, gauss_smooth, 'same');
    
    eig1 = zeros(size(img));
    eig2 = zeros(size(img));
    cornerness = zeros(size(img));
    
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            A = [Ixx(i,j), Ixy(i,j); Ixy(i,j), Iyy(i,j)];
            eigval = eig(A);
            eig1(i,j) = eigval(1);
            eig2(i,j) = eigval(2);
            
            cornerness(i,j) = det(A) - (k * trace(A)^2);
        end
    end
    
end