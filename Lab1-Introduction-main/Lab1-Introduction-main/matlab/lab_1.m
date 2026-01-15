I = clown;
theta_deg = -30;    % rotation angle in degrees
theta = deg2rad(theta_deg);    % convert to radians

[H, W] = size(I);  

% Center of the image (leftmost pixel [1] + rightmost pixel [W/H])
x_c = (W + 1) / 2;
y_c = (H + 1) / 2;

% Set output image to be same size with black background
rotate_img = zeros(H, W);

% Define the cos sin matrix
R = [cos(theta) sin(theta);...
     -sin(theta) cos(theta)];

R_inv = R';

for y_d = 1:H        % row index (y)
    for x_d = 1:W    % column index (x)
        % Destination coords relative to center
        vect_dest = [(x_d - x_c); (y_d - y_c)];
        
        vect_cal = R_inv * vect_dest;
        
        % Reverse mapping: destination -> source
        vect_src = vect_cal + [x_c ; y_c];
        x_s = vect_src(1);
        y_s = vect_src(2);
        
        % Check if source position is inside original image
        if x_s >= 1 && x_s <= W && y_s >=1 && y_s <= H
            % Nearest-neighbor sampling
            xs_nn = round(x_s);
            ys_nn = round(y_s);
            rotate_img(y_d, x_d) = I(ys_nn, xs_nn);
        else
            % Outside then keep it black (0)
            rotate_img(y_d, x_d) = 0;
        end
    end
end
