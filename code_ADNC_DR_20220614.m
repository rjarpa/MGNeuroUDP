clear all;
load('Example_EEG_Data2.mat');

numEv=[20 21 30 31];
ch=46;
before_s=0.25;
after_s=0.6;
before_samples=round(before_s*srate);
after_samples=round(after_s*srate);
  %  F=eventtype==numEv(i);
  %  EVs=event_indices(F); 

  % total muestras del periodo de tiempo del sample before_samples+after_samples+1
  % la cantidad de registro del mismo evento numel(EVs)
  % la cantidad de eventos distintos a registrar numel(numEv))

EpochMat=nan(before_samples+after_samples+1, numel(eventtype),numel(numEv));
for i=1:numel(numEv)
    F=eventtype==numEv(i);
    EVs=event_indices(F);   %
    for j=1:numel(EVs)
        EpochMat(:,j,i)=zscore(EEGmat(ch, EVs(j)-before_samples : EVs(j)+after_samples));
    end
end
t=(0:size(EpochMat,1)-1)./srate;
t=t-before_s;
%% RASTER + ERP
figure;

contaplot=1
for i=1:numel(numEv)
subplot(8,1,contaplot)
imagesc(t,1:numel(EVs),EpochMat(:,:,i)')
xlabel('Time relative to event (s)')
ylabel('Epochs (Trials)')
cb=colorbar;
ylabel(cb,'EEG (z-score)')
xlim([-before_s after_s])
title([channames{ch} ', Event ' num2str(numEv)])
contaplot=contaplot+1;
subplot(8,1,contaplot)
hold on
plot(t,EpochMat(:,:,i),'Color',[0.6 0.6 0.6])
plot(t,mean(EpochMat(:,:,i),2), 'LineWidth',3,'color','k')
xlim([-before_s after_s])
xlabel('Time relative to event (s)')
ylabel(['EEG (z-score)'])
end
%% ERPs
figure;
hold on
for j=1:numel(numEv)
    plot(t, nanmean(EpochMat(:,:,j),2), 'LineWidth',3,'color',rand(1,3))
end
xlabel('Time relative to event (s)')
legend('Ev20','Ev21', 'Ev30','Ev31')