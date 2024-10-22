classdef global_setting < handle
    %GLOBAL_SETTING Summary of this class goes here
    %   Detailed explanation goes here

    properties(Constant=true)
        filePathInfo = global_setting
    end
    properties
        DATASET_FOLDER
        allfiles
        DESCRIPTOR_FOLDER
        DESCRIPTOR_SUBFOLDER
    end

    methods
        function obj = global_setting()
            %GLOBAL_SETTING Construct an instance of this class
            %   Detailed explanation goes here
            obj.DATASET_FOLDER = 'data/MSRC_ObjCategImageDatabase_v2';
            obj.allfiles = dir (fullfile([obj.DATASET_FOLDER,'/Images/*.bmp']));
            obj.DESCRIPTOR_FOLDER = 'data/descriptors';
            obj.DESCRIPTOR_SUBFOLDER=[obj.DESCRIPTOR_FOLDER,'/globalRGBhisto'];
        end

    end
end

