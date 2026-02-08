clear all
close all
f = imread('../assets/bonescan-front.tif');
r = double(f);
k = mean2(r);   % find mean intensity of image
E = 0.9;
s = 1 ./ (1.0 + (k ./ (r + eps)) .^ E);
g = uint8(255*s);
imshowpair(f, g, "montage")
title("Original image (left) vs. Constrast stretched image (right)")