clear all
close all
f = imread('assets/fingerprint-noisy.tif');
SE1 = ones(3,3);
%SE1 = strel("rectangle", [2 2]);
% Erode f to produce fe
fe = imerode(f,SE1);
% Dilate fe to produce fed
fed = imdilate(fe, SE1);
% Open f to produce fo
fo = imopen(f,SE1);

% Close fo to improve the image
fc = imclose(fo, SE1);

% Gaussian
f_gauss = imfilter(im2double(f), fspecial("gaussian", [8 8], 1));
f_gauss_binary = f_gauss > 0.5;

f1 = imdilate(fo, SE1);
f2 = imerode(f1, SE1);
% Show f, fe, fed and fo as a 4 image montage
montage({f, fc, f_gauss_binary}, "size", [1 3])
title("(1): Original image, (2): Open + close image, (3): Gaussian filtered image")