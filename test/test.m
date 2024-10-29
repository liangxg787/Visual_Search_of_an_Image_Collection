%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/10/2024 17:42

clc;
close all;
clear;



tic
x = zeros(1,100);
for k = 2:1000000
   x(k) = x(k-1) + 5;
end
toc