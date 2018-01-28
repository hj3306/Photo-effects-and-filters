function [ tex ] = Load_texture(str, sx, sy, scale)
%LOAD_TEXTURE Summary of this function goes here
%   Detailed explanation goes here
    tex = imread(str);
    tex = tex(:, :, 1);
    tex = imresize(tex, scale, 'bicubic');
    [tx, ty] = size(tex);
    nx = uint32(sx / tx);
    ny = uint32(sy / ty);
    img = zeros(sx, sy);
    tex0 = tex;
    for i = 1 : nx
        tex = [tex tex0];
    end
    tex0 = tex;
    for i = 1 : ny
        tex = [tex; tex0];
    end
    tex = tex(1 : sx, 1 : sy);
    tex = imnoise(tex, 'gaussian');
end
 

