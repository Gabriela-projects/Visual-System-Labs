clear all
close all
f = imread('../assets/circles.tif');
f_original = f;  % Keep original for comparison

% Noise reduction using Median filter
f_median = medfilt2(f, [7 7], 'zeros');

% Contrast enhancement using histogram equalisation
f_histeq = histeq(f_median);

f_double = im2double(f_histeq);
v_sobel = fspecial('sobel');    
h_sobel = v_sobel;   

gx = imfilter(f_double, h_sobel, 'replicate');
gy = imfilter(f_double, v_sobel, 'replicate');
gradient_mag= sqrt(gx.^2 + gy.^2);

% Threshold using Otsu's method
threshold = graythresh(gradient_mag);
edges_binary = imbinarize(gradient_mag, threshold);

% Mask out brush
[rows, cols] = size(f);
mask = true(rows, cols);
mask(240:391, 1:130) = false;
edges_binary = edges_binary & mask;

% Clean up with morphology
edges_final = bwareaopen(edges_binary, 25);
%edges_final = imclose(edges_cleaned, strel('disk', 2));

figure; montage({f, f_median, mat2gray(gradient_mag), edges_final}, 'Size', [1 4]);
title("(1): Original image, (2): Noise reduced image, (3): Sobel gradient, (4): Edge detected image")