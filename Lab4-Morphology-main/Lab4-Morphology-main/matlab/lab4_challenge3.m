clear all; close all;
f = imread('assets/normal-blood.png');
f = rgb2gray(f);
% Binarise and invert the image since it counts the white items
bw = ~imbinarize(f);
bw_filled = imfill(bw, "holes");

CC = bwconncomp(bw_filled,8);
num_cells = CC.NumObjects;
fprintf(' Number of cells: %d\n\n', num_cells);

figure; montage({f, bw,  bw_filled}, "size", [1 3]); title(['(1): Original image,' ...
    '(2): Binary image, (3): Image with holes filled']);