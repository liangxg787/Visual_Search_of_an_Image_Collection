%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/10/2024 20:53

clc;
close all;
clear;

% Experiment with different levels of RGB quantization
% Make a list of Q values the range from 1 to 8, strading by 2
QLevels = 5:5:9;
QLevelLen=length(QLevels);

% Load test data
testDataFile=GlobalSetting.filePathInfo.TEST_DATA;
testData=load(testDataFile, 'testFiles').testFiles;
% Sample test data
testData=testData(1:2,:);
testDataLen=length(testData);

% Set the graphs saving path
subSvaingPath='rgbHist';

% Define the model type and distance type
ModelType = 'RGBHist';
distanceType = 'euclidean';

tic;
% add progress bar
% h = waitbar(0, 'Testing data...');

% Starting parallel pool to accelerate the computing with parfor
% Test every picture in the test dataset and save it's PR curve.
% Test all test data
fprintf("Start testing ...\n");
% Define the Stuct for all features
PRValues=struct('parameter', {}, 'name', {}, 'P', {}, 'R', {});

for j = 1:QLevelLen
    tic;
    Q = QLevels(j);
    label=strcat("Q: ", num2str(Q));

    fprintf("Testing when Q = %d\n", Q);
    fprintf("1. Start computing descriptors ...\n");
    AllFeatures=computeDescriptors(ModelType, Q);

    for i = 1:testDataLen
        currentImg = testData(i);
        fileName = currentImg.name;
        fileName=string(fileName);
        fprintf("*** Testing file: %s ...\n", fileName);

        fprintf("2. Start searching for the image ...\n");
        topImgs=searchFunction(distanceType,fileName,AllFeatures);
        
        % Save the result for top n result, n= GlobalSetting.SHOW
        saveTopImages(topImgs, subSvaingPath, fileName);

        % Compute PR value
        PRValues(end+1).parameter=label;
        PRValues = computePrValue(topImgs, PRValues,fileName);

        % Plot confusion matrix
        % fprintf("Finally, plot confusion matrix...\n")
        % AllFeaturesLen=length(AllFeatures);
        % computeConfusionMatrix(topImgs,fileName,AllFeaturesLen,subSvaingPath,strQ);

    end
    toc
    % Show progress bar
    % waitbar(j / testDataLen, h, sprintf('Progress: %d%%', round(j/testDataLen*100)));
end

% Prepare data for plotting
parameterData = {PRValues.parameter};
nameData = {PRValues.name};
parameterData = cellfun(@(x) num2str(x), {PRValues.parameter}, 'UniformOutput',0);
nameData = cellfun(@(y) num2str(y), {PRValues.name}, 'UniformOutput',0);
precisionData = {PRValues.P};
reacallData = {PRValues.R};

% Get unique values for name, prarameter
parameterUnique = unique(parameterData);
nameUnique = unique(nameData);

% Plot PR Curve
for i = 1:testDataLen
    fileName = nameUnique{i};
    fileName=string(fileName);

    % Find the index of the corresponding data
    idxes = find(strcmp(nameData, fileName));

    legendNames=parameterData(idxes);
    precisions=precisionData(idxes);
    reacalls=reacallData(idxes);

    precisions=cell2mat(precisions);
    reacalls=cell2mat(reacalls);

    fprintf("Finally, plot the PR curve...\n")
    plotPrCurve(precisions, reacalls, legendNames, fileName, subSvaingPath);
end

toc
