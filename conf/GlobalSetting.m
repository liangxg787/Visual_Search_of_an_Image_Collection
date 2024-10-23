classdef GlobalSetting
    %GLOBAL_SETTING Summary of this class goes here
    %   Detailed explanation goes here

    properties(Constant=true)
        filePathInfo = GlobalSetting
    end
    properties
        DATASET_FOLDER
        allFiles
        DESCRIPTOR_FOLDER
        DESCRIPTOR_SUBFOLDER
        TEST_DATA
    end

    methods
        function obj = GlobalSetting()
            %GLOBAL_SETTING Construct an instance of this class
            %   Detailed explanation goes here
            obj.DATASET_FOLDER = 'data/MSRC_ObjCategImageDatabase_v2';
            obj.allFiles = dir (fullfile([obj.DATASET_FOLDER,'/Images/*.bmp']));
            obj.DESCRIPTOR_FOLDER = 'data/descriptors';
            obj.DESCRIPTOR_SUBFOLDER=[obj.DESCRIPTOR_FOLDER,'/globalRGBhisto'];
            obj.TEST_DATA='data/testData.mat';
        end

    end
end

