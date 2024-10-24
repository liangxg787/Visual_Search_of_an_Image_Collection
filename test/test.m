%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/10/2024 17:42

clc;
close all;
clear;
TP=1;
FP=9;
FN=29;
TN=100-TP-FP-FN;

% Make the input data for the function confusionchart
predictLabels=[ones(TP,1); ones(FP,1); zeros(FN,1); zeros(TN,1)];
trueLabels=[ones(TP,1); zeros(FP,1); ones(FN,1);  zeros(TN,1)];

predictLabels=string(predictLabels);
trueLabels=string(trueLabels);

trueClassName=strjoin({'class_' '1'},'');
predictLabels=replace(predictLabels,'1',trueClassName);
predictLabels=replace(predictLabels,'0','imge2');
trueLabels=replace(trueLabels,'0','imge2');
trueLabels=replace(trueLabels,'1','imge1');

% Plot the confusion matrix
% cm = confusionchart(trueLabels,predictLabels);

fig = figure;
cm = confusionchart(trueLabels,predictLabels,'RowSummary','row-normalized','ColumnSummary','column-normalized');
fig_Position = fig.Position;
fig_Position(3) = fig_Position(3)*1.5;
fig.Position = fig_Position;

% Save the graph as a high-resolution PNG file
save_path=[GlobalSetting.filePathInfo.CM_GRAPH_PATH, '/', 'test', '.png'];
exportgraphics(fig, save_path, 'Resolution', 300);