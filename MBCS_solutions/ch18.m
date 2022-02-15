%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 5

srate = 1000;
t = 0:1/srate:5;
n = length(t);

x = (linspace(0,1,n)>.5)+0; % +0 converts from boolean to number

% uncommenting this line shows that nonstationarities
% do not prevent stationary signals from being easily observed
x = x + .2*sin(2*pi*6*t);
hz = linspace(0,srate/2,floor(n/2)+1);

% plot
figure(14), clf
subplot(211)
plot(t,x)
set(gca,'ylim',[-.4 1.4])
xlabel('Time (s.)'), ylabel('Amplitude (a.u.)')

subplot(212)
xX = fft(x)/n;
plot(hz,2*abs(xX(1:length(hz))))
set(gca,'xlim',[0 20],'ylim',[0 .4])
xlabel('Frequency (Hz)'), ylabel('Amplitude (a.u.)')

%% 6

load mouseHippocampus.mat

fAll = mean( abs(fft(data)/length(timevec)).^2 ,2);
fAve = abs(fft(mean(data,2))/length(timevec)).^2;

hz = linspace(0,srate/2,floor(length(timevec)/2)+1);

clf
plot(hz,fAll(1:length(hz)),hz,fAve(1:length(hz)),'linew',2)
legend({'all trials';'trial average'})
set(gca,'xlim',[0 50])
xlabel('Frequency (Hz)'), ylabel('Power')

%% 7

data = randn(120,100);
dataHann = bsxfun(@times,data,.5*(1-cos(2*pi*(1:100)/(100-1))));
dataGaus = bsxfun(@times,data,exp(-((-49:50).^2)/700));
dataHamm = bsxfun(@times,data,hamming(100)');

clf
plot(sum( (dataHann-data).^2 ,1),'linew',2)
hold on
plot(sum( (dataGaus-data).^2 ,1),'linew',2)
plot(sum( (dataHamm-data).^2 ,1),'linew',2)


xlabel('Time (a.u.)'), ylabel('SSE')
legend({'Hann';'Gauss';'Hamming'})

%% 9

load EEGrestingState

hz = linspace(0,srate/2,floor(length(eegdata)/2)+1);
n = length(eegdata);

fNot = abs(fft(eegdata)/n).^2;
fHan = abs(fft(eegdata .* (.5*(1-cos(2*pi*(1:n)/(n-1)))) )/n).^2;


clf
subplot(211)
plot(eegdata), hold on
plot(eegdata .* (.5*(1-cos(2*pi*(1:n)/(n-1)))) )

subplot(212)
plot(hz,fNot(1:length(hz)),hz,fHan(1:length(hz)),'linew',2)
set(gca,'xlim',[0 60])
xlabel('Frequency (Hz)'), ylabel('Power')
legend({'original';'tapered'})

%% 10

epochs = reshape(eegdata,2048,[]);

fNot = mean( abs(fft(epochs)/2048).^2 ,2);
fHan = mean( abs(fft(bsxfun(@times,epochs,.5*(1-cos(2*pi*(1:2048)/(2048-1)))') )/2048).^2 ,2);

hz = linspace(0,srate/2,floor(2048/2)+1);


clf
plot(hz,fNot(1:length(hz)),hz,fHan(1:length(hz)),'linew',2)
plot(hz,fHan(1:length(hz)),'linew',2)
set(gca,'xlim',[0 60])
% legend({'orig';'hann'})

%% 11


fepoch = mean( abs(fft(epochs,n)/2048).^2 ,2);
fConti = abs(fft(eegdata)/n).^2;
hz = linspace(0,srate/2,floor(length(eegdata)/2)+1);


clf
plot(hz,fepoch(1:length(hz)),'linew',2), hold on
plot(hz,fConti(1:length(hz)),'linew',2)

fNot = mean( abs(fft(epochs)/2048).^2 ,2);
hz = linspace(0,srate/2,floor(2048/2)+1);

plot(hz,fNot(1:length(hz)),'linew',2)
legend({'epoched large N','continuous','epoched small N'})
set(gca,'xlim',[0 60])

%%







%% 15

nPnts   = 1000;
nTrials = 40;
dataX   = fft( 10*randn(nPnts,nTrials) );
modfunc = linspace(-1,1,nPnts).^2;
data    = real(ifft( bsxfun(@times,dataX,modfunc') ));

% add sine waves
data = bsxfun(@plus,data,sin(2*pi*5*linspace(0,1,nPnts))');
data = bsxfun(@plus,data,sin(2*pi*60*linspace(0,1,nPnts))');

f1 = mean(abs(fft(data)/nPnts).^2,2);
f2 = mean(abs(fft(diff(data))/nPnts).^2,2);

hz = linspace(0,500,floor(nPnts/2)+1);

clf
plot(hz,f1(1:length(hz)),'linew',2), hold on
plot(hz,f2(1:length(hz)),'linew',2)

set(gca,'xlim',[0 80])
xlabel('Frequency (Hz)')


%%

% an alternative method to create 1/f data
npnts = 10000;
ps    = bsxfun(@times, exp(1i*2*pi*rand(1,floor(npnts/2))) , .1+exp(-(1:floor(npnts/2))/200) );
ps    = [ps 0 ps(:,end:-1:1)];
data  = real(ifft(ps,[],2));


%% 18

srate = 1000;
time = 0:1/srate:1-1/srate;
sig = sin(2*pi*13*time);

hz = linspace(0,srate/2,floor(length(time)/2));
f = 2*abs(fft(sig)/length(time));

clf
plot(hz,f(1:length(hz)),'ko-','linew',2)
set(gca,'xlim',[10 16])

%%
