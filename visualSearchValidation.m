%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/10/2024 20:53

clc;
close all;
clear;

% Experiment with different levels of RGB quantization
% Make a list of Q values the range from 1 to 8, strading by 2
QLevels = 1:5:40;

% Load test data
testDataFile=GlobalSetting.filePathInfo.TEST_DATA;
testData=load(testDataFile, 'testFiles').testFiles;
% testData=testData(1:2,:);
% testDataLen=length(testData);

%% Get the feature data under different Q levels
precisionData=[];
reacallData=[];
legendNames=[];
tic;
for i = 1:length(QLevels)
    Q = QLevels(i);
    fprintf("Testing when Q = %d\n", Q);
    fprintf("1. Start computing descriptors ...\n");
    computeDescriptors(Q);

    % Test all test data
    fprintf("2. Start testing ...\n")
    % Define the Stuct for all features
    PRValues=struct('name', {}, 'P', {}, 'R', {});
    % add progress bar
    h = waitbar(0, 'Testing data...');
    for j = 1:testDataLen
        currentImg = testData(j);
        fileName = currentImg.name;
        % fprintf("Testing file: %s ...\n", fileName);
        topImgs=visualSearch(fileName);
        PRValues = computePrValue(topImgs, PRValues);

        % Show progress bar
        waitbar(j / testDataLen, h, sprintf('Progress: %d%%', round(j/testDataLen*100)));
    end
    precisionData=[precisionData; [PRValues.P]];
    reacallData=[reacallData; [PRValues.R]];
    strQ=strcat("Q is ", num2str(Q));
    legendNames=[legendNames strQ];
end

fprintf("Finally, plot the PR curve...")
plotPrCurve(precisionData, reacallData, legendNames);
toc
