clear all; close all;
f = imread('assets/palm.tif');

se = strel('disk', 5);
f_open = imopen(f, se);

marker = imerode(f_open, strel('disk', 6));
mask = imerode(f_open, strel('disk',3));
f_reconstructed = imreconstruct(marker, mask);
f_reconstructed = imadjust(f_reconstructed);

figure; montage({f, f_open, marker, mask, f_reconstructed},'size',[2 3]); title(['(1): Original image,' ...
    '(2): Opened image, (3): Marker image, (4): Mask image, (5): Final image']);