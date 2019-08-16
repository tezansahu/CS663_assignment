function [newImg] = myNearestNeighborInterpolation(img)
    in_rows = size(img)(1);
    in_cols = size(img)(2);
    out_rows = 3*in_rows - 2;
    out_cols = 2*in_cols - 1;
    
    r_scale = out_rows / in_rows;
    c_scale = out_cols / in_cols;
    
    [cf, rf] = meshgrid(1 : out_cols, 1 : out_rows);
    rf = rf / r_scale;
    cf = cf / c_scale;
    
    r = round(rf);
    c = round(cf);
    
    r(r < 1) = 1;
    c(c < 1) = 1;
    
    newImgIndices = sub2ind([in_rows, in_cols], r, c);
    newImg = img(newImgIndices);
 endfunction