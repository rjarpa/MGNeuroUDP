%%1. 

% Carga de los datos
load('RJarpa_datAP3P1.mat')


%% Calculo de datos


totalparticipantes  = length(participantArray);

percentArrayByParti=[];

for jj=1:1:totalparticipantes
    
    %    rewardArray = []
    %    lostArray = []
    %    GSNickelArray =[]
    %    GSDollarArray  =  []
    %    NGSNickelArray = []
    %    NGSDollarArray = []
    
    % Utilizando la funcion size para obtener las dimensiones de la matriz
    
    indxLost   = lostArray(:,1)==jj;
    auxArraylost = lostArray(indxLost,:);
    
    
    [rowsLost,colsLost] = size(auxArraylost);
    
    %   Inicializar los contadores de perdidas
    contlostGSNickel=0;
    contlostGSDollar =0;
    contlostNGSNickel =0;
    contlostNGSDollar =0;
    
    
    %   Se va a recorrer solo la matriz de perdida para acumular los contadores
    %   de cada tipo de perdidad
    for i = 1: 1: rowsLost
        
        % es Nickel? es Go?
        if auxArraylost(i,2) == 1 &&  auxArraylost(i,3) == 1
            contlostGSNickel=contlostGSNickel+1;
            
            % es Dollar? es Go?
        elseif auxArraylost(i,2) == 0 &&  auxArraylost(i,3) == 1
            contlostGSDollar=contlostGSDollar+1;
            
            % es Nickel? es noGo?
        elseif auxArraylost(i,2) == 1 &&  auxArraylost(i,3) == 0
            contlostNGSNickel=contlostNGSNickel+1;
            
            % es Dollar? es noGo?
        elseif auxArraylost(i,2) == 0 &&  auxArraylost(i,3) == 0
            contlostNGSDollar=contlostNGSDollar+1;
        end
        
    end
    
    %   Se utiliza la funcion suma para obtener la acumulacion de todos los
    %   numeros 1 de cada respuesta correcta por tipo de moneda (estan en
    %   matrices distintas registradas)
    
    indxReward   = GSNickelArray(:,1)==jj;
    auxArrayReward = GSNickelArray(indxReward,:);
    contrewardGSNickel = sum(auxArrayReward(:,2));
    
    
    indxReward   = GSDollarArray(:,1)==jj;
    auxArrayReward = GSDollarArray(indxReward,:);
    contrewardGSDollar = sum(auxArrayReward(:,2));
    
    indxReward   = NGSNickelArray(:,1)==jj;
    auxArrayReward = NGSNickelArray(indxReward,:);
    contrewardNGSNickel = sum(auxArrayReward(:,2));
    
    
    indxReward   = NGSDollarArray(:,1)==jj;
    auxArrayReward = NGSDollarArray(indxReward,:);
    contrewardNGSDollar = sum(auxArrayReward(:,2));
    

    
    % Se obtiene el % de acierto de cada tipo (GS vs. NGS × dollar vs. nickel)
    percenGSNickel = (contrewardGSNickel/(contrewardGSNickel+contlostGSNickel))*100;
    percenGSDollar = (contrewardGSDollar/(contrewardGSDollar+contlostGSDollar))*100;
    percenNGSNickel = (contrewardNGSNickel/(contrewardNGSNickel+contlostNGSNickel))*100;
    percenNGSDollar = (contrewardNGSDollar/(contrewardNGSDollar+contlostNGSDollar))*100;
    
    
    % por cada  usuario  se almacena el porcentaje en la matriz se utiliza la
    % funcion lenght para obtener el largo de participantes
     
    % ciclo para almacenar los valores de
    % la estructura de las cabeceras del arreglo es (GSNickel,GSDollar,NGSNickel,NGSDollar)

    
    percentArrayByParti(jj,1)= jj;
    percentArrayByParti(jj,2)= percenGSNickel;
    percentArrayByParti(jj,3)= percenGSDollar;
    percentArrayByParti(jj,4)= percenNGSNickel;
    percentArrayByParti(jj,5)= percenNGSDollar;
    
    
end


promGSNickel=mean(percentArrayByParti(:,2),'omitnan');
promGSDollar=mean(percentArrayByParti(:,3),'omitnan');
promNGSNickel=mean(percentArrayByParti(:,4),'omitnan');
promNGSDollar=mean(percentArrayByParti(:,5),'omitnan');


for xx=1:1:totalparticipantes
    
    if isnan(percentArrayByParti(xx,2))
        percentArrayByParti(xx,2)=promGSNickel;
    end
    if isnan(percentArrayByParti(xx,3))
        percentArrayByParti(xx,3)=promGSDollar;
    end
    if isnan(percentArrayByParti(xx,4))
        percentArrayByParti(xx,4)=promNGSNickel;
    end
    if isnan(percentArrayByParti(xx,5))
        percentArrayByParti(xx,5)=promNGSDollar;
    end
    
    
end
    
%Pruebas con datos originales
%percentArrayByParti=testActualData;

% para analisis post hoc
% se utiliza la funcion ttest para comparar las 4 variables
% se crea una matriz para


[h,p,ci,stats2] = ttest(percentArrayByParti(:,[2,3,4,5]));

strSalida="'GS Nickel','GS Dollar','NGS Nickel','NGS Dollar'";
disp('resultado hipotesis con ttest ');
disp(h);
disp('resultado desviaciones standards '+strSalida);
disp(stats2.sd);

%variable salida
%h sera un 0 o 1 si  la hipotesis es valida
% ci es el importante que entregara la tasa de cada columna con sus limites
% superiores e inferiores de sus medias.

%c=categorical(percentArrayByPartim)
%h=histogram(C,'BarWidth',0.5)

% se utiliza anova analysis 2 ways.
% se le entrega la matriz con las tasas de cada uno de los trials asociados
% del for anterior.


[p_value_anova2,tbl,stats] = anova2(percentArrayByParti(:,[2,3,4,5]));

disp('resultado p-values de anova2 ');
disp(p_value_anova2);

%variables salida
%p con un valor que si es bajo demostrara que el restulado es
%estadisticamente significativo
%tbl entregara  un matriz con la informacion resultante de Anova
%stat tendra informacion de entrada para realizar un test de
%multicomparacion


[c,m] = multcompare(stats);

disp('resultado promedios con multicompare '+strSalida);
disp(transpose(m(:,1)));

% variable salida
% c tendra una matriz de pares resultado de la funcion multicompare
% m tambien es una matriz donde la primera columna es la media estimada de cada
% grupo y la segunda la desviacion standar de error que usa en el grafico
% 2A

%https://stats.stackexchange.com/questions/159973/standard-error-computed-by-matlab-multcompare

%calculo estandar error
SEM=std(percentArrayByParti(:,[2,3,4,5]))/sqrt(length(percentArrayByParti(:,[2,3,4,5])));

disp('resultado error estandar '+strSalida);
disp(SEM);


%graficar
f1=figure;

bar_1=bar(m(:,1));
bar_1.FaceColor = 'flat';

bar_1.CData(1,:) = [0.8500 0.3250 0.0980];
bar_1.CData(2,:) = [0.8500 0.3250 0.0980];

bar_1.CData(3,:) = [0.4940 0.1840 0.5560];
bar_1.CData(4,:) = [0.4940 0.1840 0.5560];
hold on ;
ylabel('Rate (%)');

set(gca,'xticklabel',{'GS Nickel','GS Dollar','NGS Nickel','NGS Dollar'} );

% incluir el resultado de p para saber si los resultados son
% estadisticamente significativos
dim=[.25 .92 .2 0];

if p_value_anova2(1) <= 0.001 
    str=' ** p-value <= .001';
    
else
    str=' ** p-value > .001';
end
t=annotation('textbox',dim,'String',str,'FitBoxToText','off','FontSize',8);


dim=[.55 .92 .2 0];

if p_value_anova2(2) <= 0.001 
    str=' ** p-value <= .001';
else
    str=' ** p-value > .001';
end
t2=annotation('textbox',dim,'String',str,'FitBoxToText','off','FontSize',8);


%graficar los standard error
errhigh=SEM;
errlow=zeros(size(SEM)); 
x = 1:4;

er = errorbar(x,transpose(m(:,1)),errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
%xlim([-3 15]);
ylim([0 110]);
yticks(0:10:100);

hold off



