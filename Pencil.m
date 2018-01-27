function [ img ] = Pencil(img, T)
%PENCIL : combine 7 different textures + edge of image
% Refernece[1] : Automatic Pencil Sketch Generation by using Canny Edges
%           2017 Fifteenth IAPR International Conference on Machine 
%           Vision Applications (MVA) Nagoya University, Nagoya, Japan, May 8-12, 2017
% Refernece[2] : Real-Time Hatching
%           by Emil Praun, Hugues Hoppe, Matthew Webb, Adam Finkelstein
    
    img = img(:, :, 1);
    [sx, sy] = size(img);
    
    % image edge
    imgedge = uint8((1 - edge(img, 'Canny')) * 255);
    
    % binarized image
    imgbw = im2bw(img, T);
 
    % load textures
    sketch00 = 255 + ones(sx, sy);
    sketch01 = Load_texture('sketch01.png', sx, sy, 0.08) * 1.2;
    sketch02 = Load_texture('sketch02.png', sx, sy, 0.08);
    sketch03 = Load_texture('sketch03.png', sx, sy, 0.08);
    sketch04 = Load_texture('sketch04.png', sx, sy, 0.08);
    sketch05 = Load_texture('sketch05.png', sx, sy, 0.08);
    sketch06 = Load_texture('sketch06.png', sx, sy, 0.08);
    
    % image segmentation using kmeans
    seed = [372, 64, 8, 19, 55, 892, 773, 54];
    [imgseg, centers] = kmeansGrey(img, 7, 50, seed);
    
    mask00 = zeros(sx, sy);
    mask00(imgseg == centers(1,1)) = 1;
    subimg00 = uint8(mask00) .* uint8(sketch00);
    
    mask01 = zeros(sx, sy);
    mask01(imgseg == centers(2,1)) = 1;
    subimg01 = uint8(mask01) .* uint8(sketch01);
 
    mask02 = zeros(sx, sy);
    mask02(imgseg == centers(3,1)) = 1;
    subimg02 = uint8(mask02) .* uint8(sketch02);
 
    mask03 = zeros(sx, sy);
    mask03(imgseg == centers(4,1)) = 1;
    subimg03 = uint8(mask03) .* uint8(sketch03);
    
    mask04 = zeros(sx, sy);
    mask04(imgseg == centers(5,1)) = 1;
    subimg04 = uint8(mask04) .* uint8(sketch04);
    
    mask05 = zeros(sx, sy);
    mask05(imgseg == centers(6,1)) = 1;
    subimg05 = uint8(mask05) .* uint8(sketch05);
    
    mask06 = zeros(sx, sy);
    mask06(imgseg == centers(7,1)) = 1;
    subimg06 = uint8(mask06) .* uint8(sketch06);
    
    img = subimg00 + subimg01 + subimg02 + subimg03 + subimg04 + subimg05 + subimg06;
end