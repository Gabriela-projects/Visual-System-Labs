clear all
close all
I = imread('assets/blobs.tif');
I = imcomplement(I);
level = graythresh(I);
BW = imbinarize(I, level);

% SE is a 3x3 elements of 1's
SE = ones(3,3);
% Erode BW with SE
BWE = imerode(BW,SE);

% The eroded image is subtracted from BW
Boundary = BW - BWE;
Boundary_clean = bwareaopen(Boundary, 6);
montage({Boundary, Boundary_clean}, "size", [1 2])
title("(1): Original Boundary Image, (2): Filtered Boundary Image")