%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 10/11/2024 12:56

clc;
close all;
clear;


A = [1 2 3 4; 4 5 6 7; 7 8 9 9; 7 8 9 9];
B = [1 2 1; 4 0 6; 7 8 5];
similarity = euclideanDistanceForMatrix(A, B);
disp(['Similarity: ', num2str(similarity)]);
