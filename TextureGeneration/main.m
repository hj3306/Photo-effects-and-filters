
tex01 = TextureCloud(500, 500);
tex02 = TextureTurbulence(500, 500);

bru01 = BrushWatercolor(150, [0, 0.5, 1.0], 1.0);

imwrite(tex01, 'cloud.png');
imwrite(tex02, 'turbulence.png');
imwrite(bru01, 'watercolor_blue.png');

subplot(1,3,1);imshow(tex01);
subplot(1,3,2);imshow(tex02);
subplot(1,3,3);imshow(bru01);