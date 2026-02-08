clear all
close all

f = imread('../assets/office.jpg');
scale_factor = 2;

% Step 1: Edge-directed interpolation
f_upscaled = imresize(f, scale_factor, 'bicubic');
f_double = im2double(f_upscaled);

% Step 2: Bilateral upsampling
% Process each channel separately for better quality
f_bilateral = zeros(size(f_double));
for c = 1:3
    f_bilateral(:,:,c) = imbilatfilt(f_double(:,:,c), ...
        'DegreeOfSmoothing', 0.03, ...
        'SpatialSigma', 3);
end

% Step 3: Extract details at different scales
detail_fine = f_bilateral - imgaussfilt(f_bilateral, 1);
detail_medium = imgaussfilt(f_bilateral, 1) - imgaussfilt(f_bilateral, 3);
detail_coarse = imgaussfilt(f_bilateral, 3) - imgaussfilt(f_bilateral, 7);

% Enhance each scale
detail_fine_enhanced = detail_fine * 2.0;
detail_medium_enhanced = detail_medium * 1.5;
detail_coarse_enhanced = detail_coarse * 1.2;

% Recombine
base = imgaussfilt(f_bilateral, 7);
f_enhanced_details = base + detail_coarse_enhanced + ...
                     detail_medium_enhanced + detail_fine_enhanced;
f_enhanced_details = max(0, min(1, f_enhanced_details));

% Step 4: LAB enhancement for exposure/color
lab = rgb2lab(f_enhanced_details);
L = lab(:,:,1);

% Selective brightening
dark_mask = (100 - L) / 100;
dark_mask = imgaussfilt(dark_mask, 50);
L_adjusted = L + dark_mask * 18;
L_adjusted = min(L_adjusted, 100);

% Contrast boost
L_adjusted = imadjust(L_adjusted / 100, [0.05 0.95], []) * 100;

% Vivid colors
a_vivid = lab(:,:,2) * 1.35 - 3;
b_vivid = lab(:,:,3) * 1.35;

lab_final = cat(3, L_adjusted, a_vivid, b_vivid);
f_color_enhanced = lab2rgb(lab_final);

% Step 5: Sharpen edges more than smooth areas
gray = rgb2gray(f_color_enhanced);
edge_map = imgradient(gray);
edge_map_norm = edge_map / max(edge_map(:));

% Variable sharpening based on edge strength
sharpen_amount = 0.4 + 0.6 * edge_map_norm;  

f_final = f_color_enhanced;
for c = 1:3
    channel = f_color_enhanced(:,:,c);
    detail = channel - imgaussfilt(channel, 1.5);
    f_final(:,:,c) = channel + detail .* sharpen_amount;
end
f_final = max(0, min(1, f_final));

figure;
montage({f, f_bilateral, f_enhanced_details, f_final}, 'Size',[1 4]);
title('(1): Original image, (2): Upscaled image, (3): Detail Enhanced, (4): Final Image');
