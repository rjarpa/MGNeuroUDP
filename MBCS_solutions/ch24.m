%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 4

% use data from previous chapter
load ../ch23/times_090425blk10_ch115.mat


% subtract mean
spikes = bsxfun(@minus,spikes,mean(spikes,2));

% PCA
spikecov = spikes'*spikes / (size(spikes,1)-1);
[eigvects,eigvals] = eig(spikecov);
pcas = spikes*eigvects(:,end-1:end);
PCclustidx = kmeans(pcas,2);


% ICA
weights = jader(spikes',rank(spikecov));
icas = ( weights(1:2,:)*spikes' )';
ICclustidx = kmeans(icas,2);

% overlap
thesame = ICclustidx==PCclustidx;

% swap labels if necessary
if mean(thesame)<.5, ICclustidx=3-ICclustidx; end
thesame = ICclustidx==PCclustidx;

% plot
clf
plot(pcas(PCclustidx==1 & thesame,1),pcas(PCclustidx==1 & thesame,2),'bo','markersize',2)
hold on
plot(pcas(PCclustidx==2 & thesame,1),pcas(PCclustidx==2 & thesame,2),'ro','markersize',2)
clf
plot(pcas(PCclustidx==1 & thesame,1),pcas(PCclustidx==1 & thesame,2),'bo','markersize',2)
hold on
plot(pcas(PCclustidx==2 & thesame,1),pcas(PCclustidx==2 & thesame,2),'ro','markersize',2)
plot(pcas(~thesame,1),pcas(~thesame,2),'ks','markersize',4,'markerface','k')
legend({'cluster 1';'cluster 2';'disagreement'})
set(gca,'xlim',[-150 150],'ylim',[-320 0])

%% 5

spikeIsi = diff(cluster_class(PCclustidx==1,2));
clf
histogram(spikeIsi,100)

for i=1:20
    isicount(i) = sum(spikeIsi>i-1 & spikeIsi<i);
end

plot(1:20,isicount,'s-','linew',3,'markersize',10)
xlabel('ISI (ms'), ylabel('Count')
% need to look up the unit of cluster_class!

%% 7

load ../ch23/times_090425blk10_ch115.mat
% load ../ch23/times_090425blk10_ch111.mat

spikesClus1 = find(cluster_class(:,1)==1);
spikesClus2 = find(cluster_class(:,1)==2);

[spikesM3,spikesP3] = deal([]);

for si=1:length(spikesClus1)
    tempspikes = round(cluster_class(spikesClus2,2)-cluster_class(spikesClus1(si),2));

    spikesM3 = cat(1,spikesM3,find(tempspikes==-3));
    spikesP3 = cat(1,spikesP3,find(tempspikes==+3));
end % end spike loop

clf
subplot(121)
plot(mean(spikes(spikesClus2(spikesM3),:),1),'b','linew',2), hold on
plot(mean(spikes(spikesClus2(spikesP3),:),1),'r','linew',2)
legend({'-3 ms';'+3 ms'})
title('Delayed')

subplot(122)
randunits1 = randperm(numel(spikesClus2));
randunits2 = randperm(numel(spikesClus2));

plot(mean(spikes(spikesClus2(randunits1(1:length(spikesM3))),:),1),'b','linew',2), hold on
plot(mean(spikes(spikesClus2(randunits2(1:length(spikesM3))),:),1),'r','linew',2)
title('Random')

%%
