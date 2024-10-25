function topImgs=visualSearch(queryImgName,AllFeatures)
% VISUAL_SEARCH Summary of this function goes here
%
% [OUTPUTARGS] = VISUAL_SEARCH(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/10/22 10:44:15
% Revision: 0.1

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
% DATASET_FOLDER = GlobalSetting.filePathInfo.DATASET_FOLDER;

%% and within that folder, another folder to hold the descriptors
%% we are interested in working with
% DESCRIPTOR_SUBFOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_SUBFOLDER;
% Define the output file path for feature data
% OUT_FOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_FOLDER;
% allFeatFile=[OUT_FOLDER,'/AllFeatures.mat'];


%% 1) Load all the descriptors into "AllFeatures"
%% each row of AllFeatures is a descriptor (is an image)
% AllFeatures=load(allFeatFile, 'AllFeatures').AllFeatures;

%% 2) Get the query image's feature
% Use strcmp to compare the 'name' field with the queryName
isMatch = strcmp({AllFeatures.name}, queryImgName);
% Find the index where the match occurs
foundImg = AllFeatures(isMatch);
% Get the feature
foundImgFeat = foundImg.feature;


%% 3) Compute the distance of image to the query
dst=[];
NIMG=size(AllFeatures,2);           % number of images in collection
for i=1:NIMG
    candidate=AllFeatures(:,i);
    candidateFeat=candidate.feature;

    % Compare the images with distance measure function
    thedst=eulideanDistance(foundImgFeat,candidateFeat);
    dst=[dst ; [thedst i]];
end
dst=sortrows(dst,1);  % sort the results by column 1

%% 4) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)

SHOW=10; % Show top 10 results
topDst=dst(1:SHOW,:);

% Get top 10 images' data
topImgs=AllFeatures(:,topDst(:,2));

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
