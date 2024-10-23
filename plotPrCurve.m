function plotPrCurve(precisionData, reacallData, legendNames)
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
    disp('%d, %d', legendLen, precisionSize)
    msg = 'Error: the columns of Precision data and Recall data is not equal to the length of legends!';
    error(msg)
end

% Plot curve based on precision_list and reacall_list
for i = 1:legendLen
    precisionY = precisionData(i,:);
    recallX = reacallData(i,:);
    plot(recallX, precisionY,'LineWidth',2);
    hold on

end

% Set the format of the chart

% Set the legend
legendName = legend(legendNames);
legendName.ItemTokenSize = [30 30];
set(legendName,'Box','off')

% Set the Position and size of chart
set(gcf,'Position',[100 100 260 220]);
% Set the font format of axis
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);

% Set the labels
xlabel('\fontname{Times New Roman}\fontsize{25}Recall');
ylabel('\fontname{Times New Roman}\fontsize{25}Precision');

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
set(gca,'LooseInset',get(gca,'TightInset'))
box off;