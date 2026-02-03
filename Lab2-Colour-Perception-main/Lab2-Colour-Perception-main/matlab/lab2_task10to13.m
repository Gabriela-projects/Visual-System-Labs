% Store the image as a 3D matrix containing red, green, and blue channels
RGB = imread('peppers.png');
% The rgb2gray function converts the RGB into a grayscale using a weighted
% sum of the R, G, and B components
I = rgb2gray(RGB);

% Task 10
% Showing the images side by side
imshowpair(RGB, I, 'montage')
title('Original colour image (left) grayscale image (right)');

% Task 11 - split into R,G,B
[R, G, B] = imsplit(RGB);
montage({R, G, B}, 'Size',[1 3])
title('Red channel (left), Green channel (middle), Blue channel (right)')

% Task 12 - map RGB to HSV
HSV = rgb2hsv(RGB);
[H, S, V] = imsplit(HSV);
montage({H, S, V}, 'Size', [1 3])
title('Hue (left), Saturation (middle), Value (right)')

% Task 13 - map RGB to XYZ
XYZ = rgb2xyz(RGB);
[X, Y, Z] = imsplit(XYZ);
montage({X, Y, Z}, 'Size', [1 3])
title('X (left), Y (middle), Z (right)')

