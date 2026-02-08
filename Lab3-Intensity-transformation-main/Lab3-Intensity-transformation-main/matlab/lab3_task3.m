clear all
close all
f = imread('../assets/pollen.tif');
g = imadjust(f, [0.3 0.55]);
montage({f, g})
title("original image (left) vs intensity stretched image (right)")
figure
imhist(g)  % calculate and plot the histogram
title("intensity level of the pollen image")

g_pdf = imhist(g) ./ numel(g);
g_cdf = cumsum(g_pdf);
close all
imshow(g);
subplot(1,2,1)
plot(g_pdf)
title("PDF plot")
subplot(1,2,2)
plot(g_cdf)
title("CDF plot")

x = linspace(0, 1, 256);
figure
plot(x, g_cdf)
axis([0 1 0 1])
set(gca, 'xtick', 0:0.2:1)
set(gca, 'ytick', 0:0.2:1)
xlabel('Input intensity values', 'FontSize', 9)
ylabel('Output intensity values', 'FontSize',9)
title('Transformation function', 'FontSize', 12)

h = histeq(g,256);
close all
montage({f, g, h})
title('Original image (top left), constrat stretched image (top right), histogram equalised image (bottom left)')
figure;
subplot(1,3,1); imhist(f);
title('Original image histogram')
subplot(1,3,2); imhist(g);
title('Constrat stretched image histogram')
subplot(1,3,3); imhist(h);
title('Image equalised histogram')
