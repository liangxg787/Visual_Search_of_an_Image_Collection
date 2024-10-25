function visualSearchV1(queryImg)
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
DATASET_FOLDER = GlobalSetting.filePathInfo.DATASET_FOLDER;

%% and within that folder, another folder to hold the descriptors
%% we are interested in working with
DESCRIPTOR_SUBFOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_SUBFOLDER;


%% 1) Load all the descriptors into "ALLFEAT"
%% each row of ALLFEAT is a descriptor (is an image)

ALLFEAT=[];
ALLFILES=cell(1,0);
ctr=1;
allFiles=GlobalSetting.filePathInfo.allFiles;
for filenum=1:length(allFiles)
    fname=allFiles(filenum).name;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;

    % Get all the iamge features
    thesefeat=[];
    featfile=[DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    load(featfile,'F');
    ALLFILES{ctr}=imgfname_full;
    ALLFEAT=[ALLFEAT ; F];
    ctr=ctr+1;
end

%% 2) Pick an image at random to be the query
NIMG=size(ALLFEAT,1);           % number of images in collection
% queryImg=floor(rand()*NIMG);    % index of a random image


%% 3) Compute the distance of image to the query
dst=[];
for i=1:NIMG
    candidate=ALLFEAT(i,:);
    query=ALLFEAT(queryImg,:);
    
    % Compare the images with distance measure function
    thedst=eulideanDistance(foundImgFeat,candidateFeat);
    dst=[dst ; [thedst i]];
end
dst=sortrows(dst,1);  % sort the results by column 1

%% 4) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)

SHOW=15; % Show top 15 results
dst=dst(1:SHOW,:);
outdisplay=[];
for i=1:SHOW
   img=imread(ALLFILES{dst(i,2)});
   img=img(1:2:end,1:2:end,:); % make image a quarter size
   img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
   outdisplay=[outdisplay img];
end
imgshow(outdisplay);
axis off;


end
