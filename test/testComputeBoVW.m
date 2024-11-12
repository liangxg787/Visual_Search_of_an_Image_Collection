%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 11/11/2024 22:52

clc;
close all;
clear;


% Define the output file path for feature data
OUT_FOLDER=GlobalSetting.filePathInfo.DESCRIPTOR_FOLDER;
allFeatFile=[OUT_FOLDER,'/AllFeaturesBoVW.mat'];

FeatData=load(allFeatFile);
FeatData = FeatData.AllFeatures;


FeatData = computeBoVW(FeatData);
