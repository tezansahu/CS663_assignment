function rmsd = getRMSD(img1, img2)
    if size(img1) ~= size(img2)
        error("Images must be of the same size")
    end
    
    N = size(img1, 1) * size(img1, 2);
    sumOfSquares = sum(sum((img1 - img2) .^ 2));
    rmsd = sqrt(sumOfSquares/N);
end