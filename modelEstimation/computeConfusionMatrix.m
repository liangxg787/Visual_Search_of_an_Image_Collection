function computeConfusionMatrix(topImgs,queryImgName,dataLen,subSavingPath,strQ)
arguments
    topImgs
    queryImgName
    dataLen
    subSavingPath
    strQ=''
end
% COMPUTECONFUSIONMATRIX Summary of this function goes here
% 
% [OUTPUTARGS] = COMPUTECONFUSIONMATRIX(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/10/24 21:15:16 
% Revision: 0.1 


% Load statistic data for all classes
classDictFile = 'data/ClassDict.mat';
classDict=load(classDictFile, "ClassDict").ClassDict;

% Get true class
trueClassName = split(queryImgName, "_");
trueClass = trueClassName{1};

inputLen=size(topImgs,2);
TP=0;
FP=0;
for i=1:inputLen
    currentImg=topImgs(:,i);
    imgName=currentImg.name;
    className = split(imgName, "_");
    className = className{1};

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

% Calculate the TN
TN=dataLen-TP-FP-FN;

% Make the input data for the function confusionchart
predictLabels=[ones(TP,1); ones(FP,1); zeros(FN,1); zeros(TN,1)];
trueLabels=[ones(TP,1); zeros(FP,1); ones(FN,1);  zeros(TN,1)];

predictLabels=string(predictLabels);
trueLabels=string(trueLabels);

trueClassName=strjoin({'class_', trueClass},'');
otherClassName='other_class';
predictLabels=replace(predictLabels,'1',trueClassName);
predictLabels=replace(predictLabels,'0',otherClassName);
trueLabels=replace(trueLabels,'1',trueClassName);
trueLabels=replace(trueLabels,'0',otherClassName);

% Plot the confusion matrix
% cm = confusionchart(trueLabels,predictLabels);

fig = figure;
cm = confusionchart(trueLabels,predictLabels,'RowSummary','row-normalized','ColumnSummary','column-normalized');
queryImgName_=strrep(queryImgName, '_', '\_');
if isempty(strQ)
    cm.Title = 'Confusion Matrix for ' + queryImgName_;
else
    cm.Title = 'Confusion Matrix for ' + queryImgName_ + 'when ' + strQ;
end

fig_Position = fig.Position;
fig_Position(3) = fig_Position(3)*1.5;
fig.Position = fig_Position;

% Save the graph as a high-resolution PNG file
saveDir = [GlobalSetting.filePathInfo.CM_GRAPH_PATH, '/', subSavingPath];
if ~exist(saveDir, 'dir')
    % Create the new directory
    mkdir(saveDir);
end
savePath=[saveDir, '/', queryImgName, '.png'];
savePath=strjoin(savePath,'');

% exportgraphics(fig, savePath, 'Resolution', 300);
% Save the figure as a PNG file with specified margins
print(gcf, savePath, '-dpng', '-r300');  % '-r300' sets 300 DPI for high resolution
end
