%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/10/2024 00:53

clc;
close all;
clear;

% Define the image file path
% DATASET_FOLDER = 'data/MSRC_ObjCategImageDatabase_v2';
% allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));

allfiles = global_setting.allfiles;
files_len = length(allfiles);

% Set the test ratio
test_ratio = 0.2;
num_test = round(test_ratio*files_len);

% Get the test files
rand_index = randperm(files_len);        
test_files = allfiles(rand_index(1:num_test),:); 

% Save data
test_data_file = 'data/test_data.mat';
save(test_data_file, 'test_files');