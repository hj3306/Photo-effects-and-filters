img = imread('Lenna.png');
subplot(1,2,1);title('source image');imshow(img);

img2 = Pencil(img, 0.7);
subplot(1,2,2);title('pencil');imshow(img2);
