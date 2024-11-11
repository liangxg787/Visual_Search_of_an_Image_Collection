%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 30/10/2024 11:31

clc;
close all;
clear;

% Experiment with different levels of RGB quantization
% Make a list of Q values the range from 1 to 30, strading by 5
QLevels = 5:5:10;
QLevelLen=length(QLevels);

% Experiment with different levels of the size of each grid cell in pixels,e.g 3*3, 4*4, etc
% Make a list of gridPixelSize values the range from 5 to 50, strading by 5
gridsList = 5:5:10;
gridsLen=length(gridsList);

% featureTypeList = {'colour', 'texture', 'both'};
featureTypeList = {'texture','both'};
featureTypeLen=length(featureTypeList);

% Load test data
testDataFile=GlobalSetting.filePathInfo.TEST_DATA;
testData=load(testDataFile, 'testFiles').testFiles;
% Sample test data
testData=testData(1:2,:);
testDataLen=length(testData);

% Define the model type and distance type
ModelType = 'spacialGrid';
distanceType = 'euclidean';
% Set the graphs saving path
subSavingPath = ModelType;

tic;
% add progress bar
h = waitbar(0, 'Testing data...');

% Starting parallel pool to accelerate the computing with parfor
% Test every picture in the test dataset and save it's PR curve.
% Test all test data
fprintf("Start testing ...\n");
% Define the Stuct for all features
% PRValues=struct('parameter', {}, 'name', {}, 'P', {}, 'R', {});
% Preallocate the cell array to store results
PRValuesCell = cell(QLevelLen*gridsLen*featureTypeLen, 1);

% Get the feature data under different Q levels
parfor j = 1:QLevelLen
    Q = QLevels(j);
    tic;
    % Get the feature data under different gridPixelSize
    for k = 1:gridsLen
        grids = gridsList(k);

        % Get the feature data under different featureType
        for m = 1:featureTypeLen
            featureType = featureTypeList(m);
            featureType = cell2mat(featureType);

            label=strcat("Q:", num2str(Q), ', grids:', num2str(grids), ', featureType:', featureType);

            fprintf("Testing when %s\n", label);
            fprintf("1. Start computing descriptors ...\n");
            AllFeatures = computeDescriptors(ModelType,featureType,grids,Q);

            PRValues = struct('parameter', {}, 'name', {}, 'P', {}, 'R', {});

            for i = 1:testDataLen
                currentImg = testData(i);
                fileName = currentImg.name;
                fileName=string(fileName);
                fprintf("*** Testing file: %s ...\n", fileName);

                fprintf("2. Start searching for the image ...\n");
                topImgs=searchFunction(distanceType,fileName,AllFeatures);

                % Save the result for top n result, n= GlobalSetting.SHOW
                saveTopImages(topImgs, subSavingPath, fileName);

                % Compute PR value
                PRValues(end+1).parameter=label;
                PRValues = computePrValue(topImgs, PRValues,fileName);

                % Plot confusion matrix
                % fprintf("Finally, plot confusion matrix...\n")
                % AllFeaturesLen=length(AllFeatures);
                % computeConfusionMatrix(topImgs,fileName,AllFeaturesLen,subSavingPath,strQ);
            end

        end
        toc
        % Store the results in the cell array
        PRValuesCell{j} = PRValues;
    end
    % Show progress bar
    waitbar(j / QLevelLen, h, sprintf('Progress: %d%%', round(j/testDataLen*100)));
end

% Combine the results from the cell array
PRValues = [];
for j = 1:QLevelLen
    PRValues = [PRValues; PRValuesCell{j}];
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
    plotPrCurve(precisions, reacalls, legendNames, fileName, subSavingPath);
end

toc
