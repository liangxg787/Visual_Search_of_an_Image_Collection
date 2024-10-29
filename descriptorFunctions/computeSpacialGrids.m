function AllgridDescriptors = computeSpacialGrids(img,gridPixelSize,featureType, Q)
arguments
    img  % The input image.
    gridPixelSize % The size of each grid cell in pixels, e.g 3*3, 4*4, etc.
    featureType % The type of features to compute ('colour', 'texture', or 'both').
    Q % The quantization level for feature bins or RGB bins.
end
% COMPUTESPACIALGRIDS Computes descriptors for grid cells based on the specified feature type.
%
% AllgridDescriptors = COMPUTESPACIALGRIDS(IMG, GRIDPIXELSIZE, FEATURETYPE, Q) computes descriptors
% for each grid cell of an image based on the specified feature type (colour, texture, or both),
% and returns a matrix containing the descriptors for all grid cells.
%
% Examples:
%   computeSpacialGrids(img, 64, 'colour', 8);
%   computeSpacialGrids(img, 32, 'texture', 4);
%   computeSpacialGrids(img, 16, 'both', 16);
%
% See also: computeRGBHistogram, computeEdgeOrientationHistogram

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/10/28 21:11:17
% Revision: 0.1

% Get the number of rows and columns of the image
rowPixelNum  = size(img, 1);
colPixelNum  = size(img, 2);

% Calculate the number of grid cells in rows and columns
gridRowPixel = ceil(rowPixelNum/gridPixelSize);
gridColPixel = ceil(colPixelNum/gridPixelSize);

% Calculate the new dimensions of the image after gridding
newRow=gridRowPixel*gridPixelSize;
newCol=gridColPixel*gridPixelSize;

% Initialize the matrix to store descriptors for all grid cells
AllgridDescriptors=[];

% Set the step size for grid cell traversal
stepPixel=gridPixelSize;

% Traverse each grid cell
for i=1:stepPixel:newRow-stepPixel+1
    for j=1:stepPixel:newCol-stepPixel+1
        % Ensure the grid cell does not exceed the image boundaries
        if i+stepPixel > rowPixelNum
            i = rowPixelNum-stepPixel;
        end
        if j+stepPixel > colPixelNum
            j = colPixelNum-stepPixel;
        end

        % Extract the current grid cell image
        gridImg=img(i:i+stepPixel,j:j+stepPixel, :);

        % Compute descriptors for the grid cell based on the specified feature type
        switch featureType
            case "colour"
                gridDescriptors=computeRGBHistogram(gridImg,Q);
            case "texture"
                gridDescriptors=computeEdgeOrientationHistogram(gridImg,Q);
            case "both"
                RGBDescriptors=computeRGBHistogram(gridImg,Q);
                EOHDescriptors=computeEdgeOrientationHistogram(gridImg,Q);
                gridDescriptors=[EOHDescriptors RGBDescriptors];
        end

        % Store the computed grid cell descriptors
        AllgridDescriptors=[AllgridDescriptors gridDescriptors];
    end
end

end