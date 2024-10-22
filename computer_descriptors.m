function computer_descriptors(Q)
arguments
    % Set the default value for Q
    Q=4
end
% COMPUTER_DESCRIPTORS Summary of this function goes here
%
% [OUTPUTARGS] = COMPUTER_DESCRIPTORS(INPUTARGS) Explain usage here
%
% Examples:
%
% Provide sample usage code here
%
% See also: List related files here

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/10/22 10:06:56
% Revision: 0.1

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = global_setting.filePathInfo.DATASET_FOLDER;

%% and within that folder, create another folder to hold these descriptors
%% the idea is all your descriptors are in individual folders - within
%% the folder specified as 'OUT_FOLDER'.
OUT_SUBFOLDER=global_setting.filePathInfo.DESCRIPTOR_FOLDER;

allfiles=global_setting.allfiles;
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    
    % Extract feature
    F=extractRandom(img, Q);
    
    % Save feature data
    fout=[OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    save(fout,'F');
    toc
end

end
