% Concept:
% f(x,y) * h(x,y) = H(u,v)F(u,v) , '*' mean convolution !
% 'imfilter(A,H)' means use 'H' filter to do convolution on 'A' 


clear;
load('HW1_brain.mat');
%% spatial domain 
% Use Sobel filter
h = [-1 0 1;-2 0 2;-1 0 1];
spatial_result = imfilter(double(HW1_brain),h,0,'conv');
figure;
imshow(abs(spatial_result),[]);title('Spatial Domain (sobel)');colorbar
%% frequency domain
[Nx,Ny] = size(HW1_brain);
F = fftshift(fft2(fftshift(HW1_brain),Nx,Ny));
H = fftshift(fft2(fftshift(h),Nx,Ny));  % padding to size of image 
fd = H .* F;
img_fd = ifftshift(ifft2(ifftshift(fd),Nx,Ny));
figure;
imshow(abs(H),[]);title('sobel by x gradient');
figure;
imshow(abs(img_fd),[]);title('Freq Domain (sobel)');colorbar

