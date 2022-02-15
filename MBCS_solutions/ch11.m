%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 1


srate  = 1000;
frex   = [ 3  10 15 30 ];
amplit = [ 5  15  5  7 ];
phases = [  pi/8  pi  pi/2  -pi/4 ];
time   = 0:1/srate:10;

% create sine waves
sine_waves = zeros(length(frex),length(time));

% loop over frequencies and define each sine wave
for fi=1:length(frex)
    sine_waves(fi,:) = amplit(fi) * sin(2*pi*time*frex(fi) + phases(fi));
end

% Add (1) a little bit of noise and (2) a lot of noise to make two time series.
% I defined the noise level relative to the average sine wave amplitude
sinesWithSmallNoise = sum(sine_waves,1) + randn(1,length(time)) * mean(amplit);
sinesWithLargeNoise = sum(sine_waves,1) + randn(1,length(time)) * 20*mean(amplit);

% Plot the individual sine waves and the summed time series in separate figures.

figure(1), clf
for fi=1:length(frex)
    subplot(4,1,fi)
    plot(time,sine_waves(fi,:))
    xlabel('Time (s)'), ylabel('Amplitude')
    title([ 'Sine wave of ' num2str(frex(fi)) ' Hz' ])
end

figure(2), clf
subplot(311)
plot(time,sum(sine_waves,1))
xlabel('Time (s)'), ylabel('Amplitude')
title('Average sine wave, NO NOISE')

subplot(312)
plot(time,sinesWithSmallNoise)
xlabel('Time (s)'), ylabel('Amplitude')
title('Average sine wave, LITTLE NOISE')

subplot(313)
plot(time,sinesWithLargeNoise)
xlabel('Time (s)'), ylabel('Amplitude')
title('Average sine wave, LOTS OF NOISE')


labelz = {'no';'little';'lots of'};
figure(3), clf

for i=1:3

    % get no noise, little noise, or lots of noise
    switch i
        case 1
            thing2plot = sum(sine_waves,1);
        case 2
            thing2plot = sinesWithSmallNoise;
        case 3
            thing2plot = sinesWithLargeNoise;
    end

    % plot time domain signal
    subplot(2,3,i)
    plot(time,thing2plot);
    xlabel('Time (ms)')
    title([ 'Time series with ' labelz{i} ' noise' ])

    subplot(2,3,i+3)
    f = fft(thing2plot)/length(time);
    frequencies = linspace(0,srate/2,floor(length(f)/2));
    bar(frequencies,abs(f(1:floor(length(time)/2))).*2)
    set(gca,'xlim',[0 35],'ylim',[0 max(amplit)])
    title([ 'Power spectrum with ' labelz{i} ' noise' ])
    xlabel('Frequencies (Hz)'), ylabel('amp.')
end

%% 2

power1 = abs( fft(data)/n ).^2;

%% 3

z = 8+41i;


%% 4

x = complex(4,2*1i)
sw = sin(2*10.*(0:.001:1));
linemag = sqrt( real(cdp).^2 + real(cdp.^2) )
hz = linspace(0,nyquist/2,floor(N/2)+1);
x=randn(100,1); xX=fft(x,10);%zero-padding by 10
pic=imread('2Dpicture.png'); picX=fft(pic);

%% 6

ns  = round(linspace(10,10000,20));
tim = zeros(2,length(ns));

for ni=1:length(ns)

    s = randn(1,ns(ni));

    %% slow

    tic;

    % Fourier transform variables
    fourierTime = ((1:ns(ni))-1)/ns(ni);   % "time" vector

    % initialize output matrix of Fourier coefficients
    signalX = zeros(ns(ni),1);

    % loop over frequencies
    for fi=1:ns(ni)
        fourierSine = exp( -1i*2*pi*(fi-1).*fourierTime );
        signalX(fi) = sum( fourierSine.*s );
    end
    signalX = signalX / ns(ni);

    tim(1,ni) = toc;

    %% fast

    tic;

    signalX1 = fft(s)/ns(ni);

    tim(2,ni) = toc;
end

plot(ns,tim,'linew',3)
legend({'slow';'fast'})
xlabel('Signal length (points)'), ylabel('Time (s)')

%% 7

tim = zeros(2,100);

for i=1:100

    sx = fft(randn(1000,1));

    tic; powr=abs(sx).^2;   tim(1,i)=toc;
    tic; powr=sx.*conj(sx); tim(2,i)=toc;
end

clf
bar(mean(tim,2)), hold on
errorbar(mean(tim,2),std(tim,[],2),'o')
ylabel('Computation time (s)')
set(gca,'xlim',[0 3],'xticklabel',{'abs(sx)^2';'sx.*conj(sx)'})

%% 8

srate = 1000;
time = 0:1/srate:3-1/srate;
s = sin(2*pi*6*time);


sx1 = 2*abs( fft(s)/length(time) );
sx2 = 2*abs( fft(s,6*srate)/length(time) );
sx3 = 2*abs( fft(s,6*srate)/(6*srate) );

hz1 = linspace(0,srate/2,floor(length(time)/2)+1);
hz2 = linspace(0,srate/2,floor((6*srate)/2)+1);

clf
subplot(311)
plot(hz1,sx1(1:length(hz1)),'s-','linew',3), set(gca,'xlim',[0 15],'ylim',[0 1])
xlabel('Frequency (Hz)'), ylabel('Amplitude (a.u.)')

subplot(312)
plot(hz2,sx2(1:length(hz2)),'s-','linew',3), set(gca,'xlim',[0 15],'ylim',[0 1])
xlabel('Frequency (Hz)'), ylabel('Amplitude (a.u.)')

subplot(313)
plot(hz2,sx3(1:length(hz2)),'s-','linew',3), set(gca,'xlim',[0 15],'ylim',[0 1])
xlabel('Frequency (Hz)'), ylabel('Amplitude (a.u.)')

%% 9


n=10;
i=-n:.1:n;
d=zeros(length(i));

for ii=1:length(i)
    for jj=1:length(i)
        d(ii,jj) = log( complex(i(ii),i(jj)) );
    end
end

d(~isfinite(d))=min(d(:));

clf
subplot(221), imagesc(abs(d)),  title('magnitude'), axis off, axis square
subplot(222), imagesc(real(d)), title('real'), axis off, axis square
subplot(223), imagesc(imag(d)), title('imag'), axis off, axis square

subplot(224)
surf(abs(d)+real(d)+imag(d)), axis xy, axis square, axis off
shading interp, rotate3d on

%% 10

clf

saturn = imread('saturn.png');

saturnX = fft2(squeeze( saturn(:,:,1) ));
subplot(121), imagesc(real(ifft2(saturnX)))
axis square

saturnX = fft(squeeze( saturn(:,:,1) ));
subplot(122), imagesc(real(ifft2(saturnX)))
axis square

%% 11

% a very simple signal and its fft
signal  = [ 1 0 1 3 -3 1 2 0 -3 0 -1 2 1 -1];
N = length(signal);
signalX = 2*abs( fftshift( fft(signal) / N ));
srate = 100; % in Hz, I'm just making up this number
hz = linspace( -srate/2, srate/2 - srate/N, N );

clf
plot(hz,signalX,'bo-')
xlabel('Frequencies (Hz)')

%% 12

N = 10;
s = randn(N,1);
sx = fft(s)/N;


% Fourier transform variables
fourierTime = ((1:N)-1)/N;   % "time" vector

% initialize output matrix of Fourier coefficients
signalX = zeros(1,N);

% loop over frequencies
for fi=1:N
    signalX = signalX + sx(fi)*exp( 1i*2*pi*(fi-1).*fourierTime );
end

clf
plot(real(signalX),'o-','markersize',15,'linew',3)
hold on
plot(s,'r*-','markersize',15,'linew',3)

%% 13

complex(7,9)
complex(7,9)'


% define signal properties
srate = 200; % sampling rate, sometimes abbreviated Fs
time  = 0:1/srate:5;
frequency = 3;
amplitude = 2;
phase     = pi/3;

% create sine wave
sinewave = amplitude * sin( 2*pi*frequency*time + phase );

clf
sinewaveX = fft(sinewave)/length(time);
hz = linspace(0,srate/2,floor(length(time)/2)+1);

subplot(221)
bar(hz,2*abs(sinewaveX(1:length(hz))))
set(gca,'xlim',[0 frequency*3])

subplot(222)
bar(hz,angle(sinewaveX(1:length(hz))))
set(gca,'xlim',[0 frequency*3])

subplot(223)
bar(hz,2*abs(sinewaveX(1:length(hz))'))
set(gca,'xlim',[0 frequency*3])

subplot(224)
bar(hz,angle(sinewaveX(1:length(hz))'))
set(gca,'xlim',[0 frequency*3])

%% 14

v{1} = [2 1];
v{2} = [-2 3];
v{3} = [0 1];
v{4} = [-2 0];
v{5} = [real(exp(1i*pi/3)) imag(exp(1i*pi/3))];

clf
for i=1:length(v)
    subplot(2,3,i)
    plot([0 v{i}(1)],[0 v{i}(2)],'ks-','linew',4)
    axis([-4 4 -4 4])
    grid on
    title([ 'z = [ ' num2str(v{i}(1)) ' ' num2str(v{i}(2)) 'i ]' ])
    xlabel('Real'), ylabel('Imag')
end

%%
