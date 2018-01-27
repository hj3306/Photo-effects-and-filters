function [ sI, initcolors ] = kmeansGrey(I, K, L, seed)
%KMEANSGREY Grey image segmentation using k-means cluster.
% I : source image
% K : cluster number
% L : maximum loop time
% seed : a seed ranging[1, 1000] used to 'prevent' pseudo randomization
 
[sx, sy] = size(I);
% randomly choose K cluster centers
rc = zeros(1, K);
 
for i = 1 : K
    % this is something I made up for no good reason
    rc(1, i) = uint8(mod(uint32(((seed(1, i) + 255) * (1 + rand())^(double(mod(seed(1, i), 10))))), 255));
end
initcolors = rc';
 
labels = zeros(sx, sy); 
savedsumcolor = uint32(zeros(K, 2));
 
for iter = 1 : L
    % assign each pixel to a cluster and sum up the pixel colors of each cluster
    for i = 1 : sx
        for j = 1 : sy
            c = I(i, j);
            dists = abs(uint8(initcolors) - c);
            t = find(dists == min(dists));
            labels(i, j) = t(1, 1);
            savedsumcolor(t(1, 1), 1) = savedsumcolor(t(1, 1), 1) + uint32(c);
            savedsumcolor(t(1, 1), 2) = savedsumcolor(t(1, 1), 2) + 1;
        end
    end
    % update cluster center
    tempcolors = initcolors;
    for i = 1 : K
        if savedsumcolor(i, 2) == 0
            initcolors(i, 1) = 0;
        else
            initcolors(i, 1) = savedsumcolor(i, 1) / savedsumcolor(i, 2);
        end
    end
    % if there is no change in color, quit iteration
    if norm(double(tempcolors - initcolors)) < 5
        break;
    end
end
% update final image
sI = I;
for i = 1 : sx
    for j = 1 : sy
        sI(i, j) = initcolors(uint32(labels(i, j)));
    end
end
sI = uint8(sI);
end
