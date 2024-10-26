%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 25/10/2024 16:14

clc;
close all;
clear;


target = double(imread('data/MSRC_ObjCategImageDatabase_v2/Images/1_1_s.bmp')) ./255;
target_obs=[reshape(target(:,:,1),1,[]); reshape(target(:,:,2),1,[]); reshape(target(:,:,3),1,[])];

method='keepf';
energyRate=1;
% method='keepn';
% dimensions=2;
[pobs E]=Eigen_PCA(target_obs,method,energyRate);
E_=Eigen_Build(target_obs);

target_obs_new=target_obs(:,1);
mdist1=Eigen_Mahalanobis(target_obs_new,E);
mdist1_=Eigen_Mahalanobis(pobs,E);


mdist2=Eigen_Mahalanobis(target_obs,E_);
mdist2_=Eigen_Mahalanobis(pobs,E_);
