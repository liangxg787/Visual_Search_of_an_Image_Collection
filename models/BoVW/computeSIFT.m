function descr = computeSIFT(img,NumOctaves,NumLevels)
% COMPUTESIFT Summary of this function goes here
%
% [OUTPUTARGS] = COMPUTESIFT(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/11/10 11:38:32
% Revision: 0.1

gimg=rgb2gray(img);

% Run the SIFT detetor, and compute the SIFT descriptors
% [~,descr,~,~] = sift( gimg, 'Verbosity', 1, 'NumOctaves', NumOctaves, 'NumLevels', NumLevels);
[~,descr,~,~] = sift( gimg, 'Verbosity', 1);

descr=uint8(512*descr) ;

% keypoints=frames(1:2,:);

% Run the Harris corner detector
% thresh=1000; % top N corners
% corners = torr_charris_jc(gimg, thresh)';

clear img gimg;

end
