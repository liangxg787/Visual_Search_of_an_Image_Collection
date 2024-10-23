function PRValues = computePrValue(topImgs,PRValues)
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
TP=0;
FP=0;
for i=1:inputLen
    currentImg=topImgs(:,i);
    imgName=currentImg.name;
    className = split(imgName, "_");
    className = className{1};

    if i == 1
      % Get the true class of this image data, because the first 	image is the query image
      trueClass=className;
      queryImg=imgName;
    end
    if className == trueClass
      TP=TP+1;
    else
      FP=FP+1;
    end
end

% Get the class's data
classData=classDict(trueClass);
allPLen=length(classData);
FN=allPLen-TP;

% Calculate the precision and recall
P=TP/(TP+FP);
R=TP/(TP+FN);

PRValues(end+1).name=queryImg;
PRValues(end).P=P;
PRValues(end).R=R;

end
