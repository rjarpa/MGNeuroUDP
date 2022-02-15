%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 13

saturn = double( imread('saturn.png') )./255;
saturn = squeeze(saturn(:,:,1));

sx = fft2(saturn);
mags = abs(sx);
phas = angle(sx);

recon = real(ifft2( mags.*exp(1i*phas) ));

clf,
subplot(121), imagesc(saturn), axis off, axis image, title('Original')
subplot(122), imagesc(recon), axis off, axis image, title('Reconstructed')

%% 14

recon = real(ifft2( mags.*exp(1i* (rand(size(phas))*2*pi-pi) )));

clf,
subplot(121), imagesc(saturn), axis off, axis image, title('Original')
subplot(122), imagesc(recon), axis off, axis image, title('Phase-scrambled')

%% 15

recon = real(ifft2( mags.*exp(1i* mod(phas+pi/3 ,2*pi) )));

clf,
subplot(121), imagesc(saturn), axis off, axis image, set(gca,'clim',[0 .9]), title('Original')
subplot(122), imagesc(recon), axis off, axis image, set(gca,'clim',[0 .9]), title('Phase offset')

%% 16

nPix2use = 3;
% get sizes of image and midpoints
imgdims = size(saturn);
midX = round(imgdims(2)/2);
midY = round(imgdims(1)/2);
filtbox = zeros(imgdims(1:2));
filtbox(midY-nPix2use:midY+nPix2use,midX-nPix2use:midX+nPix2use) = 1;
filtbox = logical(fftshift(filtbox));

replacephase = rand(size(phas))*2*pi-pi;
replacephase(filtbox) = phas(filtbox);

recon = real(ifft2( mags.*exp(1i*replacephase) ));

clf,
subplot(131), imagesc(saturn), axis off, axis image, title('Original')
subplot(132), imagesc(recon), axis off, axis image,


replacephase = rand(size(phas))*2*pi-pi;
replacephase(~filtbox) = phas(~filtbox);
recon = real(ifft2( mags.*exp(1i*replacephase) ));
subplot(133), imagesc(recon), axis off, axis image

%%
