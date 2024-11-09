function dst = manhattanDistance(F1, F2)
% MANHATTANDISTANCE Summary of this function goes here
% 
% [OUTPUTARGS] = MANHATTANDISTANCE(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/11/09 16:35:01 
% Revision: 0.1 

% Subtract each element of feature F1 from feature F2
x=F1-F2;
% Get the absolute values of these differences
x=abs(x);
% Sum up the absolute differences
dst=sum(x);


end
