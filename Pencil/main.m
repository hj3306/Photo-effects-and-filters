addpath('../Common');

figure(1);
img = imread('Lenna.png');
subplot(1,3,1);title('source image');imshow(img);

img2 = Pencil(img);
imwrite(img2, 'pencil.png');
subplot(1,3,2);title('pencil');imshow(img2);

img3 = ColorPencil(img, 6, 255);
imwrite(img3, 'colorPencil.png');
subplot(1,3,3);title('crayon');imshow(img3);