%% P2

%matriz1=67x60 (numero de participantes=67, condiciones de trials=4, intentos por sujeto por condicion=15).
%los 1 representan los éxitos y los 0 error. Se asumen 4 respuestas por
%condicion de trial 60 respuestas por individuo

%matriz2=contiene el porcentaje de exito de cada individuo por cada tipo de
%trial expresado en 0 a 1. 


%original de la tarea: matriz1=round(rand(67,60));
%creada con parametros:
GS =round(rand(67,15));
GE =round(rand(67,15));
NGS =round(rand(67,15));
NGE =round(rand(67,15));
matriz1=[GS GE NGS NGE];

%Creacion de la matriz2 de ceros
matriz2=zeros(67,4);

%contador fila matriz1 -> ii=1;
%contador columna matriz1 -> jj=1;
%contador columna matriz2
zz=1;
rateGS=zeros(67,1);
rateGE=zeros(67,1);
rateNGS=zeros(67,1);
rateNGE=zeros(67,1);

for ii= 1:1:67
    zz=1;
    for jj= 1:1:15
        rateGS(ii)= (rateGS(ii)+matriz1(ii,jj));
    end
    zz=zz+1;
    for jj= 16:1:30
        rateGE(ii)= (rateGE(ii)+matriz1(ii,jj));
    end
    zz=zz+1;
    for jj=31:1:45
        rateNGS(ii)= (rateNGS(ii)+matriz1(ii,jj));
    end
    zz=zz+1;
    for jj=46:1:60
        rateNGE(ii)= (rateNGE(ii)+matriz1(ii,jj));
    end
end

%calcular el porcentaje de cada sujeto por condicion de trial
matriz2=[rateGS rateGE rateNGS rateNGE];
matriz2=(matriz2/15)*100 ;

%calcular medias por tipo de trial, considerando todos los sujetos
mediaGSD = mean(matriz2(:, 1));
mediaGSN = mean(matriz2(:, 2));
mediaNGSD = mean(matriz2(:, 3));
mediaNGSN = mean(matriz2(:, 4));

%matriz de medias por condicion
mediasporcondicion=[mediaGSD mediaGSN mediaNGSD mediaNGSN];




%desviacion estandar
% stdGSD = std(matriz2(:, 1));
% stdGSN = std(matriz2(:, 2));
% stdNGSD = std(matriz2(:, 3));
% stdNGSN = std(matriz2(:, 4));


[p,tbl,stats]=anova1(matriz2);
close



SEM=std(matriz2)/sqrt(length(matriz2))


[h,p,ci,stats2]=ttest(mediasporcondicion);

%matriz de medias por condicion
stdporcondicion=[stdGSD stdGSN stdNGSD stdNGSN];


%% Graficar resultados
c = categorical({'GSN','GSD','NGSN', 'NGSD'});
titulo='Grafico 2A';

figure;
Grafico2A = bar(c, mediasporcondicion);

Grafico2A.FaceColor = 'flat';
Grafico2A.CData(1,:) = [0 0.8 0.8];
Grafico2A.CData(2,:) = [0 0.8 0.8];

hold on

er=errorbar(mediasporcondicion, stdporcondicion);
er.LineStyle = 'none';

title('Fig2A')
ylabel('Rate(%)')

hold off
