function [ tex ] = Load_texture(str, sx, sy, scale, isnoise)
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
    size(tex0)
    for i = 1 : ny + 1
        tex = [tex tex0];
    end
    tex0 = tex;
    for i = 1 : nx + 1
        tex = [tex; tex0];
    end
    tex = tex(1 : sx, 1 : sy);
    if isnoise == 1
        tex = imnoise(tex, 'gaussian');
    end
end
 

