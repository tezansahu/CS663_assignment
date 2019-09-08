function [out_img] = myMeanShiftSegmentation(inp_img, spatial_bw, intensity_bw, no_neighbours, max_iterations)
%MYMEANSHIFTSEGMENTATION Summary of this function goes here
%   Detailed explanation goes here
resize_factor = 1; % No resizing done as running fairly quickly
original_img = im2double(inp_img);
inp_img = imresize(original_img, resize_factor); 
out_img = inp_img;

no_rows = size(inp_img, 1);
no_cols = size(inp_img, 2);
attribute_size = no_rows*no_cols;
attributes = zeros(attribute_size, 5);
for i=1:no_rows
    for j=1:no_cols
        attributes((i-1)*no_cols+j,:) = [i/spatial_bw, j/spatial_bw,...
            inp_img(i,j,1)/intensity_bw, inp_img(i,j,2)/intensity_bw, inp_img(i,j,3)/intensity_bw];
    end
end
wait = waitbar(0, "Mean Shift Segmentation in progress");
no_iterations = 0;
while(no_iterations < max_iterations)
    [nearest_neigh, distances] = knnsearch(attributes, attributes, 'k', no_neighbours);
    temp_attributes = attributes;
    for i=1:attribute_size
        weights = exp(-(distances(i,:).^2)/2);
        sum_weights = sum(weights);
        weights = weights';
        weight_arr = [weights, weights, weights];
        attributes(i, 3:5) = sum(weight_arr.*temp_attributes(nearest_neigh(i,:),3:5))/sum_weights;
    end
    no_iterations = no_iterations + 1;
    for i=1:no_rows
        for j=1:no_cols
            out_img(i,j,1) = attributes((i-1)*no_cols+j,3);
            out_img(i,j,2) = attributes((i-1)*no_cols+j,4);
            out_img(i,j,3) = attributes((i-1)*no_cols+j,5);
        end
    end
    imshow(out_img);

    waitbar(double(no_iterations)/double(max_iterations)); 
end

for i=1:no_rows
    for j=1:no_cols
        out_img(i,j,1) = attributes((i-1)*no_cols+j,3);
        out_img(i,j,2) = attributes((i-1)*no_cols+j,4);
        out_img(i,j,3) = attributes((i-1)*no_cols+j,5);
    end
end
close(wait);
out_img = imresize(out_img, resize_factor);
imshow(out_img);
close all;
end

