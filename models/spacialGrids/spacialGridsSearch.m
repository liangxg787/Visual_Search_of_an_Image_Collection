function topImgs = spacialGridsSearch(queryImgName,AllFeatures)
% SPACIALGRIDSSEARCH Summary of this function goes here
% 
% [OUTPUTARGS] = SPACIALGRIDSSEARCH(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/10/30 11:32:31 
% Revision: 0.1 


%% 1) Get the query image's feature
% Use strcmp to compare the 'name' field with the queryName
isMatch = strcmp({AllFeatures.name}, queryImgName);
% Find the index where the match occurs
foundImg = AllFeatures(isMatch);
% Get the feature
foundImgFeat = foundImg.feature;


%% 2) Compute the distance of image to the query
dst=[];
NIMG=size(AllFeatures,2);           % number of images in collection
for i=1:NIMG
    candidate=AllFeatures(:,i);
    candidateFeat=candidate.feature;

    % Compare the images with distance measure function
    thedst=euclideanDistance(foundImgFeat,candidateFeat);
    dst=[dst ; [thedst i]];
end
dst=sortrows(dst,1);  % sort the results by column 1

%% 3) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)

topN=GlobalSetting.topN;
topDst=dst(1:topN,:);

% Get top N images' data
topImgs=AllFeatures(:,topDst(:,2));

saveTopImages(topImgs);

%% Show top 10 images
% outdisplay=[];
% for i=1:SHOW
%     % Get the image's data
%     img=AllFeatures(:,topDst(i,2));
%     imgData=img.imgData;
%     imgData=imgData(1:2:end,1:2:end,:); % make image a quarter size
%     imgData=imgData(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
%     outdisplay=[outdisplay imgData];
% end
% imgshow(outdisplay);
% axis off;


end
