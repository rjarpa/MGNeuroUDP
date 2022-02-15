%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 1


srate = 1000;
sigtime = 0:1/srate:2;
signal1 = zeros(size(sigtime));
signal1(dsearchn(sigtime',.6):dsearchn(sigtime',1.4)) = 1;

wavtime = -2:1/srate:2;
frex = 6.5;
s = 5/(2*pi*frex);
csine = exp(2*1i*pi*frex*wavtime);
gaus = exp( -(wavtime.^2) / (2*s^2) );
cmw = csine .* gaus;

nData = length(sigtime);
nKern = length(wavtime);
nConv = nData+nKern-1;
nHfkn = floor(length(wavtime)/2)+1;

as = ifft( fft(cmw,nConv) .* fft(signal1,nConv) );
as = as(nHfkn:end-nHfkn+1);


nFrex = 50;
frex  = linspace(1,srate/10,nFrex);
s     = linspace(4,12,nFrex) ./ (2*pi.*frex);
sigX  = fft(signal1,nConv);
tf    = zeros(nFrex,length(signal1));

for fi=1:nFrex

    % create Morlet wavelet
    cmw = exp(  2*1i*pi*frex(fi)*wavtime - (wavtime.^2)/(2*s(fi)^2) );

    % compute its FFT
    cmwX = fft(cmw,nConv);
    cmwX = cmwX./max(cmwX);

    % 'meat' of convolution
    as = ifft( sigX .* cmwX );
    tf(fi,:) = abs( as(nHfkn:end-nHfkn+1) )*2;
end

figure(8), clf

subplot(211)
plot(sigtime,signal1)
set(gca,'ylim',[-.05 1.05])

subplot(212)
contourf(sigtime,frex,tf,40,'linecolor','none')
set(gca,'clim',[0 .1])

%% 4

srate = 1000;
sigtime = 0:1/srate:2;
signal1 = sin(2*pi*30*sigtime);

wavtime = -2:1/srate:2;

% baseline time window
basetime = [.8 1.2];

nData = length(sigtime);
nKern = length(wavtime);
nConv = nData+nKern-1;
nHfkn = floor(length(wavtime)/2)+1;

nFrex = 50;
frex  = linspace(1,srate/10,nFrex);
s     = linspace(4,12,nFrex) ./ (2*pi.*frex);
sigX  = fft(signal1,nConv);
tf    = zeros(nFrex,length(signal1));

for fi=1:nFrex

    % create Morlet wavelet
    cmw = exp(  2*1i*pi*frex(fi)*wavtime - (wavtime.^2)/(2*s(fi)^2) );

    % compute its FFT
    cmwX = fft(cmw,nConv);
    cmwX = cmwX./max(cmwX);

    % 'meat' of convolution
    as = ifft( sigX .* cmwX );

    tp = abs( as(nHfkn:end-nHfkn+1) )*2;
    tf(fi,:) = 10*log10( tp/mean(tp(dsearchn(sigtime',basetime(1)):dsearchn(sigtime',basetime(2)))) );
end

figure(8), clf

subplot(211)
plot(sigtime,signal1)
set(gca,'ylim',[-1.05 1.05])

subplot(212)
contourf(sigtime,frex,tf,40,'linecolor','none')
% set(gca,'clim',[0 1])

%% 7



%% 9

% triangle-ish frequency modulation
srate = 1000;
sigtime = 0:1/srate:8;
freqTS = abs(mod(sigtime,2)-1)*10;
meanF = mean(freqTS);
k = 2*pi/srate;
signal1 = sin(2*pi.*meanF.*sigtime + k*cumsum(freqTS-meanF));


wavtime = -2:1/srate:2;

nData = length(sigtime);
nKern = length(wavtime);
nConv = nData+nKern-1;
nHfkn = floor(length(wavtime)/2)+1;

nFrex = 60;
frex  = linspace(1,14,nFrex);
s     = linspace(4,12,nFrex) ./ (2*pi.*frex);
sigX  = fft(signal1,nConv);
tf    = zeros(nFrex,length(signal1));

for fi=1:nFrex

    % create Morlet wavelet
    cmw = exp(  2*1i*pi*frex(fi)*wavtime - (wavtime.^2)/(2*s(fi)^2) );

    % compute its FFT
    cmwX = fft(cmw,nConv);
    cmwX = cmwX./max(cmwX);

    % 'meat' of convolution
    as = ifft( sigX .* cmwX );

    tf(fi,:) = abs( as(nHfkn:end-nHfkn+1) )*2;
end

clf

subplot(211)
plot(sigtime,signal1)
set(gca,'ylim',[-1.05 1.05])

subplot(212)
contourf(sigtime,frex,tf,40,'linecolor','none')

%% 11

srate = 1000;
t = 0:1/srate:10;
n = length(t);

% create chirp and frequency-stationary signal
f  = [2 10];
ff = linspace(f(1),mean(f),n);
signal1 = cos(2*pi.*ff.*t);
signal2 = chirp(t,f(1),t(end),f(2));


clf
plot(t,signal1,t,signal2)

%%

% chirp frequency modulation
srate = 1000;
sigtime = 0:1/srate:8;
signal1 = chirp(sigtime,3,sigtime(end),16);


wavtime = -2:1/srate:2;

nData = length(sigtime);
nKern = length(wavtime);
nConv = nData+nKern-1;
nHfkn = floor(length(wavtime)/2)+1;

nFrex = 60;
frex  = linspace(1,40,nFrex);
s     = linspace(5,70,nFrex) ./ (2*pi.*frex);
sigX  = fft(signal1,nConv);
tf    = zeros(nFrex,length(signal1));

for fi=1:nFrex

    % create Morlet wavelet
    cmw = exp(  2*1i*pi*frex(fi)*wavtime - (wavtime.^2)/(2*s(fi)^2) );

    % compute its FFT
    cmwX = fft(cmw,nConv);
    cmwX = cmwX./max(cmwX);

    % 'meat' of convolution
    as = ifft( sigX .* cmwX );

    tf(fi,:) = abs( as(nHfkn:end-nHfkn+1) )*2;
end

clf

subplot(211)
contourf(sigtime,frex,tf,40,'linecolor','none')

subplot(212)
plot(frex,mean(tf,2),'linewi',3)
hold on

hz=linspace(0,srate,length(sigtime));
plot(hz,2*abs(fft(signal1)/length(signal1)),'r','linew',3)
set(gca,'xlim',[0 100])
legend({'wt';'fft'})

%%
