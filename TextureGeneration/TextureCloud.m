function [tex] = TextureCloud(sx, sy)

%% Texture: cloud

tex = zeros(sx, sy);
s = 16;
count = 0;
while count < 16 && (s < sx && s < sy)
    init = rand(s, s);

    G = fspecial('gaussian', [10 10], 1); 
    init = imfilter(init, G, 'same');

    init = imresize(init, ceil(max(sx / s, sy / s)), 'bicubic');
    init = init(1:sx, 1:sy);

    tex = tex + double(init);
    s = s * 2;
    count = count + 1;
end
if count > 0
    tex = tex / count;
end