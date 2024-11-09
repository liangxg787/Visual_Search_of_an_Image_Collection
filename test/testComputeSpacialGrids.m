%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 27/10/2024 20:52

clc;
close all;
clear;

imgfname_full=([GlobalSetting.filePathInfo.DATASET_FOLDER,'/Images/','20_3_s.bmp']);
img=imread(imgfname_full);
% The number of grids for row and column respectively
grids=50;
% FUNC='RGB';
FUNC='both';
Q=4;
allGridHist=computeSpacialGrids(img,grids,FUNC,Q);