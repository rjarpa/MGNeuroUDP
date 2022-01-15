clear all
% carga (importación) de un conjunto de archivos .mat

% definir directorio o ruta donde están los archivos
my_path='D:\OneDrive\Magister - Neurociencias\TACA-TECNICAS DE ANALISIS CUANTITATIVO AVAN\DataSets_Behavior_CognitiveTasks\HUMAN_WP';
%my_path='D:\Matlab\Dataset'

% usar comando 'dir' para obtener la información (nombres) de los archivos
% (añadir que solo extraiga la info de los archivos .mat)
D=dir([my_path filesep '*.mat']);

%prealocar para guardar los datos
 Edad=nan(1,numel(D));

for thisFile = 1: numel(D)  %loop por los archivos (i.e., por los participantes)
    
    %load(D(thisFile).name)  %carga del archivo
    filename=horzcat(D(thisFile).folder,filesep,D(thisFile).name);
    load(filename)  %carga del archivo
    try
       ed=BehavData.info.Subject_Age; 
    catch exception
       ed=BehavData.info.Age;
    end
    
     %extracción de la variable
    
    Edad(1,thisFile)=str2double(ed);   %guardado de la variable en una matriz
    
end

%Promedio edad
Mean_edad=mean(Edad);

%Desviación estándar edad

DE_edad=std(Edad);

%Rango edad

min_edad=min(Edad)
max_edad=max(Edad)

%% Género

%prealocar para guardar los datos
 Genero=nan(1,numel(D));

 contF=0
 contM=0
for thisFile = 1: numel(D)  %loop por los archivos (i.e., por los participantes)
    
    %load(D(thisFile).name)  %carga del archivo
    filename=horzcat(D(thisFile).folder,filesep,D(thisFile).name);
    load(filename)  %carga del archivo
    try
       gen=BehavData.info.Subject_Gender; 
       if gen=='F'
           contF=contF+1
       else contM=contM+1
       end
    catch exception
       gen=BehavData.info.Gender;
       if gen=='F'
           contF=contF+1
       else contM=contM+1
       end
    end
        
end

contM=300-contF


% c1=0
% c2=0
% c3=0
% for thisFile = 1: numel(D)  %loop por los archivos (i.e., por los participantes)
%     
%     load(D(thisFile).name)  %carga del archivo
%     if (BehavData.info.Subject_Gender)=='F'; 
%         c1=c1+1
%     elseif(BehavData.info.Gender)=='F';
%         c2=c2+1
%     else c3=c3+1
%     end
% 
%     
% end

%% Rendimiento (correctas/incorrectas)
%clear all
% carga (importación) de un conjunto de archivos .mat

% definir directorio o ruta donde están los archivos
%my_path='D:\Matlab\Dataset'

% usar comando 'dir' para obtener la información (nombres) de los archivos
% (añadir que solo extraiga la info de los archivos .mat)
D=dir([my_path filesep '*.mat']);

%prealocar para guardar los datos
Perform=nan(300,numel(D));

for thisFile = 1: numel(D)  %loop por los archivos (i.e., por los participantes)
    
   % load(D(thisFile).name)  %carga del archivo
    filename=horzcat(D(thisFile).folder,filesep,D(thisFile).name);
    load(filename)  %carga del archivo
    rt=BehavData.vars.Perform_seq;  %extracción de la variable
    
    Perform(1:numel(rt),thisFile)=rt;   %guardado de la variable en una matriz
    
end

%%% Bloques (6 bloques de 50 trials cada uno)
 %carga (importación) de un conjunto de archivos .mat

% definir directorio o ruta donde están los archivos
%my_path='D:\Matlab\Dataset'

% usar comando 'dir' para obtener la información (nombres) de los archivos
% (añadir que solo extraiga la info de los archivos .mat)
D=dir([my_path filesep '*.mat']);

%prealocar para guardar los datos
Bloques=nan(300,numel(D));

for thisFile = 1: numel(D)  %loop por los archivos (i.e., por los participantes)
    
    %load(D(thisFile).name)  %carga del archivo
        filename=horzcat(D(thisFile).folder,filesep,D(thisFile).name);
    load(filename)  %carga del archivo
    rt=BehavData.vars.Block_dumm;  %extracción de la variable
    
    Bloques(1:numel(rt),thisFile)=rt;   %guardado de la variable en una matriz
    
end

%% Lo que quiero hacer es sacar performance vs número de bloques

[fila,columna]=size(Perform);

for ii=1:columna
    
    jj=fila;
    while (jj>=1)
       if isnan(Perform(jj,ii))
          Perform(jj,ii)=1;
          disp(jj)
          
       else
           jj=1
           
       end
       
       jj=jj-1
       
    end
        
end



V1= Perform(1:50,:);
V2= Perform(51:100,:);
V3= Perform(101:150,:);
V4= Perform(151:200,:);
V5= Perform(201:250,:);
V6= Perform(251:300,:);

V1_sum=transpose(sum(V1,'omitnan'));

V2_sum=transpose(sum(V2,'omitnan'));

V3_sum=transpose(sum(V3,'omitnan'));

V4_sum=transpose(sum(V4,'omitnan'));

V5_sum=transpose(sum(V5,'omitnan'));

V6_sum=transpose(sum(V6,'omitnan'));


B1=V1_sum./50;
Porcentaje_B1=mean(B1);


B2=V2_sum./50;
Porcentaje_B2=mean(B2);

B3=V3_sum./50;
Porcentaje_B3=mean(B3);

B4=V4_sum./50;
Porcentaje_B4=mean(B4);

B5=V5_sum./50;
Porcentaje_B5=mean(B5);

B6=V6_sum./50;
Porcentaje_B6=mean(B6);

y=vertcat(Porcentaje_B1,Porcentaje_B2,Porcentaje_B3,Porcentaje_B4,Porcentaje_B5,Porcentaje_B6);
x=[1 2 3 4 5 6]';
T=table(y,x);

%Quiero tirar un anova

ML=fitlm(x,y)
tbl_var=anova(ML)

figure;
hold on
plot(x,y,'om')

Estimados=ML.Coefficients.Estimate;
B0=Estimados(1);
B1=Estimados(2);

X1=[min(x) max(x)];
Y1= B0 + B1 .* X1 ;
plot(X1,Y1,'-r');

hold off;

simu_distrmuestral(ML,tbl_var,x, B1 ,1000,'Simulacion','B','Probability')


%% funcion de simulacion

function simuBool=simu_distrmuestral(var_fitML,var_anovatbl,var_x_collection, pendiente ,var_Simu,var_figure_name,var_x_label,var_y_label)
%preparar variables
mdl=var_fitML;
x_var= var_x_collection;

nSims = var_Simu;
tbl=var_anovatbl;
figure_name=var_figure_name;
x_label=var_x_label;
y_label=var_y_label;

% realizar simulaciones 
var_Estimate=mdl.Coefficients.Estimate;

%varianza de SC error
%var_err_2=SS_err_2/df_err_2;
%obtener sigma del error para las simulaciones
%sd_2=sqrt(var_err_2);
varianza_error=tbl.MeanSq(2);
sd=sqrt(varianza_error);
intercept=var_Estimate(1);
predictor=var_Estimate(2);


for i=1:nSims
    % se realiza la simulacion de y con sd de la varianza SC error
    y_simu = intercept+predictor*x_var+randn(size(x_var)).*sd;
    %behaviour_y_simu = a_hat_2+b_hat_2*trial_x+normrnd(0,sd_2,size(trial_x));
    cov_simu=sum((x_var-mean(x_var)).*(y_simu-mean(y_simu)))./(numel(x_var)-1);
    hat_b_simu(i) = cov_simu/var(x_var);
    hat_a_simu(i) = mean(y_simu) - hat_b_simu(i)*mean(x_var);
end



%chart_histo(hat_b_simu,figure_name,x_label,pendiente);


%graficar distribucion de b_hat
figure('Name',figure_name);hold on;
mean_hat_b_simu=mean(hat_b_simu);
histogram(hat_b_simu,'Normalization','probability');
%se grafica media de b_hat
xline(mean_hat_b_simu,'r');
ylabel('probabilidad');
xlabel(x_label);

ci = [ prctile(hat_b_simu,2.5) prctile(hat_b_simu,97.5) ];
xline(ci(1,1),'g--');
xline(ci(1,2),'g--');


dim=[.15 .8 .2 0];
annotation('textbox',dim,'String',"Media =" + mean_hat_b_simu,'FitBoxToText','on','FontSize',10);


dim=[.15 .7 .2 0];
annotation('textbox',dim,'String',"Orignal Pendiente Modelo =" + pendiente,'FitBoxToText','on','FontSize',10);


simuBool=true;

end 







