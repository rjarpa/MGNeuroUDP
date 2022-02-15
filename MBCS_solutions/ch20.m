%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 2

n = 10000;
srate = 1000;
f = 10;
fwhm = 5;

hz = linspace(0,srate,n);

% create Gaussian
s  = fwhm*(2*pi-1)/(4*pi); % normalized width
x  = hz-f;                 % shifted frequencies
fx = exp(-.5*(x/s).^2);    % gaussian

clf,
subplot(211)
plot(hz,fx)
set(gca,'xlim',[0 40])
xlabel('Frequency (Hz)')

subplot(212)
plot(fftshift(real(ifft(fx))))
set(gca,'xlim',[n/3 2*n/3])
xlabel('Time (a.u.)')

%% 7

b = 3;
m = 0;
srate = 100;
x = -10:1/srate:10;

z = (x-m)/b;
gumbel = exp( -(z+exp(-z)) );

clf
plot(x,gumbel,'linew',2 )



bs = linspace(.1,9,100);
hz = linspace(0,srate,length(x));

for bi=1:length(bs)
    z = (x-m)/bs(bi);
    gumbel = exp( -(z+exp(-z)) );
    pows(bi,:) = abs(fft(detrend(gumbel))/length(x)).^2;
end

contourf(hz,bs,pows,40,'linecolor','none')
set(gca,'xlim',[0 1])
xlabel('Frequency (Hz)'), ylabel('\beta parameter for Gumbel')

%% 8

n = 11;

% Identify the positive and negative frequencies.
posfreq = 2:floor(n/2)+mod(2,1)+1;
negfreq = floor(n/2)+mod(2,1)+2:n;
%   1     2     2     2     2     1     0     0     0     0

% Double the Fourier coefficients from the positive frequencies
d = randn(n,1);
dx = fft(d);
dx(posfreq) = 2*dx(posfreq);

% and zero-out the Fourier coefficients from the negative frequencies.
dx(negfreq) = 0;

% Then take the inverse Fourier transform.
dd = ifft(dx);

clf
plot(1:n,real(dd),'ko-','markersize',40,'markerface','g','linew',3), hold on
plot(1:n,real(hilbert(d)),'rs--','markersize',20,'markerface','k','linew',2)

%% 9

% create real-valued 10 Hz wavelet
srate = 1000;
t = -3:1/srate:3;
wl = cos(2*pi*10*t) .* exp( -t.^2 / .02 );

tz     = .15; % transition zone, in percent
fbnd   = [ 8 12 ]; % freq boundaries
fshape = [ 0 0 1 1 0 0 ];
frex   = [ 0 fbnd(1)*(1-tz) fbnd fbnd(2)*(1+tz) srate/2 ];
frex   = frex./(srate/2); % norm. to Nyquist

orders = round( linspace( (1*1000/fbnd(1)) / (srate/1000), ...
                   (15*1000/fbnd(1)) / (srate/1000) ,30) );

fkern = cell(size(orders));
fkernX = zeros(length(orders),1000);
hz = linspace(0,srate,1000);

figure(2), clf
for oi=1:length(orders)

    % create filter kernel
    fkern{oi} = firls(orders(oi),frex,fshape);
    n(oi) = length(fkern{oi});

    % take its FFT
    apow  = abs(fft(fkern{oi},1000)/n(oi)).^2;
    fkernX(oi,:) = apow./max(apow);

    % filter wavelet and compute FWHM
    filtsig = abs(hilbert( filtfilt(fkern{oi},1,wl) ));
    filtsig = filtsig./max(filtsig);
    [~,idx] = max(filtsig);
    fwhm(oi) = (idx-1+dsearchn(filtsig(idx:end)',.5)) - dsearchn(filtsig(1:idx)',.5);

    % show in plot
    subplot(211), hold on
    plot((1:n(oi))-n(oi)/2,fkern{oi}+.002*oi)
end
xlabel('Time (ms)')

subplot(212)
contourf(hz,(orders/1000)*fbnd(1),10*log10(fkernX),70,'linecolor','none')
set(gca,'xlim',[0 20])
xlabel('Frequency (Hz)'), ylabel('Filter order (n. cycles at 8 Hz)')

figure(1), clf
plot((orders/1000)*fbnd(1),fwhm,'linew',2)

%% 10

srate  = 1000;
t      = 0:1/srate:10-1/srate;
hz     = linspace(0,srate,length(t));

tz     = .15; % transition zone, in percent
fbnd   = [ 8 12 ]; % freq boundaries
fshape = [ 0 0 1 1 0 0 ];
frex   = [ 0 fbnd(1)*(1-tz) fbnd fbnd(2)*(1+tz) srate/2 ];
frex   = frex./(srate/2); % norm. to Nyquist

order = round( 5*1000/fbnd(1) );


% create filter kernel
fkern = firls(order,frex,fshape);

for fi=1:100

    s = sin(2*pi*fi*t);
    p = abs(fft( filtfilt(fkern,1,s) )/length(t) )*2;
    powr(fi) = p(dsearchn(hz',fi));
end

clf,
plot(1:100,powr,'linew',2)
hold on, plot(hz,abs(fft(fkern,length(t))/length(fkern)).*650,'r')
set(gca,'xlim',[0 100])

%%
