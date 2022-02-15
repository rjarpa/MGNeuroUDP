%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 6

load ../ch23/spikefieldData


frex = 1:50;
wavetime = -2:1/srate:2;
halfwave = floor(length(wavetime)/2)+1;

nData = length(lfp);
nWave = length(wavetime);
nConv = nData + nWave - 1;

wherespikes = find(spikeTimes);
win = 200; % indices, not ms!
wherespikes(wherespikes<win | wherespikes>length(as)-win) = [];

sfc = zeros(size(frex));

dataX = fft(lfp,nConv);

for fi=1:length(frex)
    % create wavelet
    nCycl = 6;
    gausS = nCycl / (2*pi*frex(fi));

    wavelet  = exp(2*1i*pi*frex(fi)*wavetime + (-wavetime.^2)/(2*gausS^2) );
    waveletX = fft(wavelet,nConv);
    waveletX = waveletX./max(waveletX);

    as = ifft( dataX .* waveletX );

    % cut off edges
    as = as(halfwave-1:end-halfwave);


    spikeLFP = zeros(length(wherespikes),win*2+1);

    for si=1:length(wherespikes)
        spikeLFP(si,:) = real(as(wherespikes(si)-win:wherespikes(si)+win));
    end

    fpow = abs(fft(mean(spikeLFP,1))/size(spikeLFP,2)).^2;
    sfc(fi) = fpow(dsearchn(linspace(0,srate,size(spikeLFP,2))',frex(fi)));

end


clf
plot(frex,sfc,'ks-','linew',2,'markersize',14)
xlabel('Frequency (Hz)'), ylabel('Power')

%% 7

load ../ch23/spikefieldData

frex = 8;


wavetime = -2:1/srate:2;
halfwave = floor(length(wavetime)/2)+1;

nData = length(lfp);
nWave = length(wavetime);
nConv = nData + nWave - 1;

wherespikes = find(spikeTimes);
win = 200; % indices, not ms!
wherespikes(wherespikes<win | wherespikes>length(lfp)-win) = [];

nCycl = 6;
gausS = nCycl / (2*pi*frex);

wavelet  = exp(2*1i*pi*frex*wavetime + (-wavetime.^2)/(2*gausS^2) );
waveletX = fft(wavelet,nConv);
waveletX = waveletX./max(waveletX);

as = ifft( fft(lfp,nConv) .* waveletX );

% cut off edges
as = angle( as(halfwave-1:end-halfwave) );

histogram(as(wherespikes),10)
xlabel('Phase bin (rad.)'), ylabel('Count')

%% 8

sfc = abs(mean(exp(1i*as(wherespikes))));

% permutation testing.
sfcp = zeros(1000,1);
for permi=1:1000
    fakeSpikeLocs = randsample(1:length(as),length(wherespikes));
    sfcp(permi) = abs(mean(exp(1i*as(fakeSpikeLocs))));
end

clf
subplot(211)
histogram(sfcp,50)
hold on
plot([sfc sfc],get(gca,'ylim'),'m:','linew',5)
sfcz = (sfc-mean(sfcp))/std(sfcp);
title([ 'Complete randomization (Z = ' num2str(sfcz) '; p = ' num2str(1-normcdf(sfcz)) ')' ])



% now again using cut-and-shift
for permi=1:1000
    cutloc = randsample(round(.1*length(as)):round(.9*length(as)),1);
    shiftas = [ as(cutloc:end) as(1:cutloc-1) ];
    sfcp(permi) = abs(mean(exp(1i*shiftas(wherespikes))));
end

subplot(212)
histogram(sfcp,50)
hold on
plot([sfc sfc],get(gca,'ylim'),'m:','linew',5)
sfcz = (sfc-mean(sfcp))/std(sfcp);
title([ 'Cut-and-shift (Z = ' num2str(sfcz) '; p = ' num2str(1-normcdf(sfcz)) ')' ])

%%
