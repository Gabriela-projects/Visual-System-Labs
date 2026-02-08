clear all
close all
f = imread('../assets/lake&tree.png');
r = double(f);
k = mean2(r);
E = 3.2;
s = 1 ./ (1.0 + (k ./ (r + eps)) .^E);
g = uint8(255*s);
g2 = imadjust(f, [0.1 0.5], [0 1]);
g3 = imadjust(f, [0.1 0.5], [  ], 0.85);
figure; montage({f, g2, g3, g}, 'Size',[1 4])
title("(1): Original image, (2): Image with gray scale range, (3): Image with gamma correction, (4): Image with contrast-stretching transformation")