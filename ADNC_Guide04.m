% Ejercicio 04 EEG
% Ruben Jarpa
% Jun-2022
clear all;
load('Example_EEG_Data2.mat');


% channames = el listado de electrodos en standard 10 20


% EEGmat las,miuestras del eeg 71 filas  con electrodos  columnas son las muestas 

% 63488 / 

T=length(EEGmat)/srate
delta_t=1/srate
TMinute=T/60

% event_indices = indice de ventos 

figure;

%bar(eventtype)
plot(eventtype)

% eventtype= tipos de eventos 

%srate 512 sample per second (hertz)


t=0:delta_t:T
t=(0:length(EEGmat))/srate
t=t(1:length(t)-1)


figure;
plot(t,EEGmat([20 30 40],:));
figure;

chan2plot=60

plot(t,EEGmat([chan2plot],:));
xlabel("Time (s)")
title("Channel:  " + channames(chan2plot))



eventype1=30;
Meventype1=event_indices(eventtype==eventype1);
eventype2=20;
Meventype2=event_indices(eventtype==eventype2);
%Mlogico=(EEGmat(1,:)==eventype1);   
ind=[-0.150 1.2];
%posa=[-0.150 1.2]*srate;

pos=[-0.150 1.2]./delta_t;
pos=floor(pos);

total_s=sum(abs(ind));
n_samples=round(total_s*srate)
    t=0:n_samples; 
    t=(t)/srate;
    t=t-abs(ind(1));

startMeventype1=Meventype1+pos(1)
finMeventype1=Meventype1+pos(2)
startMeventype2=Meventype2+pos(1)
finMeventype2=Meventype2+pos(2)


%Me1=EEGmat(60,[Meventype1]);
%Me1_2=EEGmat(60,startMeventype1:finMeventype1);

MAA=nan(length(startMeventype1),n_samples+1);
for i=1:length(startMeventype1)
    MAA(i,:)= zscore(EEGmat(60,startMeventype1(i):finMeventype1(i)));
end

MAA2=[]
for i=1:length(startMeventype2)
    MAA2(i,:)= zscore( EEGmat(60,startMeventype2(i):finMeventype2(i)));

end 

figure;
imagesc(t,startMeventype1,MAA); shading flat;


figure;
hold on;
p1=plot(t,MAA,'r')
p2=plot(t,MAA2,'b')

lgd = legend([p1(1) p2(1) ], eventype1,eventype2);


% e

MAA_mean=mean(MAA,'omitnan');
MAA2_mean=mean(MAA2,'omitnan');


figure;
hold on;
p1=plot(t,MAA_mean,'r')
p2=plot(t,MAA2_mean,'b')


% f

MAA_sd=std(MAA,'omitnan');
MAA2_sd=std(MAA2,'omitnan');

%g 

figure;
hold on;
p7=plot(t,MAA2,'Color', [0.5 0.5 0.5]);
p8=plot(t,MAA,'k');

p1=plot(t,MAA_mean,'r');
p2=plot(t,MAA_mean+MAA_sd,'r');
p3=plot(t,MAA_mean-MAA_sd,'r');

p4=plot(t,MAA2_mean,'b');
p5=plot(t,MAA2_mean+MAA2_sd,'b');
p6=plot(t,MAA2_mean-MAA2_sd,'b');




