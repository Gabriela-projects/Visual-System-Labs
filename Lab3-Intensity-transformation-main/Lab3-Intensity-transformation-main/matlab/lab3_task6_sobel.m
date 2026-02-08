clear all
close all
f = imread('../assets/moon.tif');

f_double = im2double(f);

% Create Sobel filters for horizontal and vertical edge detection
v_sobel = fspecial('sobel');    % Horizontal edges
h_sobel = v_sobel;   % Vertical edges

% Apply Sobel filters to detect edges in both directions
gx = imfilter(f_double, h_sobel, 'replicate');
gy = imfilter(f_double, v_sobel, 'replicate');
% Gradient magnitude for the edge strength
gradient_mag= sqrt(gx.^2 + gy.^2);

% Sharpening strength
amount = 0.5;
% Sharpen by adding the gradient magnitude to the original
sharpenedImage = f_double + amount * gradient_mag;
sharpenedImage = max(0, min(1, sharpenedImage));

gradient_display = mat2gray(gradient_mag);

figure; montage({f, gradient_display sharpenedImage})
title("Original image (top left), Sobel gradient (top right), sharpened image (bottom left)")