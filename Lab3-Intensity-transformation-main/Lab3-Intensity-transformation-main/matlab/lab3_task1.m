clear all
imfinfo('assets/breastXray.tif')
f = imread('assets/breastXray.tif');
imshow(f)

[fmin, fmax] = bounds(f(:));
imshow(f(:,241:482))

g1 = imadjust(f, [0 1], [1 0]);
figure
montage({f, g1})

% pixels <= 0.5, mapped to 0 (black), pixels >= 0.75, mapped to 1 (white)
g2 = imadjust(f, [0.5 0.75], [0 1]);
g3 = imadjust(f, [], [], 2);
figure 
montage({g2 g3})
title("gray scale: 0.5-0.75 (Left), gamma = 2.0 (Right)")
