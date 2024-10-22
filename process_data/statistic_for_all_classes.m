%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 21/10/2024 23:04

clc;
close all;
clear;

% % Define the image file path
% DATASET_FOLDER = 'data/MSRC_ObjCategImageDatabase_v2';
% allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
allfiles=global_setting.allfiles;

% grouping all the image files by 20 classes. 
% The first character of the filename are the class name.

% Create a dictionary to store the image files
class_dict = containers.Map();

for i = 1:length(allfiles)
    filename = allfiles(i).name;
    class_name = split(filename, "_");
    class_name = class_name{1};
    
    % Check if the class name is already in the dictionary
    if isKey(class_dict, class_name)
      currentList = class_dict(class_name);
      currentList{end+1} = filename;
      class_dict(class_name) = currentList;
    else
      class_dict(class_name) = {filename};
    end
end

% Store the dictionary to a file
class_dict_file = 'data/class_dict.mat';
save(class_dict_file, 'class_dict');
