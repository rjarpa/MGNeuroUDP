% Trabajo 02
% Ruben Jarpa
% Jul-2022
clear all;
load('sampleEEG1.mat');


%% Desafio 1

% some references 
% https://eeglab.org/tutorials/ConceptsGuide/Data_Structures.html


% data      : datos de EEG
% xmin      : limite inferior de tiempo antes del evento
% xmax      : limite superior de tiempo despues del evento
% nbchan    : numero de canales
% trails    : numero de eventos
% pnts      : numero de muestras por epoca
% srate     : tasa/frecuencia de sampleo
% times     : 

% estructura strcut chanlocs (Ubicacion de los canales###)
%   labels:
%   type:
%   theta:
%   radius:
%   X:
%   Y:
%   Z:
%   sph_theta
%   sph_phi
%   sph_radius
%   urchan
%   ref


% estructura struct chaninfo (Informacion de los canales)
%   plotrad
%   shrik
%   nosedir
%   nodatchans:
%   icachanind:

% estructura struct event (Eventos)
% type      : tipo de evento 
% latency   : contiene la latencia del evento en la unidad de muestra de
%              datos
% urevent   : contienen el indice del evento in el original (='ur') from
%             GERMAN original
% epoch     : 

% estructura struct urevent -> Evento Original mantiene toda la informacion
% de los eventos como fueron originalmente cargados en el dataset mas los
% eventos que fueron manualmente sumados por el usuario. 
%   type    : 
%   latency : 


% estructura struct epoch
%   event           :
%   eventype        :
%   eventlatency    :
%   eventureevent   :

%% Inicializar variables para el codigo data for code

%flat the variable data

data=getfield(sampleEEG,"data");
%Nota data tiene 128 canales x 176 puntos grabados por epoca x 384 trials
chanlocs=getfield(sampleEEG,"chanlocs")
% muestras por epoca 
pnts= getfield(sampleEEG,"pnts");

%% 1 MS Word
Fs=getfield(sampleEEG,"srate");

% a
% 128 Canales
nbchan=getfield(sampleEEG,'nbchan');


% b
% 384 trials.
trials=getfield(sampleEEG,'trials');

% c
% duracion de la epoca 
xmin=getfield(sampleEEG,"xmin");
xmax=getfield(sampleEEG,"xmax");
epochduration=abs(xmin)+abs(xmax);

dt=1/Fs
% 0.7 segundos  + 0.0040 s


% d
% tiempo antes y despues del evento
% Tiempo antes      : 0.3
% Tiempo despues    : 0.4

% e 
% frecuencia de muestro del registro
% 250 Hz = Fs = srate




%% 2 
 
%Produzca dos tipos diferentes de gr??ficos en los que se visualicen 
% simult??neamente todas las ??pocas (trials) de un solo canal, 
% que usted elija. [2p]

numchan=11; %canal seleccionar 
%M_mean=[];
% se define frecuencia de muestreo base
%base_Fs_sample=500;
% se define cual normalizacion sera utilizada
%Norm2Use='Norm2';

% 


% = numel(channames);
%dimen=[length(startMeventype1) n_samples+1 numchan];


epoch_before_after_s=[xmin xmax];
arrachan_raw=nan(pnts,trials);
arrachan_raw=transpose(squeeze(data(numchan,:,:)));
%Normalize
for i=1:trials
arrachan(i,:)=zscore(arrachan_raw(i,:));
end

 t=0:pnts-1;
 t=(t)/Fs;
 t=t-abs(epoch_before_after_s(1));
%t=dt:dt:epochduration;

% sacar el vector de tiempo

% no olvidar de noramlizar
% session
% _08_01 

%arreglo para tener el listado de trials
listepochs=1:trials;

figure;

subplot(2,1,1);
hold on;
imagesc(t,listepochs,arrachan); 
ylabel("Epochs (Trials)");
xlabel("Time to event (s)");
%cb=colorbar; 
%ylabel(cb,'EEG (zscore)')
xlim([epoch_before_after_s])
subplot(2,1,2);
hold on;
plot(t,arrachan,'color',[0.6 0.6 0.6]);
mean_arrachan=mean(arrachan,'omitnan') % se obtiene el promedio de las epocas eventos
plot(t,mean_arrachan,'LineWidth',3,'Color','k');
xlim([epoch_before_after_s]);




 %% 3 

 %3. Produzca un gr??fico que contenga dos ERP de canales diferentes, 
 % resultantes de promediar todas las ??pocas. 
 % Procure elegir los canales de manera que los ERP no sean similares. 
 % Indique claramente qu?? canal corresponde a cada ERP. 
 % Grafique desde 100 ms antes del evento hasta 350 ms despu??s del mismo. 
 % [2p]


numchan1 = 11
numchan2 = 76


arrachan_raw1=nan(pnts,trials);
arrachan_raw1=transpose(squeeze(data(numchan1,:,:)));

arrachan_raw2=nan(pnts,trials);
arrachan_raw2=transpose(squeeze(data(numchan2,:,:)));


mean_arrachan1=mean(arrachan_raw1,"omitnan");
mean_arrachan2=mean(arrachan_raw2,"omitnan");



%t=dt:dt:epochduration;

% se busca el elemento con valor 0 

n_samples_before_after = abs(epoch_before_after_s./dt); % para obtener la cantidad eelementos en cada
elemnt_zero = n_samples_before_after(1)+1;
time_before_event_s=0.1
time_after_event_s=0.35
element_before = round(time_before_event_s / dt) %se obtienen cuantos elementos antes evento
element_after = round(time_after_event_s / dt) % se obtiene ceuantos elementos son 350 ms

start_index=n_samples_before_after(1)-element_before;
end_index=n_samples_before_after(1)+element_after+1;
t3=t(start_index:end_index)
subset_mean_arrachan1=mean_arrachan1(start_index:end_index)
subset_mean_arrachan2=mean_arrachan2(start_index:end_index)


figure;
hold on;
plot(t3,subset_mean_arrachan1);
plot(t3,subset_mean_arrachan2);
xlim([time_before_event_s*-1 time_after_event_s])
ylabel("Power");
xlabel("Time to event (s)");

%% 4
% Produzca el mismo gr??fico de la pregunta anterior, pero esta vez 
% a????dale alg??n estimado de variabilidad a cada ERP. [1p]


std_arrachan1=std(arrachan_raw1,"omitnan");
std_arrachan2=std(arrachan_raw2,"omitnan");

subset_std_arrachan1=std_arrachan1(start_index:end_index)
subset_std_arrachan2=std_arrachan2(start_index:end_index)


figure;
hold on;
p1=plot(t3,subset_mean_arrachan1,'b');
p2=plot(t3,subset_mean_arrachan2,'r');
xlim([time_before_event_s*-1 time_after_event_s])


% variables para almacenar la media + desviacion standard
  pos_sd_arrachan1=(subset_mean_arrachan1')+(subset_std_arrachan1');
    % variables para almacenar la media - desviacion standard
   neg_sd_arrachan1 =(subset_mean_arrachan1')-(subset_std_arrachan1');

pos_sd_arrachan2=(subset_mean_arrachan2')+(subset_std_arrachan2');
    % variables para almacenar la media - desviacion standard
   neg_sd_arrachan2 =(subset_mean_arrachan2')-(subset_std_arrachan2');

 p3=plot(t3,pos_sd_arrachan1,'b','LineWidth', 1);
 p4=plot(t3,neg_sd_arrachan1,'b','LineWidth', 1);

 p5=plot(t3,pos_sd_arrachan2,'r','LineWidth', 1);
 p6=plot(t3,neg_sd_arrachan2,'r','LineWidth', 1);


 %title("Promedio Total vs Promedios individuales ")
    % se genera un Shade entre el valor de media y la desviacion standard
    % +/-
     % patch([t3(:); flipud(t3(:))], [neg_sd_arrachan1;  flipud(pos_sd_arrachan1)], 'r', 'FaceAlpha',0.2, 'EdgeColor','none')
patch([t3(:); flipud(t3(:))], [neg_sd_arrachan1;  flipud(pos_sd_arrachan1)], 'b', 'FaceAlpha',0.2, 'EdgeColor','none');
patch([t3(:); flipud(t3(:))], [neg_sd_arrachan2;  flipud(pos_sd_arrachan2)], 'r', 'FaceAlpha',0.2, 'EdgeColor','none');



%% 5


time_before_event_s_5=0.05
time_after_event_s_5=0.35

% se promedian todas las epocas para obtener el ERP. ????

% se recorre cada uno de los canales 


% arreglo para almacenar el promedio de las epocas de cada canal

M_ERP_chan=nan(nbchan,pnts)

for i=1:nbchan
% por cada canal se promediara

    
    temp_arrachan_raw=transpose(squeeze(data(i,:,:)));

    %Normalize
        for j=1:numel(trials)
            temp_arrachan(i,:)=zscore(temp_arrachan_raw(i,:));
         end

     M_ERP_chan(i,:)=mean(temp_arrachan,'omitnan');
end

listchans=1:nbchan;
element_before_5 = round(time_before_event_s_5 / dt) %se obtienen cuantos elementos antes evento
element_after_5 = round(time_after_event_s_5 / dt) % se obtiene ceuantos elementos 

start_index_5=n_samples_before_after(1)-element_before_5;
end_index_5=n_samples_before_after(1)+element_after_5+1;

t5=t(start_index_5:end_index_5);
subset_M_ERP_chan=M_ERP_chan(:,start_index_5:end_index_5);

figure;
hold on;
plot(t5,subset_M_ERP_chan);
ylabel('ERP');
xlabel('Time to Event');


%% 6

%% 7


% INICIO eliminar
% usar rasterpolot para seleccionar el canal adecuado

M_ERP_chan_all=nan(nbchan,pnts)

for i=1:nbchan
% por cada canal se promediara

    
    temp_arrachan_raw=transpose(squeeze(data(i,:,:)));

    %Normalize
        %for j=1:numel(trials)
        %    temp_arrachan(i,:)=zscore(temp_arrachan_raw(i,:));
        % end

     M_ERP_chan_all(i,:)=mean(temp_arrachan_raw,'omitnan');
end
figure;
hold on;
imagesc(t,listchans,M_ERP_chan_all); 
ylabel("Channels (Trials)");
xlabel("Time to event (s)");


figure;
hold on;
imagesc(t,listchans,M_ERP_chan_all); 
% INICIO eliminar FIN




%T=time_before_event_s_5+time_after_event_s_5
numchan7=76;
epoch = 20;

N=pnts; % el numero de muestras
%N=round(pnts*Fs); 
arrachan_raw_7=squeeze(data(numchan7,:,epoch));


figure;
hold on;
plot(t,arrachan_raw_7); 

Y=fft(arrachan_raw_7);  % resultado de fft (complejo)
%P2=abs(Y/2).^2;  %espectro de poder doble
P2=abs(Y/N);  %espectro de poder doble
P1_individual=P2(1:(N/2)+1);  % espectro de poder single
nFourier=(N/2)+1; 
df=Fs/N; % %resoluci??n en frecuencia (Hz)
f=0:df:(Fs/2); % frecuencia 



%INICIO Validar
P2_2 = abs(Y/N);
P1_2 = P2_2(1:N/2+1);
P1_2(2:end-1) = 2*P1_2(2:end-1);
f_2 = Fs*(0:(N/2))/N;
figure;
plot(f_2,P1_2)
xlabel('Frequency (Hz)')
ylabel('Power')
% FIN VAlidar

M_P1=nan(trials,N/2+1);
%ciclo para el calculo de los espectros indivduales de cada trial
for i=1:trials

    arrachan_raw_7=squeeze(data(numchan7,:,i));
    Y=fft(arrachan_raw_7);  % resultado de fft (complejo)
%P2=abs(Y/N).^2;  %espectro de poder doble
P2=abs(Y/N);  %espectro de poder doble
M_P1(i,:)=P2(1:(N/2)+1);  % espectro de poder single

end

mean_M_P1=mean(M_P1,'omitnan');
sum_M_P1=mean(M_P1,'omitnan');

figure;
subplot(2,1,1);
plot(f,P1_individual)
title("FFT Individual - Channel " + num2str(numchan7)  + " epoch " + num2str(epoch))
xlabel('Frequency (Hz)')
ylabel('Power')
%xlim([0 120])
subplot(2,1,2);
plot(f,mean_M_P1);
title("FFT Individual - Channel " + num2str(numchan7) )
xlabel('Frequency (Hz)')
ylabel('Power')


%figure;
%subplot(2,1,1);
%plot(f,M_P1)
%xlabel('Frequency (Hz)')
%ylabel('Power')
%xlim([0 120])
%subplot(2,1,2);
%plot(f,sum_M_P1);
%xlabel('Frequency (Hz)')
%ylabel('Power')


figure;
hold on;
imagesc(t,listepochs,M_P1); 
ylabel("Trials (Trials)");
xlabel("Time to event (s)");


%% 8 


std_M_P1= std(M_P1,'omitnan');

figure;
hold on;
p0=plot(f,M_P1,'Color',[0.6 0.6 0.6])
p1=plot(f,mean_M_P1,'k')

% variables para almacenar la media + desviacion standard
  pos_sd_M_P1=(mean_M_P1')+(std_M_P1');
    % variables para almacenar la media - desviacion standard
   neg_sd_M_P1 =(mean_M_P1')-(std_M_P1');



p2=plot(f,pos_sd_M_P1,'b','LineWidth', 1);
p3=plot(f,neg_sd_M_P1,'b','LineWidth', 1);



 %title("Promedio Total vs Promedios individuales ")
    % se genera un Shade entre el valor de media y la desviacion standard
    % +/-
patch([f(:); flipud(f(:))], [neg_sd_M_P1;  flipud(pos_sd_M_P1)], 'b', 'FaceAlpha',0.2, 'EdgeColor','none');
xlabel('Frequency (Hz)')
ylabel('Power')


%% 9 tapper gausiano

% tam??o de la ventana
% tama??o del paso 

winsize=0.1
winstep=0.01

GW=gausswin(pnts)'

arrachan_raw_9=squeeze(data(numchan7,:,epoch));
X_gauss=GW.*arrachan_raw_9


Y=fft(X_gauss);  % resultado de fft (complejo)
P2=abs(Y/N);  %espectro de poder doble
P1_Gauss_ind=P2(1:(N/2)+1);  % espectro de poder single
nFourier=(N/2)+1; 
df=Fs/N; % %resoluci??n en frecuencia (Hz)
f=0:df:(Fs/2); % frecuencia 



figure;
hold on;
imagesc(t,listepochs,P1_Gauss_ind); 
ylabel("Trials (Trials)");
xlabel("Time to event (s)");



M_P1_gauss=nan(trials,N/2+1);
%ciclo para el calculo de los espectros indivduales de cada trial
for i=1:trials

    arrachan_raw_9=squeeze(data(numchan7,:,i));
    X_gauss=GW.*arrachan_raw_9
    Y=fft(X_gauss);  % resultado de fft (complejo)
P2=abs(Y/N);  %espectro de poder doble
M_P1_gauss(i,:)=P2(1:(N/2)+1);  % espectro de poder single

end

mean_M_P1_gauss=mean(M_P1_gauss,'omitnan');


figure;
subplot(2,1,1);
plot(f,P1_Gauss_ind)
title("Taper Gaussiano Individual - Channel " + num2str(numchan7)  + " epoch " + num2str(epoch))
xlabel('Frequency (Hz)')
ylabel('Power')
%xlim([0 120])
subplot(2,1,2);
plot(f,mean_M_P1_gauss);
title("Taper Gaussiano Individual - Channel "  + num2str(numchan7)  )
xlabel('Frequency (Hz)')
ylabel('Power')


% chronux mtspecgramc

params.Fs=Fs
params.tapers=[3 5]
params.err=0

[S9, t9, f9]=mtspecgramc(arrachan_raw_7,[winsize winstep],params )

figure;

bar(S9);

return;
