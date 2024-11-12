%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 21/10/2024 00:04

clc;
close all;
clear;

% file='cwsolution/descriptors/globalRGBhisto';
% file='data';
% % file_name='/20_1_s.mat';
% file_name='/test_data.mat';
% file_path=([file, file_name]);
% disp(file_path);
% data=load(file_path);


% DESCRIPTOR_SUBFOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_SUBFOLDER;
% Define the output file path for feature data
OUT_FOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_FOLDER;
allFeatFile=[OUT_FOLDER,'/AllFeaturesBoVW.mat'];
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