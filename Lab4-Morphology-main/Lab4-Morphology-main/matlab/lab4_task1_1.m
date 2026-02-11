A = imread('assets/text-broken.tif');
B1 = [0 1 0;
     1 1 1;
     0 1 0];    % create structuring element
B2 = ones(3,3);
B3 = ones(5,5);
A1 = imdilate(A, B1);
A2 = imdilate(A1, B1);
A3 = imdilate(A2, B1);
A4 = imdilate(A3, B1);
A5 = imdilate(A4, B1);

montage({A,A2, A5},'Size',[1 3])
title("Original image (left), Dilated image with B1 twice (mid), Dilated image with B2 five times (right)")

close all
SE = strel('disk',4);
SE.Neighborhood