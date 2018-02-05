
img = imread('../images/Lenna.png');
img = img(:, :, 1);

[sx, sy] = size(img);

B1 = [1,1;1,1];
B2 = [0,1,0; 1,1,1; 0,1,0];
B3 = [0,1,1,0; 1,1,1,1; 1,1,1,1; 0,1,1,0];

imgedge01 = BuildEdge(edge(img, 'Canny', 0.1), B3, 2, 255);
imgedge02 = BuildEdge(edge(img, 'Canny', 0.2), B3, 1, 220);
imgedge03 = BuildEdge(edge(img, 'Canny', 0.3), B2, 2, 200);
imgedge04 = BuildEdge(edge(img, 'Canny', 0.4), B2, 2, 150);
imgedge05 = BuildEdge(edge(img, 'Canny', 0.5), B1, 1, 80);
imgedge06 = BuildEdge(edge(img, 'Canny', 0.6), B1, 0, 40);


figure(1);
subplot(3, 3, 1); imshow(imgedge01);
subplot(3, 3, 2); imshow(imgedge02);
subplot(3, 3, 3); imshow(imgedge03);
subplot(3, 3, 4); imshow(imgedge04);
subplot(3, 3, 5); imshow(imgedge05);
subplot(3, 3, 6); imshow(imgedge06);



for i = 1 : sx
    for j = 1 : sy
        if imgedge02(i, j) < 255
            imgedge01(i, j) = imgedge02(i, j);
        end
    end
end

for i = 1 : sx
    for j = 1 : sy
        if imgedge03(i, j) < 255
            imgedge01(i, j) = imgedge03(i, j);
        end
    end
end

for i = 1 : sx
    for j = 1 : sy
        if imgedge04(i, j) < 255
            imgedge01(i, j) = imgedge04(i, j);
        end
    end
end

for i = 1 : sx
    for j = 1 : sy
        if imgedge05(i, j) < 255
            imgedge01(i, j) = imgedge05(i, j);
        end
    end
end

for i = 1 : sx
    for j = 1 : sy
        if imgedge06(i, j) < 255
            imgedge01(i, j) = imgedge06(i, j);
        end
    end
end

figure(2);
subplot(1, 3, 1);imshow(imgedge01);

imgbw = imbinarize(uint8(img * 0.8));
subplot(1, 3, 2);imshow(uint8(imgbw * 255));