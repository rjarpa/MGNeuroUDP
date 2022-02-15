%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 1

ns = round(linspace(10,200,60));
cs = linspace(.1,.9,40);
nreps = 100;

corrmat = zeros(length(ns),length(cs),nreps,2);

for ni=1:length(ns)
    for ci=1:length(cs)

        for ti=1:nreps

            % create data
            x = randn(ns(ni),2);
            x(:,2) = x(:,1)*cs(ci) + x(:,2)*sqrt(1-cs(ci)^2);

            % correlation
            x = bsxfun(@minus,x,mean(x,1));
            x = bsxfun(@rdivide,x,std(x,[],1));
            tmp = x'*x / (ns(ni)-1);
            corrmat(ni,ci,ti,1) = tmp(1,2);

            corrmat(ni,ci,ti,2) = (tmp(1,2)-cs(ci))^2;
        end
    end
end

%

clf
subplot(211)
contourf(cs,ns,squeeze(mean(corrmat(:,:,:,1),3)),40,'linecolor','none')
set(gca,'clim',[0 1])

subplot(212)
contourf(cs,ns,(squeeze(mean(corrmat(:,:,:,2),3))),80,'linecolor','none')
set(gca,'clim',[0 .025])
xlabel('Correlation strength'), ylabel('N')

%% 2

v = [1 .5 0; .5 1 -.3; 0 -.3 1];
d = randn(1000,3)*chol(v);

corr(d)

%% 6

x = randn(1,10)';
y = randn(1,10)';
corr(x,y)

%% 9


load ../sampleEEGdata

% covariance of average
data = squeeze(mean(EEG.data,3));
data = bsxfun(@minus,data,mean(data,2));
covAve = data*data'/(EEG.pnts-1);

% covariance of single-trials
covTrl = zeros(EEG.nbchan);
for ti=1:EEG.trials
    data = squeeze(EEG.data(:,:,ti));
    data = bsxfun(@minus,data,mean(data,2));
    covTrl = covTrl + data*data'/(EEG.pnts-1);
end

covTrl = covTrl./EEG.trials;

clf
subplot(121)
imagesc(covAve), set(gca,'clim',[-10 10]), colorbar
title('Covariance of average')

subplot(122)
imagesc(covTrl), set(gca,'clim',[-120 120]), colorbar
title('Average of single-trial covariances')

%%
