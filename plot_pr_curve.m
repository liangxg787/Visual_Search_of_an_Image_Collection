function plot_pr_curve(precision_data, reacall_data, legend_names)
% PLOT_PR_CURVE Summary of this function goes here
% precision_data: Array data for the precision data of N experiments
% reacall_data: Array data for the recall data of N experiments
% legend_names: the names for N experiments
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/10/20 23:24:12 
% Revision: 0.1 

precision_size  = size(precision_data);
recall_size = size(reacall_data);
legend_len = length(legend_names);

% Check the Precision data and Recall data
if (precision_size(2) ~= legend_len) || (recall_size(2) ~= legend_len)
    disp('%d, %d', legend_len, precision_size)
    msg = 'Error: the columns of Precision data and Recall data is not equal to the length of legends!';
    error(msg)
end

% Plot curve based on precision_list and reacall_list
for i = 1:legend_len
    precision_y = precision_data(:,i);
    recall_x = reacall_data(:,i);
    plot(recall_x, precision_y,'LineWidth',2);
    hold on

end

% Set the format of the chart

% Set the legend
legend_name = legend(legend_names);
legend_name.ItemTokenSize = [30 30];
set(legend_name,'Box','off')

% Set the Position and size of chart
set(gcf,'Position',[100 100 260 220]);
% Set the font format of axis
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 20);

% Set the labels
xlabel('\fontname{Times New Roman}\fontsize{25}Recall');
ylabel('\fontname{Times New Roman}\fontsize{25}Precision');

% Set the scale
X_min=0;
X_max=1;
Y_min=0;
Y_max=1;

% Set maximum and minmum of X and Y
axis([X_min,X_max,Y_min,Y_max]);

% Set axis label 
set(gca,'XTick',(0.2:0.2:X_max));
set(gca,'YTick',(Y_min:0.2:Y_max));
set(gca,'LooseInset',get(gca,'TightInset'))
box off;