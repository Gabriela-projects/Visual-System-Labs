clear all
close all
f = imread('../assets/noisyPCB.jpg');
imshow(f)

%w_box = fspecial('average', [9 9]);
%w_gauss = fspecial('Gaussian', [7 7], 1.0);

%g_box = imfilter(f, w_box, 0);
%g_gauss = imfilter(f, w_gauss, 0);
%figure
%montage({f, g_box, g_gauss})
%title("original image (top left), image with averaging filter (top right), image with Gaussian kernel (bottom left)")

w_gauss_low = fspecial('Gaussian', [3 3], 0.5);
w_gauss_mid = fspecial('Gaussian', [7 7], 1.0);
w_gauss_high = fspecial('Gaussian', [19 19], 3.0);
w_gauss_high2 = fspecial('Gaussian', [31 31], 5.0);

g_gauss_mid = imfilter(f, w_gauss_mid, 0);
g_gauss_low = imfilter(f, w_gauss_low, 0);
g_gauss_high = imfilter(f, w_gauss_high, 0);
g_gauss_high2 = imfilter(f, w_gauss_high2, 0);

figure
montage({g_gauss_low, g_gauss_mid, g_gauss_high, g_gauss_high2})
title("Image with kernel size 3x3 and sigma = 0.5 (top left), 7x7 and sigma = 1.0 (top right), 19x19 and sigma = 3.0 (bottom left), 31x31 and sigma = 5.0 (bottom right)")
