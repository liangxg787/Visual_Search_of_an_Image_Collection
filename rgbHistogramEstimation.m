%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/10/2024 20:53

clc;
close all;
clear;

% Experiment with different levels of RGB quantization
% Make a list of Q values the range from 1 to 8, strading by 2
QLevels = 1:5:21;
QLevelLen = length(QLevels);

% Load test data
testDataFile = GlobalSetting.filePathInfo.TEST_DATA;
testData = load(testDataFile, 'testFiles').testFiles;
% Sample test data
% testData = testData(1:2,:);
testDataLen = length(testData);

% Define the model type and distance type
ModelType = 'RGBHist';
distanceType = 'euclidean';
% Set the graphs saving path
subSavingPath = ModelType;

tic;
% add progress bar
% h = waitbar(0, 'Testing data...');

% Starting parallel pool to accelerate the computing with parfor
% Test every picture in the test dataset and save its PR curve.
% Test all test data
fprintf("Start testing ...\n");

% Preallocate the cell array to store results
PRValuesCell = cell(QLevelLen, 1);

parfor j = 1:QLevelLen
    tic;
    Q = QLevels(j);
    label = strcat("Q: ", num2str(Q));

    fprintf("Testing when Q = %d\n", Q);
    fprintf("1. Start computing descriptors ...\n");
    AllFeatures = computeDescriptors(ModelType, Q);

    PRValues = struct('parameter', {}, 'name', {}, 'P', {}, 'R', {});

    for i = 1:testDataLen
        currentImg = testData(i);
        fileName = currentImg.name;
        fileName = string(fileName);
        fprintf("*** Testing file: %s ...\n", fileName);

        fprintf("2. Start searching for the image ...\n");
        topImgs = searchFunction(distanceType, fileName, AllFeatures);
        
        % Save the result for top n result, n= GlobalSetting.SHOW
        saveTopImages(topImgs, subSavingPath, fileName);

        % Compute PR value
        PRValues(end+1).parameter = label;
        PRValues = computePrValue(topImgs, PRValues, fileName);

        % Plot confusion matrix
        % fprintf("Finally, plot confusion matrix...\n")
        % AllFeaturesLen = length(AllFeatures);
        % computeConfusionMatrix(topImgs, fileName, AllFeaturesLen, subSavingPath, strQ);
    end
    toc
    % Store the results in the cell array
    PRValuesCell{j} = PRValues;
    % Show progress bar
    % t_a = j*i;
    % t_b = QLevelLen*testDataLen;
    % waitbar(t_a / t_b, h, sprintf('Progress: %d%%', round(t_a/t_b*100)));
end

% Combine the results from the cell array
PRValues = [];
for j = 1:QLevelLen
    PRValues = [PRValues; PRValuesCell{j}];
end

% Prepare data for plotting
parameterData = {PRValues.parameter};
nameData = {PRValues.name};
parameterData = cellfun(@(x) num2str(x), {PRValues.parameter}, 'UniformOutput', false);
nameData = cellfun(@(y) num2str(y), {PRValues.name}, 'UniformOutput', false);
precisionData = {PRValues.P};
recallData = {PRValues.R};

% Get unique values for name, parameter
parameterUnique = unique(parameterData);
nameUnique = unique(nameData);

% Plot PR Curve
for i = 1:testDataLen
    fileName = nameUnique{i};
    fileName = string(fileName);

    % Find the index of the corresponding data
    idxes = find(strcmp(nameData, fileName));

    legendNames = parameterData(idxes);
    precisions = precisionData(idxes);
    recalls = recallData(idxes);

    precisions = cell2mat(precisions);
    recalls = cell2mat(recalls);

    fprintf("Finally, plot the PR curve...\n");
    plotPrCurve(precisions, recalls, legendNames, fileName, subSavingPath);
end

toc