%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 10/11/2024 14:18

clc;
close all;
clear;

% Load test data
testDataFile=GlobalSetting.filePathInfo.TEST_DATA;
testData=load(testDataFile, 'testFiles').testFiles;
% Sample test data
% testData=testData(1:2,:);
testDataLen=length(testData);

% Define the model type and distance type
ModelType = 'SIFT';
distanceType = 'euclideanMatrix';
% Set the graphs saving path
subSavingPath=ModelType;

% Experiment with different levels of RGB quantization
% Make a list of NumOctaves values the range from 3 to 10, strading by 2
NumOctavesList = 3:1:3;
NumOctavesLen=length(NumOctavesList);

% Experiment with different levels of the size of each grid cell in pixels,e.g 3*3, 4*4, etc
% Make a list of NumLevels values the range from 5 to 50, strading by 5
NumLevelsList = 5:5:25;
NumLevelsLen=length(NumLevelsList);

tic;
% add progress bar
% h = waitbar(0, 'Testing data...');

% Starting parallel pool to accelerate the computing with parfor
% Test every picture in the test dataset and save it's PR curve.
% Test all test data
fprintf("Start testing ...\n");

% Preallocate the cell array to store results
PRValuesCell = cell(NumOctavesLen, 1);

% Get the feature data under different NumOctaves
parfor j = 1:NumOctavesLen
    NumOctaves = NumOctavesList(j);
    tic;

    PRValues = struct('parameter', {}, 'name', {}, 'P', {}, 'R', {});

    % Get the feature data under different NumLevels
    for k = 1:NumLevelsLen
        NumLevels = NumLevelsList(k);

        label=strcat("NumOctaves:", num2str(NumOctaves), ', NumLevels:', num2str(NumLevels));

        fprintf("Testing when %s\n", label);
        fprintf("1. Start computing descriptors ...\n");
        AllFeatures = computeDescriptors(ModelType,NumOctaves,NumLevels);

        for i = 1:testDataLen
            currentImg = testData(i);
            fileName = currentImg.name;
            fileName=string(fileName);
            fprintf("*** Testing file: %s ...\n", fileName);

            fprintf("2. Start searching for the image ...\n");
            topImgs=searchFunction(distanceType,fileName,AllFeatures);

            % Save the result for top n result, n= GlobalSetting.SHOW
            subSavingPathImg = {subSavingPath, num2str(NumOctaves), num2str(NumLevels)};
            subSavingPathImg = strjoin(subSavingPathImg, '_');
            saveTopImages(topImgs, subSavingPathImg, fileName);

            % Compute PR value
            PRValues(end+1).parameter = label;
            PRValues = computePrValue(topImgs, PRValues, fileName);

            % Plot confusion matrix
            % fprintf("Finally, plot confusion matrix...\n")
            % AllFeaturesLen = length(AllFeatures);
            % computeConfusionMatrix(topImgs, fileName, AllFeaturesLen, subSavingPath, strQ);
        end
    end
    toc
    % Store the results in the cell array
    PRValuesCell{j} = PRValues;

    % Show progress bar
    % t_a = j*k*i;
    % t_b = NumOctavesLen*NumLevelsLen*testDataLen;
    % waitbar(t_a / t_b, h, sprintf('Progress: %d%%', round(t_a/t_b*100)));
end

% Combine the results from the cell array
PRValues = [];
for j = 1:NumOctavesLen
    PRValues = [PRValues; PRValuesCell{j}];
end

% Prepare data for plotting
parameterData = {PRValues.parameter};
nameData = {PRValues.name};
parameterData = cellfun(@(x) num2str(x), parameterData, 'UniformOutput', false);
nameData = cellfun(@(y) num2str(y), nameData, 'UniformOutput', false);
precisionData = {PRValues.P};
reacallData = {PRValues.R};

% Get unique values for name, parameter
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
    plotPrCurve(precisions, reacalls, legendNames, fileName, subSavingPath);
end

toc
