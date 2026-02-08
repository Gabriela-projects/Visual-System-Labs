clear all
close all
f = imread('../assets/moon.tif');

sharpenedImage = imsharpen(f, 'Radius', 2, 'Amount', 1.5, 'Threshold', 0);

figure; montage({f, sharpenedImage})
title("Original image (left), Unsharp Masking (radius: 2, amount: 1.5) (right)")