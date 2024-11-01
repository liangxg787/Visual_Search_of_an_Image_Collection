classdef Descriptors < handle
    % DESCRIPTORS Summary of this class goes here
    % Detailed explanation goes here

    % Author: Xiaoguang Liang, University of Surrey
    % Date: 2024/10/22 11:18:03
    % Revision: 0.1

    properties
        DATASET_FOLDER
        OUT_FOLDER
        OUT_SUBFOLDER
        allfiles
        allFeatures
        % Q, the level of quantization of the RGB space e.g. 4
        Q
        save_one_file
    end

    methods
        function obj = Descriptors(Q, save_one_file)
            arguments
                Q=4
                % If save_one_file is 1, save all the
                % feature data into one file, otherwise save the feature
                % data by the file names
                save_one_file=1
            end
            %DESCRIPTORS Construct an instance of this class
            %   Detailed explanation goes here
            obj.DATASET_FOLDER = global_setting.filePathInfo.DATASET_FOLDER;
            obj.OUT_FOLDER = global_setting.filePathInfo.DESCRIPTOR_FOLDER;
            obj.OUT_SUBFOLDER=global_setting.filePathInfo.DESCRIPTOR_FOLDER;
            obj.allfiles=global_setting.filePathInfo.allfiles;
            obj.allFeatures=struct('name', {}, 'path', {}, 'data', {});
            obj.Q=Q;
            obj.save_one_file=save_one_file;
        end

        function compute_descriptors(obj)
            %compute_descriptors Summary of this method goes here
            %   Detailed explanation goes here
            allFilesLen = length(allFiles);
            for filenum=1:allFilesLen
                fname=allFiles(filenum).name;
                % fprintf('Processing file %d/%d - %s\n',filenum,allFilesLen,fname);
                % Get the image's class number
                className = split(fname, "_");
                className = className{1};
                % tic;
                imgfname_full=([obj.DATASET_FOLDER,'/Images/',fname]);
                img=double(imread(imgfname_full))./255;

                % Extract feature
                F=computeRGBHistogram(img, Q);

                % Save feature data
                if obj.save_one_file == 1
                    % Store all the feature data into the struct allFeatures
                    AllFeatures(end+1).name = fname;
                    AllFeatures(end).class = className;
                    AllFeatures(end).path = imgfname_full;
                    AllFeatures(end).imgData = img;
                    AllFeatures(end).feature = F;

                    % Save all the feature data at the end of for loop
                    if filenum == allFilesLen
                        % all_features=allFeatures;
                        fout=[obj.OUT_FOLDER,'/AllFeatures.mat'];
                        save(fout,'AllFeatures');
                    end
                else
                    % Save feature data
                    fout=[obj.OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
                    save(fout,'F');
                end
                % toc
            end

        end
    end
end

