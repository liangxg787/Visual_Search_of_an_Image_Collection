function AllgridDescriptors = computeSpacialGrid(img,featureType,grids, Q)
arguments
    img  % The input image.
    featureType % The type of features to compute ('colour', 'texture', or 'both').
    grids % The number of grids for row and column respectively, e.g 3*3, 4*4, etc.
    Q % The quantization level for feature bins or RGB bins.
end
% COMPUTESPACIALGRID Computes descriptors for grid cells based on the specified feature type.
%
% AllgridDescriptors = COMPUTESPACIALGRID(IMG, GRIDPIXELSIZE, FEATURETYPE, Q) computes descriptors
% for each grid cell of an image based on the specified feature type (colour, texture, or both),
% and returns a matrix containing the descriptors for all grid cells.
%
% Examples:
%   computeSpacialGrid(img, 64, 'colour', 8);
%   computeSpacialGrid(img, 32, 'texture', 4);
%   computeSpacialGrid(img, 16, 'both', 16);
%
% See also: computeRGBHistogram, computeEdgeOrientationHistogram

% Author: Xiaoguang Liang, University of Surrey
% Date: 2024/10/28 21:11:17
% Revision: 0.1

% Get the number of rows and columns of the image
rowPixelNum  = size(img, 1);
colPixelNum  = size(img, 2);

% Calculate the number of pixels for every grid cell in rows and columns
gridRowPixel = ceil(rowPixelNum/grids);
gridColPixel = ceil(colPixelNum/grids);

% Calculate the new dimensions of the image after gridding
newRow=gridRowPixel*grids;
newCol=gridColPixel*grids;

% Initialize the matrix to store descriptors for all grid cells
AllgridDescriptors=[];

% Traverse each grid cell
for i=1:gridRowPixel:newRow-gridRowPixel
    for j=1:gridColPixel:newCol-gridColPixel
        % Ensure the grid cell does not exceed the image boundaries
        if i+gridRowPixel > rowPixelNum
            i = rowPixelNum-gridRowPixel;
        end
        if j+gridColPixel > colPixelNum
            j = colPixelNum-gridColPixel;
        end

        % Extract the current grid cell image
        gridImg=img(i:i+gridRowPixel,j:j+gridColPixel, :);

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