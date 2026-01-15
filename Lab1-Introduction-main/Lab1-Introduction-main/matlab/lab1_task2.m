I = clown;
x_shear = 0.1;  
y_shear = 0.5;   

[H, W] = size(I);  

% Center of the image
x_c = (W + 1) / 2;
y_c = (H + 1) / 2;

% Set output image to be same size with black background
shear_img = zeros(H, W);

% Define the shear matrix
shear_s = [1 x_shear;...
           y_shear 1];

s_inv = inv(shear_s);

for y_d = 1:H        % row index (y)
    for x_d = 1:W    % column index (x)
        % Destination coords relative to center
        vect_dest = [(x_d - x_c); (y_d - y_c)];
        
        vect_cal = s_inv * vect_dest;
        
        % Reverse mapping: destination -> source
        vect_src = vect_cal + [x_c ; y_c];
        x_s = vect_src(1);
        y_s = vect_src(2);
        
        % Check if source position is inside original image
        if x_s >= 1 && x_s <= W && y_s >=1 && y_s <= H
            % Nearest-neighbor sampling
            xs_nn = round(x_s);
            ys_nn = round(y_s);
            shear_img(y_d, x_d) = I(ys_nn, xs_nn);
        else
            % Outside then keep it black (0)
            shear_img(y_d, x_d) = 0;
        end
    end
end
