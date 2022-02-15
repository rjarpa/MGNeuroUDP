%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 2

n = round(linspace(10,100000,100));
tim = zeros(2,length(n));

for ni=1:length(n)

    % signal
    signal = randn(1,n(ni));

    % kernel (Gaussian)
    x = -round(n(ni)/4):round(n(ni)/4);
    kernel = exp( (-x.^2)/N );

    % sizes
    N = n(ni);
    M = length(kernel);
    halfKern = floor(M/2);


    %% time-domain convolution

    tic;

    % Data that we'll use for convolution (must be zero-padded).
    dat4conv = [ zeros(1,M-1) signal zeros(1,M-1) ];

    % initialize convolution output
    conv_res = zeros(1,N+M-1);

    % run convolution
    for ti=M+1:N-M+1
        tempdata = dat4conv(ti:ti+M-1);

        % compute dot-product (don't forget to flip the kernel backwards!)
        conv_res(ti) = sum( tempdata.*kernel(end:-1:1) );
    end

    % trim the wings
    conv_res = conv_res(halfKern+1:end-halfKern);

    tim(1,ni) = toc;

    %% freq-domain convolution

    tmp = ifft( fft(signal,N+M-1) .* fft(kernel,N+M-1) );
    tmp = tmp(halfKern+1:end-halfKern);

    tim(2,ni) = toc;

end
%
clf
plot(n,tim,'linew',3)
xlabel('Signal length'), ylabel('Time (s)')

%% 3

% import picture
pic = imread('saturn.png');
pic = double(squeeze(pic(:,:,1)));

% create gaussian
[x,y]  = meshgrid(-250:250);
s = 30;
gaus2d = exp( -(x.^2 + y.^2)/(2*s^2) );


% step 1
N     = size(pic);
M     = size(gaus2d);
nConv = N+M-1;
halfK = floor(M/2);

% step 2
picX  = fft2(pic,nConv(1),nConv(2));
gausX = fft2(gaus2d,nConv(1),nConv(2));

% step 3
gausX = gausX ./ max(gausX(:));

% step 4
cr = ifft2( picX.*gausX );

% step 5
cr = cr( halfK(1)+1:end-halfK(1) , halfK(2)+1:end-halfK(2) );


clf
subplot(131)
imagesc(pic)
axis off, axis image

subplot(132)
imagesc(cr)
axis off, axis image

subplot(133)
imagesc(cr-pic)
axis off, axis image
set(gca,'clim',[-50 50])

%% 4

for ti=M:N-M % should be M+1
    tempdata = dat4conv(ti:ti+M-1);
    conv_res(ti) = sum( tempdata.*kernel(end:-1:1) );
end

%% 5

n=9;
floor(n/2)
ceil(n/2)-1
round((n-1)./2)

%%
