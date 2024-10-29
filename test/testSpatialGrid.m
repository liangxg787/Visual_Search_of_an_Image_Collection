%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 27/10/2024 20:52

clc;
close all;
clear;

imgfname_full=([GlobalSetting.filePathInfo.DATASET_FOLDER,'/Images/','1_1_s.bmp']);
img=imread(imgfname_full);
gridPixelSize=4;
G=4;
% FUNC='RGB';
FUNC='both';
Q=4;
% all_grid_hist=cvpr_computeGrids(img,G,FUNC,Q);
all_grid_hist=computeSpacialGrids(img,gridPixelSize,FUNC,Q);