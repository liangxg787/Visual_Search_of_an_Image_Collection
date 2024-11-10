%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/10/2024 00:53

clc;
close all;
clear;

% Define the image file path

allFiles = GlobalSetting.filePathInfo.allFiles;
filesLen = length(allFiles);

% Set the test ratio
% testRatio = 0.2;
testRatio = 1;
numTest = round(testRatio*filesLen);

% Get the test files
randIndex = randperm(filesLen);        
testFiles = allFiles(randIndex(1:numTest),:); 

% Save data
testDataFile = GlobalSetting.filePathInfo.TEST_DATA;
save(testDataFile, 'testFiles');