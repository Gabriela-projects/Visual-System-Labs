clear all; close all;
f = imread('assets/fillings.tif');

% Reduce noise using median filtering
f_med = medfilt2(f, [5 5]);

% Use the top 3% as threshold to find the bright fillings 
threshold  = prctile(f_med(:), 97);
% Binary image where pixels above the threshold become white
bw = f_med > threshold;

% Count all the white pixels which represent fillings
CC = bwconncomp(bw);
num_fillings = CC.NumObjects;
sizes = cellfun(@numel, CC.PixelIdxList);

% Get additional properties
stats = regionprops(bw, f, 'Area', 'Centroid', 'MeanIntensity');
fprintf('Total number of fillings: %d\n\n', num_fillings);
fprintf('Individal filling details: \n');
for i = 1:num_fillings
    fprintf(' Filling %d %d pixels (Mean intensity: %.1f)\n', ...
            i, sizes(i), stats(i).MeanIntensity);
end
fprintf('\nTotal filling area: %d pixels\n', sum(sizes));


figure; montage({f, f_med, bw}, 'size', [1 3]); title('(1): Original image, (2): Noise reduced image, (3): Binary image of fillings');