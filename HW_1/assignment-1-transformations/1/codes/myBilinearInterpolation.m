function [newImg] = myBilinearInterpolation(img)

    in_rows = size(img, 1);
    in_cols = size(img, 2);
    out_rows = 3*in_rows - 2;
    out_cols = 2*in_cols - 1;
      
    r_scale = out_rows / in_rows;
    c_scale = out_cols / in_cols;

    [cf, rf] = meshgrid(1 : out_cols, 1 : out_rows);
    rf = rf / r_scale;
    cf = cf / c_scale;

    r = floor(rf);
    c = floor(cf);

    r(r < 1) = 1;
    c(c < 1) = 1;
    r(r > in_rows - 1) = in_rows - 1;
    c(c > in_cols - 1) = in_cols - 1;

    del_R = rf - r;
    del_C = cf - c;

    in1_ind = sub2ind([in_rows, in_cols], r, c);
    in2_ind = sub2ind([in_rows, in_cols], r+1,c);
    in3_ind = sub2ind([in_rows, in_cols], r, c+1);
    in4_ind = sub2ind([in_rows, in_cols], r+1, c+1);       

    im_double = double(img);
    tmp = im_double(in1_ind).*(1 - del_R).*(1 - del_C) + im_double(in2_ind).*(del_R).*(1 - del_C) + im_double(in3_ind).*(1 - del_R).*(del_C) + im_double(in4_ind).*(del_R).*(del_C);
    newImg = cast(tmp, class(img));

end