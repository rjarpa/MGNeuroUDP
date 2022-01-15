clear all;
%% 2

path='D:\OneDrive\Magister - Neurociencias\TACA-TECNICAS DE ANALISIS CUANTITATIVO AVAN\DataSets_Behavior_CognitiveTasks\HUMAN_ULTIMATUM';
%HUMAN_ULTIMATUM
%path='/Users/rjarpa/OneDrive/Magister - Neurociencias/TACA-TECNICAS DE ANALISIS CUANTITATIVO AVAN/DataSets_Behavior_CognitiveTasks/HUMAN_ULTIMATUM';
var_rescue = 'RT_seq';
AllData=load_file(path,var_rescue);


[rows,cols]=size(AllData);
%crear matriz X  e Y
behaviour_y=[];
trial_x=[];

cont_trial=1;
cont_row=1;

for i = 1:rows 
    for j = 1:cols
        behaviour_y(cont_row,1)=AllData(i,j);
        trial_x(cont_row,1)=cont_trial;
       cont_row=cont_row+1;
    end  
    cont_trial=cont_trial+1;
end

f1=figure;
hold on;
% se grafican los puntos en la figura
plot(trial_x,behaviour_y,'ok');

%se gregan etiquetas de los ejes
xlabel('trials');
ylabel(strcat('behaviour ', var_rescue));
n_2=numel(trial_x)

% a

%media de volume y
media_y_2 =mean(behaviour_y);
% se obtiene la suma de cuadrados de la media SCtot
SS_tot_y_2 = sum((behaviour_y-media_y_2 ).^2);

%media de  heigth x
media_x_2 =mean(trial_x);
% se obtiene la suma de cuadrado
SS_tot_x_2 = sum((trial_x- media_x_2 ).^2);

%valor de la covarianza entre X e Y
cov_2=sum((trial_x-mean(trial_x)).*(behaviour_y-mean(behaviour_y)))./(numel(trial_x)-1);
%se ocupa funciona de matlab para obtener la covarianza de X e Y
%cov_b= cov(trial_x,behaviour_y); % validar el valor
%valor de la covarianza entre X e Y
%cov_b= cov_b(2,1);
%return
% se asigna la covarianza a la variable
Sxy_2 = cov_2;
%numero de elementos para ocupar en grados de libertad
n=numel(trial_x);
% se obtiene la varianza de x
Sx2_2= SS_tot_x_2/(n-1);
%Sx2 = var(trial_x); % validar

% se calcula el valor de b_hat
b_hat_2 = Sxy_2/Sx2_2;
a_hat_2 = media_y_2 - b_hat_2*media_x_2;

%b

%Estimar un Y desde b hat y a hat
behaviour_y_modelo=a_hat_2+b_hat_2*trial_x;
%obtener SC error % valida
%SS_err=sum((volume_y-volume_y_modelo).^2);
%SS_reg=SS_tot_y_3-SS_err
%Rxy2_3_valida=SS_reg/SS_tot_y_3

%calcular r cuadrado 
Rxy_2=Sxy_2/(std(trial_x)*std(behaviour_y));
Rxy2_2=Rxy_2^2 ;

X_2=[min(trial_x) max(trial_x)];
Y_2=a_hat_2 + b_hat_2  .*X_2;

% se grafica la ecuacion de la recta
plot(X_2,Y_2);

dim=[.15 .8 .2 0];
%annotation('textbox',dim,'String',"Model Equation Volume=" + a_hat_2+" + " + b_hat_2+ " * Height + e(0,"+s_2+")",'FitBoxToText','on','FontSize',8);
annotation('textbox',dim,'String',"Model Equation Volume=" + a_hat_2+" + " + b_hat_2+ " * Height",'FitBoxToText','on','FontSize',8);
dim=[.15 .6 .2 0];
annotation('textbox',dim,'String',"R square=" + Rxy2_2,'FitBoxToText','on','FontSize',8);
hold off;

% c

%tabla de analisis de la varianza
%codigo para validar
%mdl=fitlm(trial_x,behaviour_y)
%p=anova(mdl,'summary')

%calculo de Suma de cuadrados
SS_tot_2=SS_tot_y_2;
SS_err_2=sum((behaviour_y - behaviour_y_modelo).^2);
SS_reg_2=SS_tot_2-SS_err_2;

%variables para grados de libertad
df_tot_2=n_2-1;
df_err_2=n_2-2;
df_reg_2=1;

%calculos de varianza
MS_tot_2=SS_tot_2/df_tot_2;
MS_err_2=SS_err_2/df_err_2;
MS_reg_2=SS_reg_2/df_reg_2;

%calcular valor F
F=MS_reg_2/MS_err_2;

% valor de p
pvalue_2=1 - fcdf (F,df_reg_2,df_tot_2) ;

%varianza de SC error
var_err_2=SS_err_2/df_err_2;
%obtener sigma del error para las simulaciones
sd_2=sqrt(var_err_2);

figure(f1);
hold on;
dim=[.15 .8 .2 0];
annotation('textbox',dim,'String',"Model Equation Volume=" + a_hat_2+" + " + b_hat_2+ " * Height + e(0,"+sd_2+")",'FitBoxToText','on','FontSize',8);
hold off;

% d
% realizamos simulaciones para ver como varia b_hat y a_hat
nSims = 1000;
for i=1:nSims
    % se realiza la simulacion de y con sd de la varianza SC error
    behaviour_y_simu = a_hat_2+b_hat_2*trial_x+randn(size(trial_x)).*sd_2;
    %behaviour_y_simu = a_hat_2+b_hat_2*trial_x+normrnd(0,sd_2,size(trial_x));
    cov_2_simu=sum((trial_x-mean(trial_x)).*(behaviour_y_simu-mean(behaviour_y_simu)))./(numel(trial_x)-1);
    hat_b_2_simu(i) = cov_2_simu/Sx2_2;
    hat_a_2_simu(i) = mean(behaviour_y_simu) - hat_b_2_simu(i)*mean(trial_x);
end


%graficar distribucion de b_hat
figure;hold on;
mean_hat_b_simu=mean(hat_b_2_simu);
histogram(hat_b_2_simu,'Normalization','probability');
%se grafica media de b_hat
xline(mean_hat_b_simu,'r');
ylabel('probabilidad');
xlabel('b hat');
dim=[.15 .8 .2 0];
annotation('textbox',dim,'String',"Media =" + mean_hat_b_simu,'FitBoxToText','on','FontSize',8);

%f

% calculate the confidence interval b
ci_b_2 = [ prctile(hat_b_2_simu,2.5) prctile(hat_b_2_simu,97.5) ]
dim=[.15 .75 .2 0];
annotation('textbox',dim,'String',"95% CI:[" + ci_b_2(1,1) +" , " +ci_b_2(1,2)+"]",'FitBoxToText','on','FontSize',8);
dim=[.15 .90 .2 0];
annotation('textbox',dim,'String',"n Sims=" + nSims,'FitBoxToText','on','FontSize',8);
xline(ci_b_2(1,1),'g--');
xline(ci_b_2(1,2),'g--');
hold off;

%graficar distribucion de a_hat
figure;hold on;
mean_hat_a_simu=mean(hat_a_2_simu);
histogram(hat_a_2_simu,'Normalization','probability');
%se grafica media de a_hat
xline(mean_hat_a_simu,'r');
ylabel('probabilidad');
xlabel('a hat');
dim=[.15 .8 .2 0];
annotation('textbox',dim,'String',"Media =" + mean_hat_a_simu,'FitBoxToText','on','FontSize',8);


% calculate the confidence interval a
ci_a_2 = [ prctile(hat_a_2_simu,2.5) prctile(hat_a_2_simu,97.5) ];

dim=[.15 .75 .2 0];
annotation('textbox',dim,'String',"95% CI:[" + ci_a_2(1,1) +" , " +ci_a_2(1,2)+"]",'FitBoxToText','on','FontSize',8);
dim=[.15 .90 .2 0];
annotation('textbox',dim,'String',"n Sims=" + nSims,'FitBoxToText','on','FontSize',8);
xline(ci_a_2(1,1),'g--');
xline(ci_a_2(1,2),'g--');

hold off;

% g 

%calcular el atajo teorico del error standar de b 
% en distribucion de medias muestrales +/- 95% esta entre dos veces el (b+- 2 SEb)
% error standard
stderror_b_2 = sqrt(MS_err_2/SS_tot_x_2)

% POR VALIDAR
limsuperior = b_hat_2 + (2*stderror_b_2)
liminferior = b_hat_2 - (2*stderror_b_2)

%INTERPRETACION: De acuerdos a los datos arrojados por las simulaciones y
%graficos
% la distribucion de probabilidades de B el 95% de los valores de intervalo 
% de confianza
% se mueve entre
% -0.04438 y -0.0238 sin pasar por 0 asi podemos asegurar que no es error muestral 
% media = -0.0341 y el valor de B de -0.0340 que se obtuvo es de los mas frecuentes
% dentro de la distribucion muestralx
%la distribucion de probabilidades de A el 95% de los valores de intervalo
%de confianza se mueven entre
% 5.4681 y 6.1730 sin pasar por 0 asi podemos asegurar que no es error muestral 
% media = 5.8313
%tenemos que 
%tambien realizando una comparacion con el valor arrojado mediante el
%calculo teorico de B los valores de -0.0452 y -0.0228 bastante cercanos a
%las simulaciones
% el modelo en conjunto con el valor de r cuadrado muestra una pendiente no
% pronunciada casi plan por lo que el numero de trials como predictor
% predice muy poco de los valores de la variable cognitiva alrededor de un
% 4 por ciento.


%return
%% 3

%[NumData,~,AllData]=xlsread('TREES.csv')
%cambio de funcion porque no funciona en xlsread en MacOS
NumData=csvread('TREES.csv',1,0)

volume_y= NumData(:,3)
height_x= NumData(:,2)

figure;hold on;
% se grafican los puntos en la figura
plot(height_x,volume_y,'ok')

%se gregan etiquetas de los ejes
xlabel('height');
ylabel('volume');
% a
%media de volume y
media_y_3 =mean(volume_y);
% se obtiene la suma de cuadrados de la media SCtot
SS_tot_y_3 = sum((volume_y-media_y_3 ).^2);

%media de  heigth x
media_x_3 =mean(height_x);
% se obtiene la suma de cuadrado
SS_tot_x_3 = sum((height_x- media_x_3 ).^2);


%valor de la covarianza entre X e Y
cov_3=sum((height_x-mean(height_x)).*(volume_y-mean(volume_y)))./(numel(height_x)-1);
%se ocupa funciona de matlab para obtener la covarianza de X e Y
%cov_b= cov(height_x,volume_y); % validar el valor
%valor de la covarianza entre X e Y
%cov_b= cov_b(2,1);

% se asigna la covarianza a la variable
Sxy_3 = cov_3;
%numero de elementos para ocupar en grados de libertad
n=numel(height_x);
% se obtiene la varianza de x
Sx2_3= SS_tot_x_3/(n-1);
%Sx2 = var(height_x); % validar

% se calcula el valor de b_hat
b_hat_3 = Sxy_3/Sx2_3;
a_hat_3 = media_y_3 - b_hat_3*media_x_3;
%y= a +bx

%b

%Estimar un Y desde b hat y a hat
volume_y_modelo=a_hat_3+b_hat_3*height_x;
%obtener SC error % valida
SS_err_3=sum((volume_y-volume_y_modelo).^2);
%SS_reg=SS_tot_y_3-SS_err
%Rxy2_3_valida=SS_reg/SS_tot_y_3

%varianza de SC error
var_err_3=SS_err_3/(n-2);
%obtener sigma del error
s_3=sqrt(var_err_3);

%calcular r cuadrado 
Rxy_3=Sxy_3/(std(height_x)*std(volume_y))
Rxy2_3=Rxy_3^2 

X_3=[min(height_x) max(height_x)];
Y_3=a_hat_3 + b_hat_3  .*X_3;

% se grafica la ecuacion de la recta
plot(X_3,Y_3);

dim=[.15 .8 .2 0];
%annotation('textbox',dim,'String',"Model Equation (Volume=" + a_hat_3+" + " + b_hat_3+ " * Height)",'FitBoxToText','on','FontSize',8);
annotation('textbox',dim,'String',"Model Equation (Volume=" + a_hat_3+" + " + b_hat_3+ " * Height) + e(0,"+s_3+")",'FitBoxToText','on','FontSize',8);
dim=[.15 .6 .2 0];
annotation('textbox',dim,'String',"R square=" + Rxy2_3,'FitBoxToText','on','FontSize',8);
hold off;

% c
residuales=volume_y-volume_y_modelo;
media_residuales=mean(residuales)
figure;hold on;
% se grafican los puntos en la figura
plot(height_x,residuales,'ok')
yline(media_residuales,'r--');
%se gregan etiquetas de los ejes
xlabel('height');
ylabel('residuales');

%lineas utilizadas para validar
%mdl=fitlm(height_x,volume_y)
%p=anova(mdl,'summary')

%% funcion para cargar codigo

function arraVar=load_file(path,var_rescue)
% definir directorio o ruta donde están los archivos
my_path=path;

% usar comando 'dir' para obtener la información (nombres) de los archivos
% (añadir que solo extraiga la info de los archivos .mat)
D=dir([my_path filesep '*.mat']);

%prealocar para guardar los datos
%VR=nan(10000,numel(D));
VR=[];

for thisFile = 1: numel(D)  %loop por los archivos (i.e., por los participantes)
    
    filename=horzcat(D(thisFile).folder,filesep,D(thisFile).name);
    
    load(filename)  %carga del archivo
    
    %rt=BehavData.vars({'RT_seq'});  %extracción de la variable
    vr=getfield(BehavData,'vars',var_rescue);  %extracción de la variable
    VR(1:numel(vr),thisFile)=vr;   %guardado de la variable en una matriz
    
end

arraVar=VR;

end


