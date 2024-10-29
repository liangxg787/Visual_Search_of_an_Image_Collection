function H = computeEdgeOrientationHistogram(img,Q)
arguments
    img   % The input image.
    Q     % The number of quantization levels for the histogram.
end
% COMPUTEEDGEORIENTATIONHISTOGRAM Computes the histogram of edge orientations in an image.
%
% H = COMPUTEEDGEORIENTATIONHISTOGRAM(IMG, Q) computes the histogram of edge orientations
% for the input image IMG with Q quantization levels.
%
% Inputs:
%   - IMG: The input image.
%   - Q: The number of quantization levels for the histogram.
%
% Output:
%   - H: The histogram of edge orientations.
%
% Examples:
%   - Example usage code can be added here.
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/10/28 21:34:00
% Revision: 0.1

% Convert the input image to grayscale and double precision for subsequent processing.
img = double(rgb2gray(img));
% disp(img);

% Define the Sobel filter for horizontal gradients.
sobel_xfilter = [-1,0,1;-2,0,2;-1,0,1];
% Define the Sobel filter for vertical gradients by transposing the horizontal filter.
sobel_yfilter = sobel_xfilter';

% Apply the Sobel filter in the horizontal direction to obtain the image's horizontal gradients.
img_xdiff = filter2(sobel_xfilter,img);
% Apply the Sobel filter in the vertical direction to obtain the image's vertical gradients.
img_ydiff = filter2(sobel_yfilter,img);

% Calculate the magnitude of the image gradients.
img_mag = sqrt(img_xdiff.^2 + img_ydiff.^2);
% Get the dimensions of the image.
r=size(img_mag,1);
c=size(img_mag,2);
% Set the border pixels to 0 to avoid edge effects.
img_mag(1,:) = 0;
img_mag(r,:) = 0;
img_mag(:,1) = 0;
img_mag(:,c) = 0;
% Find the maximum gradient magnitude.
img_mag_max = max(max(img_mag));

% Normalize the gradient magnitude.
img_mag_norm = img_mag./img_mag_max;
% Threshold the normalized gradient magnitude to obtain high gradient magnitude pixels.
img_mag_high_ind = ceil(img_mag_norm - .20);

% Calculate the gradient direction.
img_theta = atan2(img_ydiff,img_xdiff);

% Reshape the gradient direction and high gradient magnitude index matrices for subsequent processing.
img_theta_vals=reshape(img_theta,1,size(img_theta,1)*size(img_theta,2));
img_mag_high_ind_vals=reshape(img_mag_high_ind,1,size(img_mag_high_ind,1)*size(img_mag_high_ind,2));
% Select the gradient directions of high gradient magnitude pixels.
img_theta_vals_sel = [];
for i=1:(size(img_theta_vals,2))
    if img_mag_high_ind_vals(1,i) == 1
        img_theta_vals_sel = [img_theta_vals_sel,img_theta_vals(1,i)];
    end
end

% Find the maximum gradient direction value among the selected pixels.
img_theta_max = max(max(img_theta_vals_sel));
% Normalize the selected gradient direction values.
img_theta_vals_sel_norm = img_theta_vals_sel./img_theta_max;
% Quantize the gradient direction values.
img_theta_quanta_vals = floor(abs(img_theta_vals_sel_norm).*Q);

% Compute the histogram of the quantized gradient direction values.
H = hist(img_theta_quanta_vals,Q);

% Normalize the histogram.
H = H ./sum(H);
return;

end