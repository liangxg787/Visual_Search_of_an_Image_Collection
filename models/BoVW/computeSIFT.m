function descr = computeSIFT(img)
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
[frames,descr,gss,dogss] = sift( gimg, 'Verbosity', 1 ) ;

descr=uint8(512*descr) ;

keypoints=frames(1:2,:);

% Run the Harris corner detector
thresh=1000; % top 1000 corners
corners = torr_charris_jc(gimg, thresh)';

% Plot positions of the SIFT points and corners
figure(1);
imgshow(img);
hold on;
plot(keypoints(1,:),keypoints(2,:),'yx');
plot(corners(1,:),corners(2,:),'bx');
title(IMAGE);


% Helpful to give windows a chance to draw before disk tied up saving
% results
% drawnow;

clear img gimg;

end
