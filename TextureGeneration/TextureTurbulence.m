function [ tex ] = TextureTurbulence(sx, sy)
%TEXTUREMARBLE Summary of this function goes here
%   Detailed explanation goes here
texcloud = TextureCloud(sx, sy) * 255;

s = 100;
tex = zeros(s, s);
for i = 1 : s
    for j = 1 : s
        tex(i, j) = i * 5.0 / s + j * 10.0 / s + 5.0 * texcloud(i, j) / 255.0;
        tex(i, j) = 255 * abs(sin(5 * tex(i, j)));
    end
end

tex = imresize(tex, ceil(max(sx / s, sy / s))) / 255;
tex = tex(1:sx, 1:sy);

end

