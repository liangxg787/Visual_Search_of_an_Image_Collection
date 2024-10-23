function F=extractRandom(img, Q)
arguments
    img
    Q = 4
end
% F=rand(1,30);

% Returns a row [rand rand .... rand] representing an image descriptor
% computed from image 'img'
%
% Note img is a normalised RGB image i.e. colours range [0,1] not [0,255].


%% Compute the average red value of the image
% red=img(:,:,1);
% red=reshape(red,1,[]);
% average_red=mean(red);
%
% % For green
% green=img(:,:,1);
% green=reshape(green,1,[]);
% average_green=mean(green);
%
% % For blue
% blue=img(:,:,1);
% blue=reshape(blue,1,[]);
% average_blue=mean(blue);
%
% F=[average_red average_green average_blue];

%% compute with Global Colour Histogram
F=computeRGBHistogram(img,Q);

return;