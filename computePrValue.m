function PRValues = computePrValue(topImgs,PRValues,queryImgName)
% CALCULATEPRVALUE Summary of this function goes here
% 
% [OUTPUTARGS] = CALCULATEPRVALUE(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/10/22 22:55:20 
% Revision: 0.1 

% Load statistic data for all classes
classDictFile = 'data/ClassDict.mat';
classDict=load(classDictFile, "ClassDict").ClassDict;

inputLen=size(topImgs,2);

% Get all image names
imgClass={topImgs.class};
imgClass=string(imgClass);

% Get the true class of this image data, because the first 	image is the query image
% queryImg=topImgs(:,1);
% queryImgName=queryImg.name;
trueClass=split(queryImgName, "_");
trueClass=trueClass{1};

% Get the class's data
classData=classDict(trueClass);
allPLen=length(classData);

precision = zeros(inputLen,1);
recall = zeros(inputLen,1);

for i=1:inputLen
    % Calculate precision and recall for top 1 to top 10 results
    topImgClass=imgClass(1:i);
    TP = sum(topImgClass == trueClass);

    % Calculate Precision
    precision(i) = TP / i;
    
    % Calculate Recall
    recall(i) = TP / allPLen;

end

PRValues(end+1).name=queryImgName;
PRValues(end).P=precision;
PRValues(end).R=recall;

end
