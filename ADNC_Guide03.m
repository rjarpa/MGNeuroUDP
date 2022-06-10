%% 1 

TMinutes=15
T=TMinutes*60

Fs=1000
delta_t=1/Fs

N=Fs*T





% a

ST=0:delta_t:T;
ST=ST(1:length(ST)-1)';
largo=length(ST);
SD=randn(1,N)';



% b, c, d


ind_start=largo*0.2

STEvents=([ind_start ind_start+(Fs*60) ind_start+(Fs*60*2) ind_start+(Fs*60*3)])'
STSeg1=[ST(STEvents(1):STEvents(1)+(Fs*1.5)) SD(STEvents(1):STEvents(1)+(Fs*1.5))]
STSeg1_1=[STSeg1(:,1)-STSeg1(1,1) STSeg1(:,2)]

STEvents=([ind_start ind_start+(Fs*60) ind_start+(Fs*60*2) ind_start+(Fs*60*3)])'
STSeg2=[ST(STEvents(2):STEvents(2)+(Fs*1.5)) SD(STEvents(2):STEvents(2)+(Fs*1.5))]
STSeg2_1=[STSeg2(:,1)-STSeg2(1,1) STSeg2(:,2)]

STEvents=([ind_start ind_start+(Fs*60) ind_start+(Fs*60*2) ind_start+(Fs*60*3)])'
STSeg3=[ST(STEvents(2):STEvents(2)+(Fs*1.5)) SD(STEvents(2):STEvents(2)+(Fs*1.5))]
STSeg3_1=[STSeg3(:,1)-STSeg3(1,1) STSeg3(:,2)]

STEvents=([ind_start ind_start+(Fs*60) ind_start+(Fs*60*2) ind_start+(Fs*60*3)])'
STSeg4=[ST(STEvents(2):STEvents(2)+(Fs*1.5)) SD(STEvents(2):STEvents(2)+(Fs*1.5))]
STSeg4_1=[STSeg4(:,1)-STSeg4(1,1) STSeg4(:,2)]

% c 


figure;
hold on
subplot(4,1,1)
plot(STSeg1_1(:,1),STSeg1_1(:,2))
plot(STSeg2_1(:,1),STSeg2_1(:,2))
plot(STSeg3_1(:,1),STSeg3_1(:,2))
plot(STSeg4_1(:,1),STSeg4_1(:,2))




% e

a=transpose(STSeg1_1(:,2))
b=transpose(STSeg2_1(:,2))
c=transpose(STSeg3_1(:,2))
d=transpose(STSeg4_1(:,2))

STTemp=[a 
        b
        c
        d]
% f
STmedia=mean(STTemp)

% g
STsd=std(STTemp)


% h

figure;
hold on
plot(STSeg1_1(:,1),STmedia,'_k')
plot(STSeg1_1(:,1),STSeg1_1(:,2),'xr')
plot(STSeg1_1(:,1),STSeg2_1(:,2),'xb')
plot(STSeg1_1(:,1),STSeg3_1(:,2),'xg')
plot(STSeg1_1(:,1),STSeg4_1(:,2),'xy')

% i


figure;
hold on
plot(STSeg1_1(:,1),STmedia,'k')
plot(STSeg1_1(:,1),STmedia+STsd,'_r')
plot(STSeg1_1(:,1),STmedia-STsd,'_b')


%% 2

clear all;
load('Example_LFP_Data.mat')


% a

T_p2=length(lfp_raw)/1000
delta_t_p2=1/Fs
ST_p2=0:delta_t_p2:T_p2;
ST_p2=ST_p2(1:length(ST_p2)-1)
ST_p2=ST_p2-(ST_p2(1))
ST_p2=(ST_p2)'



% b 

tiempo_graficar=0.7;
tiempo_graficar_ms=tiempo_graficar*1000;
start_serie=454;
end_serie=start_serie+(tiempo_graficar*Fs); % revisar porque con otra frecuencia no funciona

ind=[start_serie end_serie];

figure;
hold on;
plot(ST_p2(ind(1):ind(2)),lfp_raw(ind(1):ind(2)));

epocas = start_serie


% e 
ST_p2_500=downsample(ST_p2,2)  % ? ocupar Fs
ST_p2_100=downsample(ST_p2,10) % ?

lfp_raw_p2_500=downsample(lfp_raw,2)  % ? ocupar Fs
lfp_raw_p2_100=downsample(lfp_raw,10) % ?

Fs_500=500
Fs_100=100





%  f
tiempo_graficar_e=3.0;
start_serie_e=1;
end_serie_e=start_serie_e+(tiempo_graficar_e*Fs_500); % revisar porque con otra frecuencia no funciona
ind_e_500=[start_serie_e end_serie_e];
end_serie_e=start_serie_e+(tiempo_graficar_e*Fs_100); % revisar porque con otra frecuencia no funciona
ind_e_100=[start_serie_e end_serie_e];
end_serie_o=start_serie_e+(tiempo_graficar_e*Fs); % revisar porque con otra frecuencia no funciona
ind_e_1000=[start_serie_e end_serie_o];



figure;

% hold on
subplot(3,1,1)
plot(ST_p2(ind_e_1000(1):ind_e_1000(2)),lfp_raw(ind_e_1000(1):ind_e_1000(2)));
subplot(3,1,2)
plot(ST_p2_100(ind_e_100(1):ind_e_100(2)),lfp_raw_p2_100(ind_e_100(1):ind_e_100(2)));
subplot(3,1,3)
plot(ST_p2_500(ind_e_500(1):ind_e_500(2)),lfp_raw_p2_500(ind_e_500(1):ind_e_500(2)));


% g 


pos77=events(77)
pos78=events(78)
pos79=events(79)


ind_e_77=[pos77-100  pos77+250-1]
ind_e_78=[pos78-100  pos78+250-1]
ind_e_79=[pos79-100  pos79+250-1]



t=0:350-1
t=t/1000
t=t-0.1


figure;

hold on;
plot(t,lfp_raw(ind_e_77(1):ind_e_77(2)));
plot(t,lfp_raw(ind_e_78(1):ind_e_78(2)));
plot(t,lfp_raw(ind_e_79(1):ind_e_79(2)));

%h

ba_s=[0.2 0.2]
ba_samples=ba_s*Fs
%epoch=[];
M=nan(ba_samples(1)+ba_samples(2)+1,numel(events));
for i=1:numel(events)

    epoch=lfp_raw(events(i)-ba_samples(1):events(i)+ba_samples(2));
    M(:,i)=epoch;
end
% i

ti=0:ba_samples(1)+ba_samples(2);
ti=ti-ba_samples(1);
ti=ti/Fs;
epochs_list=1:length(M);
figure;
imagesc(ti,epochs_list,M')
%figure;
%pcolor(M'); shading flat



% j 

M_mean=mean(M');

%t_j=0:400
%t_j=(t_j)/Fs

ba_s_j=[0.05 0.25] % tiempo antes y despues en segundo
ba_samples_j=ba_s_j*Fs % convertir a muestras


M=nan(ba_samples_j(1)+ba_samples_j(2)+1,100); % prealocar la matriz numero eventos por muestras
for i=1:100

    epoch=lfp_raw(events(i)-ba_samples_j(1):events(i)+ba_samples_j(2));
    M(:,i)=epoch;
end
% i
M_mean=mean(M');
t_j=0:300
t_j=(t_j)/Fs

%t_j=0:300-1
%t_j=t/1000
t_j=t_j-0.05
%id_j=[ ]

figure;
plot(t_j,M_mean)

plot()