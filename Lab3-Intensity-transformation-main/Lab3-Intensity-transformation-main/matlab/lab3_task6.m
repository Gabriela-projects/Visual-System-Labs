clear all
close all
f = imread('../assets/moon.tif');

% Create a Laplacian filter kernel, Alpha range: 0 to 1
w_laplacian = fspecial('laplacian', 0.5); 
f_double = im2double(f);
% Apply Laplacian filter to detect edges and high-frequency components
g_laplacian = imfilter(f_double, w_laplacian, 'replicate');

amount = 1.0;   % Set sharpening strength
% Sharpen the image by subtracting the Laplacian response from the original
% Subtract negative edge responses will add edge enha
sharpenedImage = f_double - amount * g_laplacian;
% Clip the values to valid range [0, 1]
sharpenedImage = max(0, min(1, sharpenedImage));

% Visualise Laplacian properly
g_laplacian_display = mat2gray(g_laplacian);

figure; montage({f_double, g_laplacian_display sharpenedImage})
title("original image (left), Laplacian filter (mid), sharpened image (right)")
