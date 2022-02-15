%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 3

load ../ch26/tfmat.mat

pvals = linspace(.5,.001,30);

for pii=1:length(pvals)

    thimg = tf;
    thimg(p>pvals(pii))=0;
    c = bwconncomp(logical(thimg));

    dat(pii,1) = c.NumObjects;
    dat(pii,2) = sum( cellfun(@length,c.PixelIdxList) );
end

subplot(211)
plot(pvals,dat(:,1),'o-','linew',2,'markersize',13,'markerface','k')
xlabel('p-value'), ylabel('Number of clusters')

subplot(212)
plot(pvals,dat(:,2),'o-','linew',2,'markersize',13,'markerface','k')
xlabel('p-value'), ylabel('Number of pixels')

%% 4

x = 0:.001:1;
s = sin(2*pi*5*x);

clf
plot(x,s,'k'), hold on

c = bwconncomp(s>.5);
cors = 'ygmbr';
for i=1:c.NumObjects
    plot(x(c.PixelIdxList{i}),s(c.PixelIdxList{i}),'p','markersize',18,'markerfacecolor',cors(1+mod(c.NumObjects,i)))
    %plot(x(c.PixelIdxList{i}),zeros(size(s(c.PixelIdxList{i}))),'p','markersize',18,'markerfacecolor',cors(1+mod(c.NumObjects,i)))
end

%% 9

pic = imread('../ch26/monkey_amygdala.png');
pic1 = double( squeeze(pic(:,:,1)) );
clf, imagesc(pic1), axis ij, colormap gray, axis image


%
pict = pic1;
pict(pict>100)=nan;
pict4bw=pict; pict4bw(~isfinite(pict))=0;
c = bwconncomp(pict4bw);


cdiscr = 64;

% extract slice and normalize image to [0 64]
img2plot = pic1;
img2plot = img2plot - min(img2plot(:));
img2plot = cdiscr * img2plot./max(img2plot(:));


% same for stats map
stat2plot = pict;
stat2plot(stat2plot==0) = NaN;
% this time, normalize image to [64 128] because it will
% be plotted on top of the structural map.
stat2plot = stat2plot - min(stat2plot(:));
stat2plot = cdiscr+cdiscr*.05 + cdiscr*.95 * stat2plot./max(stat2plot(:));

clf
% use pcolor function, which is similar to surf.
% Try replacing pcolor with surf and turning on rotate3d
h(1) = pcolor( img2plot );
hold on
h(2) = pcolor( stat2plot );
axis ij, axis image, axis off

colormap([ gray(cdiscr); hot(cdiscr) ]);
set(h,'linestyle','none')

%% 12

load ../ch15/tfdata

% p-value threshold
pval = .05;
zval = norminv(1-pval);

% initialize extreme-value distribution

nPerms = 1000;
permdiff = zeros(nPerms,size(allpow,1),size(allpow,2));
for permi=1:nPerms
    fakeord = randperm(size(allpow,3));
    permdiff(permi,:,:) = squeeze( mean(allpow(:,:,fakeord(1:100)),3) - mean(allpow(:,:,fakeord(101:200)),3) );
end

permmean = squeeze(mean(permdiff,1));
permstd  = squeeze(std(permdiff,[],1));
clustdist = zeros(nPerms,1);

for permi=1:nPerms
    % threshold
    fakez = (squeeze(permdiff(permi,:,:))-permmean) ./ permstd;
    fakez(abs(fakez)<zval) = 0;
    c = bwconncomp(fakez);

    if c.NumObjects>0
        clustdist(permi) = max(cellfun(@length,c.PixelIdxList));
    end
end

clustthresh = prctile(clustdist,100-100*pval);
realdif = squeeze( mean(allpow(:,:,101:200),3) - mean(allpow(:,:,1:100),3) );
realz = (realdif-permmean) ./ permstd;
realz(abs(realz)<zval) = 0;
%
contourf(timevec,frex,realz,40,'linecolor','none')
set(gca,'clim',[-3 3])
xlabel('Time (ms)'), ylabel('Frequency (Hz')

%%
