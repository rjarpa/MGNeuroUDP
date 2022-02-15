clear all

%% EJERCICIO 1

%Resultados prueba
nPreg=20;
pauta= randi([1 4],1,nPreg);%pauta de correcion

x=100000;%cantidad de sujetos
X_suj= randi([1 4], x,nPreg);%respuestas
Correctas=nan(x,nPreg);
for j=1:1:x
    for i=1:1:nPreg
     Correctas(j,i)=pauta(i)==X_suj(j,i);
    end
end
Correctas=sum(Correctas,2);
Resp=sum(13<=Correctas)/x  



% %calculo de P del 65 aciertos
% percent65 =(20/100)*65;%calculo cantidad de correctas
% cant_percent65= sum(percent65==correctas); %cuantos tuvieron 65 de exito?

%y=0:20;
%P=binopdf(y, 20, 0.25);
%figure;bar(y,P)

%% EJERCICIO 2
clear all

%Implementar simulación de test sucesivos a partir de distintas muestras
%aleatorias de una población original.
nPreg=20;
nItem=1;%numero de items
x=10; %cantidad de sujetos
ptje=(1:5);%rango de puntajes
tam_muestra=5;%tamaño de las muestras aleatorias
poblacion= randi([ptje(5)],nPreg,x);%respuestas del 1 al 5 en la escala

mediaspobl_porsujeto=mean(poblacion);stdpobl_porsujeto=std(poblacion,0); %media y desviacion estandar
criterio_muestra1= randperm(x, tam_muestra);
criterio_muestra2= randperm(x, tam_muestra);
cant_sim=5; %cantidad de muestras aleatorias

for ii= 1:1:cant_sim
muestra1=poblacion(criterio_muestra1,:); media_m1=mean(muestra1);
muestra2=poblacion(criterio_muestra2,:); media_m2=mean(muestra2);
[resultado_ttest(ii),valor_p(ii)]=ttest2(media_m1,media_m2)
end


%% EJERCICIO 3
clear all
%Encontrar una diferencia entre medias de dos grupos, de datos publicados.

%Estas son las medias y las desviaciones estandar (calculadas a partir del
%error estandar) de la publicacion del SMILES trial de F.Jacka. donde
%compara un grupo de intervencion nutri 'Diet' con un grupo de apoyo social
%'Social'. Las medias son de una escala de depresion mADSR.
n_diet=31; mean_pre_diet=26.1; mean_post_diet=14.8; SD_pre_diet=(1.0)*sqrt(n_diet); SD_post_diet=(1.1)*sqrt(n_diet);%/sqrt(n) es para convertir SE a SD.
n_social=25;mean_pre_social=24.7; mean_post_social=20.5;SD_pre_social=(1.0)*sqrt(n_social); SD_post_social=(1.2)*sqrt(n_social);

%distribuciones normales pre a partir de los parametros del paper.
distr_diet_pre=normrnd(mean_pre_diet,SD_pre_diet,[n_diet, 1]);
% distr_social_pre=normrnd(mean_pre_social,SD_pre_social,n_social);

%distribuciones normales post a partir de los parametros del paper.
distr_diet_post=normrnd(mean_post_diet,SD_post_diet,[n_diet 1]);
% distr_social_post=normrnd(mean_post_social,SD_post_social,n_social);

%visualizacion de distribuciones de ambas condiciones pre y post.
% graf_diet=figure;histogram(distr_social_pre);hold on;histogram(distr_social_post);
% title('Distribución Social original');xlabel('Ptje. MADRS'); ylabel('Cantidad de Sujetos');annotation('textbox',[0.15 0.5 0.15 0.04],'String','Pre');annotation('textbox',[0.8 0.5 0.1 0.04],'String','Post');
graf_social=figure;histogram(distr_diet_pre);hold on;histogram(distr_diet_post);
title('Distribución Diet original'); xlabel('Ptje. MADRS'); ylabel('Cantidad de Sujetos');annotation('textbox',[0.15 0.5 0.15 0.04],'String','Pre');annotation('textbox',[0.8 0.5 0.1 0.04],'String','Post');
% 
%Implementar version propia de simulación a partir de poblaciones
%originales.
%%

%Analizar valores P obtenidos de simulaciones
tam_muestra=25;%tamaño de las muestras aleatorias. debe ser menor a n_diet (31) y n_social (25)
cant_sim=100; %cantidad de muestras aleatorias

for ii= 1:1:cant_sim
criterio_muestra1= randperm(n_diet, tam_muestra);%estos son vectores con numeros aleatorios para despues usarlos para seleccionar de la poblacon original.
criterio_muestra2= randperm(n_social, tam_muestra);
muestra1=distr_diet_pre(criterio_muestra1,:); media_pre=mean(muestra1);
muestra2=distr_diet_post(criterio_muestra2,:); media_post=mean(muestra2);
%medias_muestrales(1,ii)=[media_pre]; medias_muestrales(2,ii)=[media_post];
[resultado_ttest(1,ii),resultado_ttest(2,ii)]=ttest2(media_pre,media_post);%fila 1 es resultado 0 o 1 y fila 2 valor de p.

end

%graficar valores p
scatter(1:cant_sim,resultado_ttest(2,:));
title('Distribución valores P'); xlabel('Numero de simulación'); ylabel('valor de p');

%graficar distribucion de medias muestrales
graf_mediasmuestales=figure;histogram(media_pre);hold on;histogram(media_post);
title('Distribución Medias muestrales'); xlabel('Numero de simulación'); ylabel('Medias puntaje');

