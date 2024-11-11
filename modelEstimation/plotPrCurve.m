function plotPrCurve(precisionData, reacallData, legendNames, graphName, subSavingPath)
% PLOT_PR_CURVE Summary of this function goes here
% precisionData: Array data for the precision data of N experiments
% reacallData: Array data for the recall data of N experiments
% legendNames: the names for N experiments
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/10/20 23:24:12 
% Revision: 0.1 

precisionSize  = size(precisionData);
recallSize = size(reacallData);
legendLen = length(legendNames);

% Check the Precision data and Recall data
if (precisionSize(2) ~= legendLen) || (recallSize(2) ~= legendLen)
    disp('%d, %d', legendLen, precisionSize(2));
    msg = 'Error: the columns of Precision data and Recall data is not equal to the length of legends!';
    error(msg)
end

% Plot curve based on precision_list and reacall_list
colors = jet(legendLen);  % 'jet' colormap with 'numCurves' colors
figure('Position',[100 100 500 500],'Visible', 'off');
hold on;

h = gobjects(1, legendLen);  % Initialize an array of graphics objects for the curves

for i = 1:legendLen
    precisionY = precisionData(:,i);
    recallX = reacallData(:,i);

    % Plot the curve
    h(i)=plot(recallX, precisionY, 'Color', colors(i, :), 'LineWidth',2);

    % Plot the points on the curve
    plot(recallX, precisionY, 'o', 'MarkerSize', 2, 'MarkerFaceColor', 'auto');  % Red circles for the points

end
hold off;

% Set the format of the chart
% Set the legend
% Replace the special symbols in the legendNames
legendName = legend(h,legendNames,'Location', 'northeast');
legendName.ItemTokenSize = [30 30];
set(legendName,'Box','off');


% Adjust the axes position for margins
% Get current axes
ax = gca;
% Position: [left, bottom, width, height]
ax.Position = [0.1, 0.1, 0.8, 0.8];


% Set the paper position mode
set(gcf, 'PaperPositionMode', 'auto');

% Set the font format of axis
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 10);

% Set the title
graphNameRe=strrep(graphName,'_','\_');
titleStr=strjoin(['PR Curve of ', graphNameRe, ' with different Q values']);
title(titleStr,'FontSize', 12);
% Set the labels
xlabel('\fontname{Times New Roman}\fontsize{12}Recall');
ylabel('\fontname{Times New Roman}\fontsize{12}Precision');
grid on;

% Set the scale
Xmin=0;
Xmax=1;
Ymin=0;
Ymax=1;

% Set maximum and minmum of X and Y
axis([Xmin,Xmax,Ymin,Ymax]);

% Set axis label 
set(gca,'XTick',(0.2:0.2:Xmax));
set(gca,'YTick',(Ymin:0.2:Ymax));
set(gca,'LooseInset',get(gca,'TightInset'));
box off;

% Save the graph as a high-resolution PNG file
saveDir=[GlobalSetting.filePathInfo.PR_GRAPH_PATH, '/', subSavingPath];
if ~exist(saveDir, 'dir')
    % Create the new directory
    mkdir(saveDir);
end
savePath=[saveDir, '/', graphName, '.png'];
savePath=strjoin(savePath,'');

% exportgraphics(gcf, savePath, 'Resolution', 300);
% Save the figure as a PNG file with specified margins
print(gcf, savePath, '-dpng', '-r300');  % '-r300' sets 300 DPI for high resolution
