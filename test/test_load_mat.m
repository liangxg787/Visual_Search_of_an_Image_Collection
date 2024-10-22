%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 21/10/2024 00:04

clc;
close all;
clear;

% file='cwsolution/descriptors/globalRGBhisto';
file='data'
% file_name='/20_1_s.mat';
file_name='/test_data.mat'
file_path=([file, file_name]);
disp(file_path)
data=load(file_path);