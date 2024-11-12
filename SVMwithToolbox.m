%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 12/11/2024 15:32

clc;
close all;
clear;

% DESCRIPTOR_SUBFOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_SUBFOLDER;
% Define the output file path for feature data
OUT_FOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_FOLDER;
allFeatFile=[OUT_FOLDER,'/AllFeaturesspacialGrid.mat'];
AllFeatures=load(allFeatFile, 'AllFeatures').AllFeatures;


%% 2) Separate the data in training and test
FeatLen = length(AllFeatures);

% Get the train data and test data
trainData = AllFeatures;

trainObs = {trainData.feature};
trainClass = {trainData.class};
trainClassUnique = unique(trainClass);
trainClass = cellfun(@(x) str2num(x), {trainData.class}, 'UniformOutput',0);

trainObs = trainObs';

trainObs = cell2mat(trainObs);
trainClass = cell2mat(trainClass);