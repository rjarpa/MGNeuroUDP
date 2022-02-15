%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 12

load sampleEEGdata.mat

rts = zeros(size(EEG.epoch));

% loop over trials
for ei=1:EEG.trials

    % find the index corresponding to time=0, i.e., trial onset
    [~,zeroloc] = min(abs( cell2mat(EEG.epoch(ei).eventlatency) ));

    % reaction time is the event after the trial onset
    rts(ei) = EEG.epoch(ei).eventlatency{zeroloc+1};
end


%%% define convolution parameters for time-frequency analysis

freqrange  = [2 20]; % extract only these frequencies (in Hz)
numfrex    = 30;     % number of frequencies between lowest and highest


% set up convolution parameters
wavtime = -2:1/EEG.srate:2;
frex    = linspace(freqrange(1),freqrange(2),numfrex);
nData   = EEG.pnts*EEG.trials;
nKern   = length(wavtime);
nConv   = nData + nKern - 1;
halfwav = (length(wavtime)-1)/2;
nCyc    = logspace(log10(4),log10(12),numfrex);

% create wavelets
cmwX = zeros(numfrex,nConv);
for fi=1:numfrex

    % create time-domain wavelet
    s   = nCyc(fi) / (2*pi*frex(fi));
    cmw = exp(2*1i*pi*frex(fi).*wavtime) .* exp( (-wavtime.^2) / (2*s.^2) );

    % compute fourier coefficients of wavelet and normalize
    cmwX(fi,:) = fft(cmw,nConv);
    cmwX(fi,:) = cmwX(fi,:) ./ max(cmwX(fi,:));
end


% initialize time-frequency output matrix
tf = zeros(numfrex,EEG.pnts);
tf3d = zeros(numfrex,EEG.pnts,EEG.trials);

% compute Fourier coefficients of EEG data (doesn't change over frequency!)
eegX = fft( reshape(EEG.data(47,:,:),1,[]) ,nConv);

% loop over frequencies
for fi=1:numfrex

    % second and third steps of convolution
    as = ifft( cmwX(fi,:).*eegX ,nConv );

    % cut wavelet back to size of data
    as = as(halfwav+1:end-halfwav);
    as = reshape(as,EEG.pnts,EEG.trials);

    % extract power from all trials
    tf3d(fi,:,:) = abs(as).^2;

end % end frequency loop

%% now compute correlations

% reshape the 3D matrix to 2D
tf2d = reshape(tf3d,numfrex*EEG.pnts,EEG.trials)';

% create design matrix
A = [ ones(EEG.trials,1) rts' ];

% the 2D matrix can be used in a single least squares equation
x = (A'*A)\A'*tf2d;
covmat = reshape(x(2,:),numfrex,EEG.pnts); % demushing

fakecov = zeros(1000,numfrex,EEG.pnts);
for permi=1:1000
    A = [ ones(EEG.trials,1) rts(randperm(length(rts)))' ];
    x = (A'*A)\A'*tf2d;
    fakecov(permi,:,:) = reshape( x(2,:),numfrex,EEG.pnts ); % demushing
end

zmap = (covmat-squeeze(mean(fakecov))) ./ squeeze(std(fakecov,[],1));

%%
clf
subplot(311)
contourf(EEG.times,frex,covmat,40,'linecolor','none'), set(gca,'clim',[-.02 .02])

subplot(312)
contourf(EEG.times,frex,zmap,40,'linecolor','none'), set(gca,'clim',[-3 3])

subplot(313)
zmapt = zmap;
zmapt(abs(zmap)<1.96) = 0;
contourf(EEG.times,frex,zmapt,40,'linecolor','none'), set(gca,'clim',[-3 3])
xlabel('Time (ms)'), ylabel('Frequency (Hz)')

%% 14

fidx = dsearchn(frex',[14 20]');
tidx = dsearchn(EEG.times',[-600 -200]');

% create design matrix
A = [ ones(EEG.trials,1) squeeze(mean(mean(tf3d(fidx(1):fidx(2),tidx(1):tidx(2),:),1),2)) ];

% the 2D matrix can be used in a single least squares equation
x = (A'*A)\A'*tf2d;
covmat = reshape(x(2,:),numfrex,EEG.pnts); % demushing

clf
contourf(EEG.times,frex,covmat,40,'linecolor','none'), set(gca,'clim',[-3 3])
xlabel('Time (ms)'), ylabel('Frequency (Hz)')


%% 16

cd('../ch25')
filz = dir('*img');

for imgi=1:length(filz)

    % read one volume
    tempdat = readnifti(filz(imgi).name);

    % initialize
    if imgi==1 % initialization only during first image!
        fmridat = zeros([ size(tempdat) length(filz) ]);
    end

    % put volume into larger matrix
    fmridat(:,:,:,imgi) = tempdat;
end

%% experiment design

onsets = (6:12:84)+12;
timeline = zeros(length(filz),1);
for i=0:5
    timeline(onsets+i) = 1;
end

% convolve with hrf
fMRI_T = 16;
p     = [6 16 1 1 6 0 32];
RT    = 3;
dt    = RT/fMRI_T;
u     = [0:(p(7)/dt)] - p(6)/dt;
hrf   = spm_Gpdf(u,p(1)/p(3),dt/p(3)) - spm_Gpdf(u,p(2)/p(4),dt/p(4))/p(5);
hrf   = hrf([0:(p(7)/RT)]*fMRI_T + 1);
hrf   = hrf'/sum(hrf);

% create design matrix
t = conv(timeline,hrf);
A = [ ones(size(fmridat,4),1) zscore(t(1:length(timeline))) ];
n=length(A);

slice2plot = 37;

[zmap,pmap] = deal( zeros(size(tempdat)) );
for xi=1:size(fmridat,1)
    for yi=1:size(fmridat,2)
        for zi=slice2plot%1:size(fmridat,3)
            x = (A'*A)\A'*zscore(squeeze(fmridat(xi,yi,zi,:)));

            t = x(2).*sqrt((n-2)./(1-x(2).^2));
            p = 2*tcdf(-abs(t),n-2);

            zmap(xi,yi,zi) = x(2);
            pmap(xi,yi,zi) = p;
        end
    end
end

zmapt = zmap;
zmapt(pmap>.001) = 0;
% zmapt(abs(zmap)<.4) = 0;

%% threshold 1-voxel results

% slightly better threshold based on contiguously
% significant regions. bwconncomp is in the image
% processing toolbox.
islands = bwconncomp(zmapt);
% % find the number of pixels in each
islandsizes = cellfun(@length,islands.PixelIdxList);

for ii=1:islands.NumObjects
    if islandsizes(ii)<3
        zmapt(islands.PixelIdxList{ii}) = 0;
    end
end

% now plot

figure(4), clf

% Color discritization. 64 is the Matlab standard.
% Try other numbers to see what happens to the plot.
% Try, for example, 5 vs. 500
cdiscr = 64;

% extract slice and normalize image to [0 64]
img2plot = squeeze(fmridat(:,:,slice2plot,1))';
img2plot = img2plot - min(img2plot(:));
img2plot = cdiscr * img2plot./max(img2plot(:));


% same for stats map
stat2plot = squeeze(zmapt(:,:,slice2plot))';
stat2plot(stat2plot==0) = NaN;
% this time, normalize image to [64 128] because it will
% be plotted on top of the structural map.
stat2plot = stat2plot - min(stat2plot(:));
stat2plot = cdiscr+cdiscr*.5 + cdiscr*.5 * stat2plot./max(stat2plot(:));

% uncomment the next line to reproduce the white voxels in the book figure
% stat2plot(stat2plot>1) = max(stat2plot(:));

% use pcolor function, which is similar to surf.
% Try replacing pcolor with surf and turning on rotate3d
h(1) = pcolor( img2plot );
hold on
h(2) = pcolor( stat2plot );
axis xy, axis image, axis off

colormap([ gray(cdiscr); hot(cdiscr) ]);
set(h,'linestyle','none')

%%
