function topImgs = searchFunction(distanceType,queryImgName,AllFeatures)
% SEARCHFUNCTION Summary of this function goes here
%
% [OUTPUTARGS] = SEARCHFUNCTION(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/11/2 18:40:26
% Revision: 0.1

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
% DATASET_FOLDER = GlobalSetting.filePathInfo.DATASET_FOLDER;

%% and within that folder, another folder to hold the descriptors
%% we are interested in working with
% DESCRIPTOR_SUBFOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_SUBFOLDER;
% Define the output file path for feature data
% OUT_FOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_FOLDER;
% allFeatFile=[OUT_FOLDER,'/AllFeatures.mat'];


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
    switch distanceType
        case 'euclidean'
            thedst=euclideanDistance(foundImgFeat,candidateFeat);
        case 'euclideanMatrix'
            thedst=euclideanDistanceForMatrix(foundImgFeat,candidateFeat);
        case 'cosine'
            thedst=cosineSim(foundImgFeat,candidateFeat);
        case 'mahalanobis'
            thedst=mahalanobisDistance(foundImgFeat,candidateFeat);
        case 'manhattan'
            thedst=manhattanDistance(foundImgFeat,candidateFeat);
        case 'pearson'
            thedst=pearsonDistance(foundImgFeat,candidateFeat);
        case 'Eigen_Mahalanobis'
            foundImgobs= foundImg.obs;
            thedst=Eigen_Mahalanobis(foundImgobs,candidateFeat);
            % sumDst=sum(thedst(:));
            thedst=mean(thedst(:));
        otherwise
            error(['Unknown parameter: ' distanceType]) ;
    end
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


end

