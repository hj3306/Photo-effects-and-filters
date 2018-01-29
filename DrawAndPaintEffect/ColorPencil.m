function [ img ] = ColorPencil(img, N, scale)
%CRAYON Summary of this function goes here
%   N: number of colors, don't be too large, it'll take too long

    [sx, sy, sz] = size(img);
    if N > 50
        N = 50;
    end
    % image edge
    imgedge = double(edge(img(:,:,1), 'Canny') * 5);
 
    % load textures
    sketch01 = double(Load_texture('sketch01.png', sx, sy, 0.08, 1)) / 255.0;
    sketch02 = double(Load_texture('sketch02.png', sx, sy, 0.08, 1)) / 255.0;
    sketch03 = double(Load_texture('sketch03.png', sx, sy, 0.08, 1)) / 255.0;
    sketch04 = double(Load_texture('sketch04.png', sx, sy, 0.08, 1)) / 255.0;
    sketch05 = double(Load_texture('sketch05.png', sx, sy, 0.08, 1)) / 255.0;
    sketch06 = double(Load_texture('sketch06.png', sx, sy, 0.08, 1)) / 255.0;
    
    % image segmentation using kmeans
    [imgseg, labels, centers] = KmeansColor(img, N, 50, 283);
    
    sumimg = zeros(sx, sy, sz);
    gimg = rgb2gray(uint8(reshape(centers, 1, N, 3)));
    for i = 1 : N
        subimg = [];
        if gimg(1, i) > 210
            subimg = GenerateMask(labels, i, centers, sketch01, scale);
        elseif gimg(1, i) > 180
            subimg = GenerateMask(labels, i, centers, sketch02, scale);
        elseif gimg(1, i) > 140
            subimg = GenerateMask(labels, i, centers, sketch03, scale);
        elseif gimg(1, i) > 100
            subimg = GenerateMask(labels, i, centers, sketch04, scale);
        elseif gimg(1, i) > 50
            subimg = GenerateMask(labels, i, centers, sketch05, scale);
        else
            subimg = GenerateMask(labels, i, centers, sketch06, scale);
        end
        sumimg = sumimg + subimg;
    end
    
%     subimg01 = GenerateMask(labels, 1, centers, sketch01);
%     subimg02 = GenerateMask(labels, 2, centers, sketch02);
%     subimg03 = GenerateMask(labels, 3, centers, sketch03);
%     subimg04 = GenerateMask(labels, 4, centers, sketch04);
%     subimg05 = GenerateMask(labels, 5, centers, sketch05);
%     subimg06 = GenerateMask(labels, 6, centers, sketch06);
%     
%     
%     img = uint8(subimg01 + subimg02 + subimg03 + subimg04 + subimg05 + subimg06 + imgedge);
    img = uint8(sumimg + imgedge);

end