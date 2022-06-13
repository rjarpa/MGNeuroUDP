% Trabajo 01
% Ruben Jarpa
% Jun-2022
clear all;
load('WP_Pupil_Data')

%% 1 
% estructura struct INFO 
%   events_of_ref       : vector de eventos en los que se dividio el experimento
%   date_analysis       : vector con fecha de ejecucion  del analisis 
%                             año mes dia hora minutos y segundos
%   epoch_before_after_s: vector tiempos de inicio y fin las epocas en segundos
%                           con respecto a la presion del boton
%   particip_initials   : vector con iniciales de todos los participantes
%   filter_min_n_trials : vector logico con los participantes que
%                           cumplen con el minimo numero de trials
%   min_n_trials        : limite minimo de numero de trials validos para el
%                           experimento

% 
% Descripcion del tipo de Normalizaciones de las muestras
%   Norm1 'subtract first epoch value'
%   Norm2 'z-score epoch'
%   Norm3 'divide by first epoch value'


% estructura struct DATA

% Estructura struct que alberga la informacion de 14 participantes
% las variables por participantes son
% pupilEpochs_raw               :   datos originales dividio en
%                                   epocas/trials con las muestras del diametro pupilar
%                                   estos incluyen informacion de pestañeos con valor 0 
%                                   columnas son los trials y las filas las
%                                   muestras
% performance                   :   vector booleano con el rendimiento del
%                                   participante con o sin presion de boton
% misses                        :   vector booleano que registro la no
%                                   presion del boton
% performance_nomisses          :  vector booleano con los datos donde se
%                                  presiono el boton y registro del
%                                  rendimiento del particpante
% RT_nomisses                   :   Tiempo de respuesta de la presion del
%                                   boton
% pupilEpochs_blinkinterp       :   vector con las muestras del diametro
%                                   pupilar interpolado para rellenar
%                                   valores 0 producidos por
%                                   parpadeos
% pupilEpochs_blinkinterp_Norm1 :  vector con las muestras del diametro
%                                   pupilar interp y normalizado en la resta de los
%                                   valores de la primer epoca
% pupilEpochs_blinkinterp_Norm2 :   vector con las muestras del diametro
%                                   pupilar interp y normalizado usando z-score
% pupilEpochs_blinkinterp_Norm3 :   vector con las muestras del diametro
%                                   pupilar interp y normalizado diviendo los
%                                   valores de la primera epoca
% pupilEpochs_blinks            :   vector logico con registro 
%                                   de parpadeo del participante
% Fs                            :   Frecuencia de refresco por segundo




% Inicializando variables Variables

INFO=getfield(PUPILDATA,'info');
filter_min_n_trials=PUPILDATA.info.filter_min_n_trials;
min_n_trials = PUPILDATA.info.min_n_trials;
DATA=getfield(PUPILDATA,'data');
dtnames=fieldnames(DATA);
% cantidad de participantes
participant_number=length(dtnames);
epoch_before_after_s=INFO.epoch_before_after_s;


%% 1


participant_n=1; % Numero Indice del participante que se ocupara en el codigo.

% se valida que el valor del partipante se encuentre en el vector de
% nombres
if ~(participant_n>0 && participant_n<participant_number)
    display("Error Participant Number must be between 1 and " + participant_number) 
   return;
end


% calculo del valor total de segundos de la epoca 
total_s=abs(epoch_before_after_s); 
total_s=sum(total_s);

%% 2
      
    
     Norm2Use='Norm1'; % variable para definir la normalizacion a usar
     temp=getfield(DATA,dtnames{participant_n}); % se obtienen los datos del participante
     % se obtienen la coleccion de muestras de los datos normalizados
     epochs_Norm=getfield(temp, "pupilEpochs_blinkinterp_" + Norm2Use);
     % se obtiene la frecuencia de muestreo
     Fs=temp.Fs;

     % se obtiene la media de los datos normalizados omitiendo los nan
     epochs_Norm_mean=mean(epochs_Norm','omitnan');
    
     % se calcula la cantidad de muestras de la epoca
    n_samples=total_s*Fs;
    
    % se crea el vector de tiempo
    t=0:n_samples; 
    t=(t)/Fs;
    % se resta valor para dejar en 0 el momento del evento
    t=t-abs(epoch_before_after_s(1));

    % se grafica
    figure('Name',"Figure 2 - Part : " + dtnames{participant_n});
    % se grafica la media de un participante
    plot(t,epochs_Norm_mean')
    legend ("Mean Normalization - " + getfield(INFO,Norm2Use));
    xlabel('Time (s)');
    ylabel('Pupil Diameter ');



%% 3


     temp=getfield(DATA,   dtnames{participant_n});

     % se obtienen la coleccion de muestras de los datos normalizados
     epochs_Norm1=getfield(temp, 'pupilEpochs_blinkinterp_Norm1');
     epochs_Norm2=getfield(temp, 'pupilEpochs_blinkinterp_Norm2');
     epochs_Norm3=getfield(temp, 'pupilEpochs_blinkinterp_Norm3');
      % se obtiene la frecuencia de muestreo
     Fs=temp.Fs;
    % se obtiene la media de los datos normalizados omitiendo los nan
    epochs_Norm1_mean=mean(epochs_Norm1','omitnan');  % 3XXX samples por evento
    epochs_Norm2_mean=mean(epochs_Norm2','omitnan');  % 3XXX samples por evento
    epochs_Norm3_mean=mean(epochs_Norm3','omitnan');  % 3XXX samples por evento
      % se calcula la cantidad de muestras de la epoca
    n_samples=total_s*Fs;
     % se crea el vector de tiempo
    t=0:n_samples;
    t=(t)/Fs;
    t=t-abs(epoch_before_after_s(1));

   % se crea vector para procesar las 3 serie de tiempo
    M=[epochs_Norm1_mean 
        epochs_Norm2_mean 
        epochs_Norm3_mean];

 figure('Name',"Figure 2 - Part : " + dtnames{participant_n});
    

 % se crea bucle para mostar graficos separados en la misma imagen
for i=1:3
    
    % permite generar graficos por separados filas, columnas y el numero
    % del grafico
    subplot(3,1,i);
    % se grafican los valores del arreglo
    plot(t,M(i,:)');
    legend ("Mean Normalization - " + getfield(INFO,"Norm" + i))
    xlabel('Time (s)');
    ylabel('Pupil Diameter ');
end





%% 4

       Norm2Use='Norm1';
     temp=getfield(DATA,   dtnames{participant_n});
     % se obtienen la coleccion de muestras de los datos normalizados
     epochs_Norm=getfield(temp, "pupilEpochs_blinkinterp_" + Norm2Use);
     % se obtiene la frecuencia de muestreo
     Fs=temp.Fs;
    
     % se obtiene la media de los datos normalizados omitiendo los nan
    epochs_Norm_mean=mean(epochs_Norm','omitnan');
     % se obtiene la desviacion standard de los datos normalizados omitiendo los nan
    epochs_Norm_std=std(epochs_Norm','omitnan'); 
     % se calcula la cantidad de muestras de la epoca
    n_samples=total_s*Fs;
    % se crea el vector de tiempo
    t=0:n_samples;
    t=(t)/Fs;
    t=t-abs(epoch_before_after_s(1));


    % se grafican los datos
    figure('Name',"Figure 4 Participant : " + dtnames{participant_n});
    hold on;
    % se grafica la media
    plot(t,epochs_Norm_mean')
    % se grafica la media  + desviacion standard
    plot(t,(epochs_Norm_mean')+(epochs_Norm_std'),'_r')
    % se grafica la media  - desviacion standard
    plot(t,(epochs_Norm_mean')-(epochs_Norm_std'),'_b')
    legend ("Mean Normalization - " + getfield(INFO,Norm2Use),...
        "+sd Normalization - " + getfield(INFO,Norm2Use),...
        "-sd Normalization - " + getfield(INFO,Norm2Use))
    xlabel('Time (s)');
    ylabel('Pupil Diameter ');









    %% 5
    
    % se obtiene el vector logico de trials con presion del boton

    performance=(temp.performance_nomisses');
    % se obtiene vector solo con los valores con presion acertada del boton
    logic_perf_1 = epochs_Norm(:,performance==1);
    % se obtiene vector solo con los valores con presion errada del boton
    logic_perf_0 = epochs_Norm(:,performance==0);

    % se obtiene la media para presion acertada y errada omitiendo nan
    logic_perf_1_mean = mean(logic_perf_1',"omitnan");
    logic_perf_0_mean = mean(logic_perf_0','omitnan');


    % se grafica la informacion
   figure('Name','Figure 5');
    hold on;
    % graficar la media de seleccion correcta
    plot(t,logic_perf_1_mean')
    % graficar la media de seleccion errada
    plot(t,logic_perf_0_mean')
    xlabel('Time (s)');
    ylabel('Pupil Diameter ');
    legend('Perfomance OK', 'Perfomance NoK')

    %% 6

    % inicializando vectores
    M_mean=[];
    M_std=[];
    Norm2Use='Norm1';

    % ciclo para trabajar con 2 sujetos adyacentes
for i=participant_n:participant_n+1
       
     temp=getfield(DATA,dtnames{i});
     epochs_Norm=getfield(temp, "pupilEpochs_blinkinterp_" + Norm2Use);
     Fs=temp.Fs;

     % se obtiene la media
    epochs_Norm_mean=mean(epochs_Norm','omitnan');
    % se obtiene la desviacion standard
    epochs_Norm_std=std(epochs_Norm','omitnan');  
   
    n_samples=total_s*Fs;
    t=0:n_samples; 
    t=(t)/Fs;
    t=t-abs(epoch_before_after_s(1));
    
    % se almacena la media en vector para cada participante
    M_mean(i,:)=[(epochs_Norm_mean)];
    % se almacena la distribucion standard en vector para cada participante
    M_std(i,:)=[(epochs_Norm_std)];

end


% se grafica la informacion
figure('Name','Figure 6');


% se obtienen magnitudes min y max para hacer equivalentes graficos

max_value=max(sum(M_mean+M_std));
min_value=min(sum(M_mean-M_std));

% se ocupa ciclo para graficar la informacion de cada participante
    for (i=1:2)
    subplot(2,1,i)
    hold on; 
    % se grafica la media 
    plot(t,M_mean(i,:)')
    % se grafica la media + desviacion standard
    plot(t,M_mean(i,:)'+M_std(i,:)','_r')
    % se grafica la media - desviacion standard
    plot(t,M_mean(i,:)'-M_std(i,:)','_b')
    xlabel('Time (s)');
    ylabel('Pupil Diameter ');
    legend('mean','+sd','-sd');
    ylim([min_value max_value])
    hold off;

    end
  

    

 


%% 7 


M_mean=[];

% se define frecuencia de muestreo base
base_Fs_sample=500;
% se define cual normalizacion sera utilizada
Norm2Use='Norm2';

% bucle para recorrer arreglo con los nombres de los participante en DATA
for i=1:numel(dtnames)
     temp=getfield(DATA,   dtnames{i});

     epochs_Norm=getfield(temp, "pupilEpochs_blinkinterp_" + Norm2Use);
     Fs=temp.Fs;
    
     % se calcula la tasa de muestro contra la tasa base
     downsample_rate=Fs/base_Fs_sample; 

     % si el calculo entrega un valor positivo se baja la tasa de muestreo
     if downsample_rate>0
     epochs_Norm=downsample(epochs_Norm,downsample_rate);
     else
         % si el valor es negativo se sube la tasa de muestreo con respecto
         % a la base
         upsample_rate=base_Fs_sample/Fs;
         epochs_Norm=upsample(epochs_Norm,upsample_rate);
     end

     
    % se obtiene la media omitiendo los nan
    epochs_Norm_mean=mean(epochs_Norm','omitnan');  % 3XXX samples por evento
    
    % se obtiene la cantidad de muestras
    n_samples=total_s*base_Fs_sample;
    
    % se crea el vector de tiempo
    t=0:n_samples; 
    t=(t)/Fs;
    t=t-abs(epoch_before_after_s(1));


 M_mean(i,:)=[(epochs_Norm_mean)];

     
end

% se obtiene un vector para todos los partcipantes
participant_list=1:length(dtnames);
% se grafica la informacion

figure('Name','Figure 7');
hold on;
% se genera el rasterplot graficando en Y los nombres de participantes y en
% X el tiempo de la respuesta pupilar y el en promedio con la magnitud de
% colores
imagesc(t,participant_list,M_mean); shading flat;
xlabel('Time (s)');
ylabel('Participants ID');
vticks=1:14;
yticks(vticks)
yticklabels(dtnames);



% 8


% se obtiene la media total de la respuesta pupilar promedio de los
% participanes
M_mean_total=mean(M_mean,'omitnan');
% se obtiene la desviadcion standard total de la respuesta pupilar promedio de los
% participanes
M_std_total=std(M_mean,'omitnan');


% se grafica la informacion
figure('Name','Figure 8');
    hold on;

    % se grafica la informacion de media de todos los individuos en gris
    p1=plot(t,M_mean,'.','Color',  [0.5 0.5 0.5]); % promedios de cada participante
    p2=plot(t,M_mean_total,'ok'); % Promedios de promedios
    % variables para almacenar la media + desviacion standard
    pos_sd=(M_mean_total')+(M_std_total');
    % variables para almacenar la media - desviacion standard
   neg_sd =(M_mean_total')-(M_std_total');
   % se grafican ambas variables anteriores
    p3=plot(t,pos_sd,'or','LineWidth', 2);
    p4=plot(t,neg_sd,'ob','LineWidth', 2);
    % se genera un Shade entre el valor de media y la desviacion standard
    % +/-
    patch([t(:); flipud(t(:))], [neg_sd;  flipud(pos_sd)], 'r', 'FaceAlpha',0.2, 'EdgeColor','none')
    xlabel('Time (s)');
    ylabel('Pupil Diameter ');
    % se muestra leyenda
    lgd = legend([p1(1) p2(1) p3(1) p4(1)], 'individuals mean','mean','+sd','-sd');
    title(lgd,'legend')
