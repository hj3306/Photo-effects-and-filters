img = imread('Lenna.png');
% img = img(:, :, 1);
subplot(1,3,1);title('source image');imshow(img);
 
img1 = Pixel(img, 16);
subplot(1,3,2);title('pixel');imshow(img1);
 
img2 = Pencil(img, 0.7);
subplot(1,3,3);title('pencil');imshow(img2);
