%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 30/10/2024 11:31

clc;
close all;
clear;

% Experiment with different levels of RGB quantization
% Make a list of Q values the range from 1 to 30, strading by 5
QLevels = 5:5:9;
QLevelLen=length(QLevels);

% Experiment with different levels of the size of each grid cell in pixels,e.g 3*3, 4*4, etc
% Make a list of gridPixelSize values the range from 5 to 50, strading by 5
gridPixelSize = 5:5:50;
gridPixelSizeLen=length(gridPixelSize);


% Load test data
testDataFile=GlobalSetting.filePathInfo.TEST_DATA;
testData=load(testDataFile, 'testFiles').testFiles;
% Sample test data
testData=testData(1:2,:);
testDataLen=length(testData);

% Set the graphs saving path
subSvaingPath='rgbHist';

tic;
% add progress bar
% h = waitbar(0, 'Testing data...');

% Starting parallel pool to accelerate the computing with parfor
% Test every picture in the test dataset and save it's PR curve.
% Test all test data
fprintf("Start testing ...\n");
for i = 1:testDataLen
    currentImg = testData(i);
    fileName = currentImg.name;
    fileName=string(fileName);
    fprintf("*** Testing file: %s ...\n", fileName);
    % Define the Stuct for all features
    PRValues=struct('name', {}, 'P', {}, 'R', {});
    % Get the feature data under different Q levels
    legendNames=strings(1,QLevelLen);
    for j = 1:QLevelLen
        tic;
        Q = QLevels(j);
        strQ=strcat("Q is ", num2str(Q));
        legendNames(j)=strQ;

        fprintf("Testing when Q = %d\n", Q);
        fprintf("1. Start computing descriptors ...\n");
        AllFeatures=rgbHistogramDescriptors(Q);

        fprintf("2. Start searching for the image ...\n");
        topImgs=rgbHistogramSearch(fileName,AllFeatures);
        PRValues = computePrValue(topImgs, PRValues,fileName);

        % Plot confusion matrix
        % fprintf("Finally, plot confusion matrix...\n")
        % AllFeaturesLen=length(AllFeatures);
        % computeConfusionMatrix(topImgs,fileName,AllFeaturesLen,subSvaingPath,strQ);

        toc
    end
    % Store PR data
    precisionData={PRValues.P};
    precisionData=cell2mat(precisionData);
    reacallData={PRValues.R};
    reacallData=cell2mat(reacallData);

    % Plot PR Curve
    fprintf("Finally, plot the PR curve...\n")
    plotPrCurve(precisionData, reacallData, legendNames, fileName, subSvaingPath);


    % Show progress bar
    % waitbar(j / testDataLen, h, sprintf('Progress: %d%%', round(j/testDataLen*100)));
end
toc