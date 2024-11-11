%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 25/10/2024 20:36

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
ModelType = 'PCA';
distanceType = 'Eigen_Mahalanobis';
% Set the graphs saving path
subSavingPath=ModelType;

tic;
% add progress bar
% h = waitbar(0, 'Testing data...');

% Starting parallel pool to accelerate the computing with parfor
% Test every picture in the test dataset and save it's PR curve.
% Test all test data
fprintf("Start testing ...\n");
parfor i = 1:testDataLen
    currentImg = testData(i);
    fileName = currentImg.name;
    fileName=string(fileName);
    fprintf("*** Testing file: %s ...\n", fileName);
    % Define the Stuct for all features
    PRValues=struct('name', {}, 'P', {}, 'R', {});

    fprintf("1. Start computing descriptors ...\n");
    AllFeatures=computeDescriptors(ModelType);

    fprintf("2. Start searching for the image ...\n");
    topImgs=searchFunction(distanceType,fileName,AllFeatures);

    % Save the result for top n result, n= GlobalSetting.SHOW
    saveTopImages(topImgs, subSavingPath, fileName);

    % Compute PR value
    PRValues = computePrValue(topImgs, PRValues,fileName);

    % Plot confusion matrix
    % fprintf("Finally, plot confusion matrix...\n")
    % AllFeaturesLen=length(AllFeatures);
    % computeConfusionMatrix(topImgs,fileName,AllFeaturesLen,subSavingPath);

    % Store PR data
    precisionData={PRValues.P};
    precisionData=cell2mat(precisionData);
    reacallData={PRValues.R};
    reacallData=cell2mat(reacallData);

    % Plot PR Curve
    fprintf("Finally, plot the PR curve...\n")
    legendNames=strrep(fileName, '_', '\_');
    plotPrCurve(precisionData, reacallData, legendNames, fileName, subSavingPath);


    % Show progress bar
    % waitbar(j / testDataLen, h, sprintf('Progress: %d%%', round(j/testDataLen*100)));
end
toc