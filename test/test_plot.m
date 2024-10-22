%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 21/10/2024 00:04

clc;
close all;
clear;

data = xlsread('pr.xlsx');
clsdv7 = data(:,1);
clsv7 = data(:,3);
precisions = [clsdv7 clsv7];
tinydv7= data(:,2);
tinyv7 = data(:,4);
recalls = [tinydv7 tinyv7];

legends = ["YOLOv7-Tiny", "YOLOv7"];
plot_pr_curve(precisions, recalls, legends)
