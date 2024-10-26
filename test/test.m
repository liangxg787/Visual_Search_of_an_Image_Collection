%% Author: Xiaoguang Liang (PG/T - Comp Sci & Elec Eng)
%% University of Surrey, United Kingdom
%% Email address: xl01339@surrey.ac.uk
%% Time: 22/10/2024 17:42

clc;
close all;
clear;



% Save the figure as a PNG file with specified margins
% print(fig, 'my_chart_with_margins.png', '-dpng', '-r300');  % '-r300' sets 300 DPI for high resolution

bar(1:5)
title("My Bar Chart")
ax = gca;
exportgraphics(ax,"100pixelpadding.png","Padding",100)