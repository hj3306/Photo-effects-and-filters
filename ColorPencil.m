function [ img ] = ColorPencil( img )
%CRAYON Summary of this function goes here
%   Detailed explanation goes here

    [sx, sy, sz] = size(img);
    
    % image edge
    imgedge = double(edge(img(:,:,1), 'Canny') * 5);
 
    % load textures
    sketch01 = double(Load_texture('sketch01.png', sx, sy, 0.08)) / 255.0;
    sketch02 = double(Load_texture('sketch02.png', sx, sy, 0.08)) / 255.0;
    sketch03 = double(Load_texture('sketch03.png', sx, sy, 0.08)) / 255.0;
    sketch04 = double(Load_texture('sketch04.png', sx, sy, 0.08)) / 255.0;
    sketch05 = double(Load_texture('sketch05.png', sx, sy, 0.08)) / 255.0;
    sketch06 = double(Load_texture('sketch06.png', sx, sy, 0.08)) / 255.0;
    
    % image segmentation using kmeans
    [imgseg, labels, centers] = KmeansColor(img, 6, 50, 283);
    
    subimg01 = GenerateMask(labels, 1, centers, sketch01);
    subimg02 = GenerateMask(labels, 2, centers, sketch02);
    subimg03 = GenerateMask(labels, 3, centers, sketch03);
    subimg04 = GenerateMask(labels, 4, centers, sketch04);
    subimg05 = GenerateMask(labels, 5, centers, sketch05);
    subimg06 = GenerateMask(labels, 6, centers, sketch06);
    
    
    img = uint8(subimg01 + subimg02 + subimg03 + subimg04 + subimg05 + subimg06 + imgedge);

end