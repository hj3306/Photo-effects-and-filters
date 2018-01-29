
tex01 = TextureCloud(500, 500);
tex02 = TextureTurbulence(500, 500);
imwrite(tex01, 'cloud.png');
imwrite(tex02, 'turbulence.png');
subplot(1,2,1);imshow(tex01);
subplot(1,2,2);imshow(tex02);