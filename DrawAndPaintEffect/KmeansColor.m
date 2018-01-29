function [ sI, labels, colors ] = KmeansColor(I, K, L, seed)
%KMEANSCOLOR RGB image segmentation using k-means cluster.
% I : source image
% K : cluster number
% L : maximum loop time
% seed : a seed ranging[1, 1000] used to 'prevent' pseudo randomization

% change 3D to 2D
[sx, sy, sz] = size(I);
I = double(reshape(I, sx * sy, sz));
% randomly choose K cluster centers
rng(seed);
colors = rand(K, 3) * 255;

labels = zeros(sx * sy, 1);
savedsumcolor = zeros(K, 3);
savedsumcount = zeros(K, 1);
for iter = 1 : L
    % assign each pixel to a cluster and sum up the pixel colors of each cluster
    dists = pdist2(I, colors, 'euclidean');
    [~, labels] = min(dists, [], 2);
    for i = 1 : K
        tI = I(find(labels == i), :);
        sumI = sum(tI);
        if size(sumI, 1) == 0
            savedsumcolor(i, :) = [0, 0, 0];
            savedsumcount(i, 1) = 0;
        else
            savedsumcolor(i, :) = sumI;
            savedsumcount(i, 1) = size(tI, 1);
        end
    end
    % update cluster center
    for i = 1 : K
        if uint8(savedsumcount(i, 1)) == 0
            colors(i, :) = [0 0 0];
        else
            colors(i, :) = savedsumcolor(i, :) / savedsumcount(i, 1);
        end
    end
end
% update final image
sI = I;
for i = 1 : sx * sy
    sI(i, :) = colors(uint32(labels(i, 1)), :);
end
sI = reshape(sI, sx, sy, sz);
sI = uint8(sI);
labels = reshape(labels, sx, sy);
end