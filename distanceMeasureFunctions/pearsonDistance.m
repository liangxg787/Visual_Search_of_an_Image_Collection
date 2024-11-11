function dst = pearsonDistance(F1, F2)
% PEARSONCORRELATIONCOEFFICIENT Summary of this function goes here
% 
% [OUTPUTARGS] = PEARSONCORRELATIONCOEFFICIENT(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/11/09 16:58:56 
% Revision: 0.1 

% Calculate Pearson Correlation Coefficient
R = corrcoef(F1, F2);

% Extract Pearson Correlation Coefficient
pearson_correlation = R(1, 2);

% Calculate Pearson Distance
dst = 1 - pearson_correlation;
end
