function plotPrCurve(precisionData, reacallData, legendNames, graphName)
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
figure('Position',[100 100 400 400]);
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
legendName = legend(h,legendNames,'Location', 'best');
legendName.ItemTokenSize = [30 30];
set(legendName,'Box','off')


% Adjust the axes position for margins
ax = gca;  % Get current axes
ax.Position = [0.1, 0.1, 0.8, 0.8];  % [left, bottom, width, height]
% Optional: Adjust the figure window size
set(gcf, 'PaperPositionMode', 'auto');  % Set the paper position mode

% Set the font format of axis
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 10);

% Set the title
graphNameRe=strrep(graphName,'_','\_');
title(['PR Curve of ', graphNameRe, ' with different Q values'],'FontSize', 14);
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
save_path=[GlobalSetting.filePathInfo.PR_GRAPH_PATH, '/', graphName, '.png'];
save_path=strjoin(save_path,'');
exportgraphics(gcf, save_path, 'Resolution', 300);
