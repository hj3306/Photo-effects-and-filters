function [ img ] = BuildEdge(eimg, B, N, color)
%BUILDEDGE Summary of this function goes here
%   Detailed explanation goes here
for i = 1 : N
    eimg = imdilate(eimg, B);
end
eimg = 1 - eimg;

img = uint8(eimg * 255 + color);

end

