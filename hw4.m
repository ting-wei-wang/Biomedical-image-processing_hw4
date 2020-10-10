img = (HW1_brain);
imshow((img),[]);colorbar;
%%  (a)--------------------real....------------------------------------------------------------------------------------------------
F = fft2(img);
S = abs(F);

Fsh = fftshift(F);
subplot(1,3,1);
imshow(abs(Fsh),[]);title('magnitude part');
subplot(1,3,2);
imshow(real(Fsh),[]);title('real part');
subplot(1,3,3);
imshow(imag(Fsh),[]);title('imag part');

c = ifftshift(Fsh);
f = ifft2(c);
figure;
subplot(1,2,1);
imshow(f,[0,255]);colorbar;title('after fft');
subplot(1,2,2);
imshow(uint8(img));colorbar;title('orginal');
%% (b)-----------------------******--------------------------------------------------------------------------------------------
g = zeros(224);
for i_1 = 56:167 % keep central nonzero 
    for j_1 = 56:167
        g(i_1,j_1) = Fsh(i_1,j_1);
    end
end
imshow(abs(g),[]);
cp = ifftshift(g);
fk = ifft2(cp);
subplot(1,2,1);
imshow(abs(fk),[0,255]);colorbar;title('outer spectrum = 0');
subplot(1,2,2);
imshow((img),[0,255]);colorbar;title('orginal');

%% (c)--------------------------------------------------------------------------------------------------------------------
[m,n] = size(img);
low = zeros(m,n);
cx = m/2;
cy = n/2;
d0 = 40;% 40
for i = 1:m
    for j = 1:n
        dist = sqrt((i-cx)^2 + (j-cy)^2);
        low(i,j) = exp(-(dist^2)/(2*(d0^2)));
    end
end
filter = Fsh .*low;
b = ifftshift(filter);
f2 = ifft2(b);
imshow(abs(f2),[0,255]);title('D0 = 40');colorbar;
%% (d)--------------------------------------------------------------------------------------------------------------------
high = 1-low;
filter2 = Fsh .*high;
b2 = ifftshift(filter2);
f3 = ifft2(b2);
imshow(abs(f3),[0,255]);title('D0 = 40');colorbar;
%% (e)--------------------------------------------------------------------------------------------------------------------------
l=size(HW1_brain,1);
pad_signal=zeros(2*l,2*l);
pad_signal(1:l,1:l)=img;
%m=size(mask,1);
mask_f=zeros(2*l,2*l);
mask_f(l-1,l-1)=-1;
mask_f(l,l-1)=-2;
mask_f(l+1,l-1)=-1;

mask_f(l-1,l+1)=1;
mask_f(l,l+1)=2;
mask_f(l+1,l+1)=1;


H = fft2(pad_signal);
X = fft2(mask_f);
Y = H .* X;
y = ifft2(Y);
Fp = fftshift(Y);
imshow(abs(Fp),[]);
%yCropped = y(225:448, 225:448);
%imshow(yCropped,[0,255]);
%%
[M, N] = size(img);

h = [-1 0 1;
    -2 0 2;
    -1 0 1];

P = M + size(h,1) - 1;
Q = N + size(h,2) - 1;

xPadded = img;
xPadded(P, Q) = 0;

hPadded = h;
hPadded(P,Q) = 0;

hShifted = circshift(hPadded, [-1 -1]);

H = fft2(hShifted);
X = fft2(xPadded);

Y = H .* X;
y = ifft2(Y);
Fs = fftshift(Y);
imshow(abs(Fs),[]);
yCropped = y(1:M, 1:N);
imshow(yCropped,[0,255]);