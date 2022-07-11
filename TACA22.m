
% carga (importación) de un conjunto de archivos .mat

% definir directorio o ruta donde están los archivos
my_path='D:\Matlab\Dataset'

% usar comando 'dir' para obtener la información (nombres) de los archivos
% (añadir que solo extraiga la info de los archivos .mat)
D=dir([my_path filesep '*.mat']);

%prealocar para guardar los datos
RT=nan(300,numel(D));

for thisFile = 1: numel(D)  %loop por los archivos (i.e., por los participantes)
    
    load(D(thisFile).name)  %carga del archivo
    
    rt=BehavData.vars.RT_seq;  %extracción de la variable
    
    RT(1:numel(rt),thisFile)=rt;   %guardado de la variable en una matriz
    
end

%%	Estime los parámetros a y b de su modelo lineal, usando código propio. [1p]

Mean_behav=mean(RT,2, 'omitnan'); % promedios de respuesta por cada trial
Trials=[1:300]
Trials= transpose (Trials)
%Calculo suma de cuadrados

SS_behav=sum((Mean_behav-mean(Mean_behav)).^2)
SS_trials=sum((Trials-mean(Trials)).^2)


% Calculo covarianza

mult=(Mean_behav-mean(Mean_behav)).*(Trials-mean(Trials));
numerador= sum(mult);
Cov_behav_trials=numerador./299

%Cov_behav_trials=cov(Mean_behav,Trials) %calculo covarianza directa
% Calculo parámetros a y b hat
b_hat_behav=Cov_behav_trials/var(Mean_behav) 

a_hat_trials=(mean(Trials))-(b_hat_behav*mean(Mean_behav))

%Graficar

figure;hold on
plot(Trials, Mean_behav,'ok') %gráfico datos

Xtrials=[1 300]; %el mínimo y máximo de trials
Ybehav=a_hat_trials+b_hat_behav.*Xtrials;
plot(Xtrials,Ybehav,'linewidth',2)
xlabel('Trials')
ylabel('Behav responses')
title('Pendiente')


% 
% A=[]
% SS_behav=[]
% 
% for jj=1:length(RT(:,1));
%     media = mean(RT(jj,:));
%     for ii=1:1:length(RT(jj,:));
%        A(jj,ii) =  ((RT(jj,ii) - media).^2);
%        SS_behav(jj)=sum(A(jj,:)); %suma de cuadrados de y
%        
%     end
%     
% end
% 
% %Suma de cuadrados de los trials (x)
% Ss_trials=sum((Trials-mean(Trials)).^2)
% 
% 
% 
% 
% 
% 
% %Calculo la covarianza
% B=[]
% C=[]
% 
% for pp=1:length(RT(:,1));
%     media = mean(RT(jj,:));
%     for tt=1:1:length(RT(pp,:));
%        B(pp,tt) =  ((RT(pp,tt) - media));
%        C(pp,tt)=B(pp,tt);
%        
%     end
%     
% end
% 
% 

