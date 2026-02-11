clear all
close all
f = imread('assets/fingerprint.tif');
f = imcomplement(f);
level = graythresh(f);
BW = imbinarize(f, level);

% Invert the binary image to get black on white
BW = ~BW;

% Perform thinning operation 1 time and store result in g1
g1 = bwmorph(BW, "thin", 1);
g2 = bwmorph(BW, "thin", 2);
g3 = bwmorph(BW, "thin", 3);
g4 = bwmorph(BW, "thin", 4);
g5 = bwmorph(BW, "thin", 5);
ginf = bwmorph(BW, "thin", inf);

montage({f BW g5 ginf}, "size", [1 4])
title("(1): Original Image, (2): Binary Image, (3): Thinning x 3, (4): Thinning infinitely")