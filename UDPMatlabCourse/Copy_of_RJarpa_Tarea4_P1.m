% calculos con las matrices

% segun el diagrama de flujo almacene los datos en 6 matrices 
% ENTRADAS
% participanteArray contiene los identificadores (Numero) de cada participante
% rewardArray contiene los premios de cada participante  
%       columnas (Numero participante,  Es reward por Nickel ?, es GO? )
%   
% lostArray contiene los errores de cada participante
%       columnas (Numero participante,  Es reward por Nickel ?, es GO? )
% GSNikelArray contienene los errores de 
%        columnas (Numero de participante, un numero 1)
% GSDollarArray contienene los errores de 
%        columnas (Numero de participante, un numero 1)
% NGSNickelArray contienene los errores de 
%        columnas (Numero de participante, un numero 1)
% NGSDollarArray contienene los errores de 
%        columnas (Numero de participante, un numero 1)

%
    load('D:\OneDrive\MATLAB\Tarea4\datTarea4_P1.mat')
    

totalparticipantes  = length(participantArray)
    
%    rewardArray = []
%    lostArray = []
%    GSNickelArray =[]
%    GSDollarArray  =  []
%    NGSNickelArray = []
%    NGSDollarArray = []
    
% Utilizando la funcion size para obtener las dimensiones de la matriz

    [rowsLost,colsLost] = size(lostArray)
    
%   Inicializar los contadores de perdidas
    contlostGSNickel=0
    contlostGSDollar =0
    contlostNGSNickel =0
    contlostNGSDollar =0
    
%   Se va a recorrer solo la matriz de perdida para acumular los contadores
%   de cada tipo de perdidad
    for i = 1: 1: rowsLost
        
        % es Nickel? es Go?
        if lostArray(i,2) == 1 &&  lostArray(i,3) == 1
             contlostGSNickel=contlostGSNickel+1;
             
        % es Dollar? es Go?
        elseif lostArray(i,2) == 0 &&  lostArray(i,3) == 1
            contlostGSDollar=contlostGSDollar+1;
            
        % es Nickel? es noGo?
        elseif lostArray(i,2) == 1 &&  lostArray(i,3) == 0
            contlostNGSNickel=contlostNGSNickel+1;
            
        % es Dollar? es noGo?
        elseif lostArray(i,2) == 0 &&  lostArray(i,3) == 0
            contlostNGSDollar=contlostNGSDollar+1;
        end
        
    end
    
   
%   Se utiliza la funcion suma para obtener la acumulacion de todos los
%   numeros 1 de cada respuesta correcta por tipo de moneda (estan en
%   matrices distintas registradas)
    contrewardGSNickel = sum(GSNickelArray(:,2));
    contrewardGSDollar = sum(GSDollarArray(:,2));
    contrewardNGSNickel = sum(NGSNickelArray(:,2));
    contrewardNGSDollar = sum(NGSDollarArray(:,2));
    
% Se obtiene el % de acierto de cada tipo (GS vs. NGS ?? dollar vs. nickel)
    percenGSNickel = (contrewardGSNickel/(contrewardGSNickel+contlostGSNickel))*100
    percenGSDollar = (contrewardGSDollar/(contrewardGSDollar+contlostGSDollar))*100
    percenNGSNickel = (contrewardNGSNickel/(contrewardNGSNickel+contlostNGSNickel))*100
    percenNGSDollar = (contrewardNGSDollar/(contrewardNGSDollar+contlostNGSDollar))*100

% por cada  usuario  se almacena el porcentage en la matriz se utiliza la
% funcion lenght para obtener el largo de participantes



% ciclo para almacenar los valores de 
% la estructura de las cabeceras del arreglo es (GSNickel,GSDollar,NGSNickel,NGSDollar)
percentArrayByParti=[]

for i = 1:1:totalparticipantes
    
    percentArrayByParti(i,2)= percenGSNickel;
    percentArrayByParti(i,3)= percenGSDollar;
    percentArrayByParti(i,4)= percenNGSNickel;
    percentArrayByParti(i,5)= percenNGSDollar;
    
    
    
end


%graficar
f1=figure;
%x_labels = ['GS Nickel' 'GS Dollar' 'NGS Nickel' 'NGS Dollar'];

bar_1=bar(percentArrayByParti(:,[2,3,4,5]))
set(gca,'xticklabel',{'GS Nickel','GS Dollar','NGS Nickel','NGS Dollar'} )


%c=categorical(percentArrayByPartim)
%h=histogram(C,'BarWidth',0.5)

% se utiliza anova analysis 2 ways.
% se le entrega la matriz con las tasas de cada uno de los trials asociados
% del for anterior.



[p,tbl,stats] = anova2(percentArrayByParti);

%variables salida
%p con un valor que si es bajo demostrara que el restulado es
%estadisticamente significativo
%tbl entregara  un matriz con la informacion resultante de Anova
%stat tendra informacion de entrada para realizar un test de
%multicomparacion
[c,m] = multcompare(stats)

% variable salida
% c tendra una matriz de pares resultado de la funcion multicompare 
% m tambien es una matriz donde la primera columna es la media estimada de cada
% grupo y la segunda la desviacion standar de error que usa en el grafico
% 2A

% para analisis post hoc 
% se utiliza la funcion ttest para comparar las 4 variables
% se crea una matriz para 

[h,p,ci,stats] = ttest(percentArrayByParti)


%variable salida
%h sera un 0 o 1 si  la hipotesis es valida
% ci es el importante que entregara la tasa de cada columna con sus limites
% superiores e inferiores de sus medias.


















% graficar la informacion






