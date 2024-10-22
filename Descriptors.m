classdef Descriptors < handle
    % DESCRIPTORS Summary of this class goes here
    % Detailed explanation goes here

    % Author: Xiaoguang Liang, University of Surrey
    % Date: 2024/10/22 11:18:03
    % Revision: 0.1

    properties
        DATASET_FOLDER = global_setting.filePathInfo.DATASET_FOLDER;
        OUT_SUBFOLDER=global_setting.filePathInfo.DESCRIPTOR_FOLDER,
        allfiles=global_setting.filePathInfo.allfiles,
        allFeatures=Struct()
    end

    methods
        function obj = Descriptors(Q)
            arguments
                Q=4
            end
            %DESCRIPTORS Construct an instance of this class
            %   Detailed explanation goes here
            for filenum=1:length(obj.allfiles)
                fname=obj.allfiles(filenum).name;
                fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
                tic;
                imgfname_full=([obj.DATASET_FOLDER,'/Images/',fname]);
                img=double(imread(imgfname_full))./255;

                % Extract feature
                F=extractRandom(img, Q);

                % Save feature data
                fout=[OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
                save(fout,'F');
                toc
            end
        end

        function save_feature_data(obj,inputArg)
            %save_feature_data Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

