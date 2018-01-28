function [ mask ] = GenerateMask(label, index, color, texture, scale)
%GenerateMask Summary of this function goes here
%   Detailed explanation goes here
% color : size 1 x 3, range [0 ~ 255], uint8
% label : size X x Y, range [0 ~ N],   uint8
% texture : [X x Y], [0 ~ 1]],         double
[sx, sy] = size(label);
temp = zeros(sx, sy);
temp(label == index) = 1;

texture1 = (1.0 - texture) .* color(index, 1) + texture * scale;
texture2 = (1.0 - texture) .* color(index, 2) + texture * scale;
texture3 = (1.0 - texture) .* color(index, 3) + texture * scale;

mask = zeros(sx, sy, 3);
mask(:, :, 1) = temp .* texture1;
mask(:, :, 2) = temp .* texture2;
mask(:, :, 3) = temp .* texture3;

end

