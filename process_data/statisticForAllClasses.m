%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 21/10/2024 23:04

clc;
close all;
clear;

% % Define the image file path
allFiles=GlobalSetting.filePathInfo.allFiles;

% grouping all the image files by 20 classes. 
% The first character of the filename are the class name.

% Create a dictionary to store the image files
ClassDict = containers.Map();

for i = 1:length(allFiles)
    fileName = allFiles(i).name;
    className = split(fileName, "_");
    className = className{1};
    
    % Check if the class name is already in the dictionary
    if isKey(ClassDict, className)
      currentList = ClassDict(className);
      currentList{end+1} = fileName;
      ClassDict(className) = currentList;
    else
      ClassDict(className) = {fileName};
    end
end

% Store the dictionary to a file
classDictFile = 'data/ClassDict.mat';
save(classDictFile, 'ClassDict');
