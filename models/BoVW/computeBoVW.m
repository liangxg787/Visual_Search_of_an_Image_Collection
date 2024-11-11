function [outputArgs] = computeBoVW(inputArgs)
% COMPUTEBOVW Summary of this function goes here
% 
% [OUTPUTARGS] = COMPUTEBOVW(INPUTARGS) Explain usage here
% 
% Examples: 
% 
% Provide sample usage code here
% 
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey 
% Date: 2024/11/11 19:33:57 
% Revision: 0.1 



fprintf('Running KMeans over %d points (of dimension %d)\n',size(alldata,2),DIMENSION);
startingcentres=rand(NCLUSTERS,DIMENSION);
centres=Kmeans(startingcentres,alldata',zeros(1,14));

end
