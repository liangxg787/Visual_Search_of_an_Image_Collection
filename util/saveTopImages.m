function saveTopImages(topImgs, subSvaingPath, fileName)
% SAVETOPIMAGES Summary of this function goes here
% 
% [OUTPUTARGS] = SAVETOPIMAGES(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/11/09 15:42:53 
% Revision: 0.1 

% Show top N results
SHOW=GlobalSetting.SHOW;
outdisplay=[];
for i=1:SHOW
    % Get the image's data
    % img=AllFeatures(:,topDst(i,2));
    img=topImgs(:,i);
    imgData=img.imgData;
    imgData=imgData(1:2:end,1:2:end,:); % make image a quarter size
    imgData=imgData(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
    outdisplay=[outdisplay imgData];
end

% Display all the results
% imgshow(outdisplay);

% Save the graph as a high-resolution PNG file
saveDir = [GlobalSetting.filePathInfo.SEARCH_RESULTS, '/', subSvaingPath];
if ~exist(saveDir, 'dir')
    % Create the new directory
    mkdir(saveDir);
end

savePath = [saveDir, '/', fileName];
savePath = strjoin(savePath, '');

imwrite(outdisplay, savePath);

end
