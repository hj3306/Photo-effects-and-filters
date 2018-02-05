function [ brush ] = BrushWaterColor(radius, color, background)
%GENERATEBRUSH 
% step1 : draw a circle;
% step2 : add noise to edges
% step3 : blur & dilation
% step4 : combine with cloud texture
% step5 : set color
% !I'm sure there are easier ways to do this


s = radius * 3;
brush = zeros(s, s);
seed01 = floor(rand() * 4);
seed02 = rand() / 4.0;
% center of the brush
cx = floor(s / 2);
cy = cx;

for i = 1 : s
    for j = 1 : s
        dis = sqrt((i - cx)^2 + (j - cy)^2);
        if dis < radius
            delta = abs(dis - radius);
            r = rand();
            if seed01 == 0
                if i > cx
                    r = r * (0.78 + seed02);
                end
            elseif seed01 == 1
                if i <= cx
                    r = r * (0.78 + seed02);
                end
            elseif seed01 == 2
                if j > cy
                    r = r * (0.78 + seed02);
                end
            elseif seed01 == 3
                if j <= cy
                    r = r * (0.78 + seed02);
                end
            end
            if r + delta / radius > 1.2
                brush(i, j) = 1;
            end
        end
    end
end
brush = medfilt2(brush);
B = [0,1,1,1,0;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;0,1,1,1,0];
brush = imdilate(brush, B);
brush = imdilate(brush, B);

tex01 = TextureCloud(s, s);

brush_01 = brush;
G = fspecial('gaussian', [20 20], 8); 
brush_01 = imfilter(brush_01, G, 'same');
G = fspecial('gaussian', [10 10], 8); 
brush_01 = imfilter(brush_01, G, 'same');
G = fspecial('gaussian', [6 6], 8); 
brush_01 = imfilter(brush_01, G, 'same');
G = fspecial('gaussian', [4 4], 8); 
brush_01 = imfilter(brush_01, G, 'same');
brush_01 = imfilter(brush_01, G, 'same');


brush_02 = brush_01 .* tex01;
for i = 1 : s
    for j = 1 : s
        dis = sqrt((i - cx)^2 + (j - cy)^2);
        d = dis / radius;
        if d < 0.8
            brush_02(i, j) = (1 - d + rand() / 10) .* brush_02(i, j);
        end
    end
end

brush_02 = imresize(brush_02, 1.5);
brush_02 = brush_02(floor((1.5*s - s)/2):floor((1.5*s - s)/2)+s-1, floor((1.5*s - s)/2):floor((1.5*s - s)/2)+s-1);
brush_03 = brush_02 + brush_01 * 0.6;

brush_04 = double(edge(brush_03, 'Canny', 0.5));
brush_04 = imdilate(brush_04, B);
brush_05 = imfilter(brush_04, G, 'same');
brush_05 = brush_05 * 0.02 + brush_03 + brush_04 * 0.05;
brush_05 = imfilter(brush_05, G, 'same');

brush = brush_05;

if background > 0
    background = 1;
    color = 1 - color;
else
    background = 0;
end
textureR = brush .* color(1,1);
textureG = brush .* color(1,2);
textureB = brush .* color(1,3);
brush = zeros(radius*3, radius*3, 3);
brush(:, :, 1) = textureR;
brush(:, :, 2) = textureG;
brush(:, :, 3) = textureB;
brush = abs(background - brush);
end

