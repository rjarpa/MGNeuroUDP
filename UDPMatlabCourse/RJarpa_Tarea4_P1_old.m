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

percentArrayByParti=[]

for jj=1:1:totalparticipantes
    
    %    rewardArray = []
    %    lostArray = []
    %    GSNickelArray =[]
    %    GSDollarArray  =  []
    %    NGSNickelArray = []
    %    NGSDollarArray = []
    
    % Utilizando la funcion size para obtener las dimensiones de la matriz
    
    indxLost   = lostArray(:,1)==jj;
    auxArraylost = lostArray(indxLost,:)
    
    
    [rowsLost,colsLost] = size(auxArraylost)
    
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
    percenGSNickel = (contrewardGSNickel/(contrewardGSNickel+contlostGSNickel))*100
    percenGSDollar = (contrewardGSDollar/(contrewardGSDollar+contlostGSDollar))*100
    percenNGSNickel = (contrewardNGSNickel/(contrewardNGSNickel+contlostNGSNickel))*100
    percenNGSDollar = (contrewardNGSDollar/(contrewardNGSDollar+contlostNGSDollar))*100
    
    
    fixNan=[percenGSNickel percenGSDollar percenNGSNickel percenNGSDollar]
    promNoNan=mean(fixNan(~isnan(fixNan)))
    
    
    
    if isnan(percenGSNickel) == true
        percenGSNickel= promNoNan
        
    end
    
    if isnan(percenGSDollar) == true
        percenGSDollar= promNoNan
    end
    
    if isnan(percenNGSNickel) == true
        percenNGSNickel= promNoNan
    end
    
    if isnan(percenNGSDollar) == true
        percenNGSDollar= promNoNan
    end
    

    
    
    % por cada  usuario  se almacena el porcentage en la matriz se utiliza la
    % funcion lenght para obtener el largo de participantes
    
    
    
    % ciclo para almacenar los valores de
    % la estructura de las cabeceras del arreglo es (GSNickel,GSDollar,NGSNickel,NGSDollar)

    
    
    percentArrayByParti(jj,1)= jj;
    percentArrayByParti(jj,2)= percenGSNickel;
    percentArrayByParti(jj,3)= percenGSDollar;
    percentArrayByParti(jj,4)= percenNGSNickel;
    percentArrayByParti(jj,5)= percenNGSDollar;
    
    
    
    
    
    
end

percentArrayByParti=testActualData;
totalArray = [mean(percentArrayByParti(:,2)), mean(percentArrayByParti(:,3)),mean(percentArrayByParti(:,4)),mean(percentArrayByParti(:,5))]
%totalArray = [mean(percentArrayByParti(:,2)), mean(percentArrayByParti(:,3)),mean(percentArrayByParti(:,4)),mean(percentArrayByParti(:,5))]



%graficar
f1=figure;
%x_labels = ['GS Nickel' 'GS Dollar' 'NGS Nickel' 'NGS Dollar'];
%percentArrayByParti(:,[2,3,4,5])

bar_1=bar(totalArray)
hold on 
set(gca,'xticklabel',{'GS Nickel','GS Dollar','NGS Nickel','NGS Dollar'} )

% para analisis post hoc
% se utiliza la funcion ttest para comparar las 4 variables
% se crea una matriz para

disp("ttest")
[h,p,ci,stats2] = ttest(percentArrayByParti(:,[2,3,4,5]))

x = 1:4;
er = errorbar(x,totalArray,ci(1,:),ci(2,:));    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off
%variable salida
%h sera un 0 o 1 si  la hipotesis es valida
% ci es el importante que entregara la tasa de cada columna con sus limites
% superiores e inferiores de sus medias.

%c=categorical(percentArrayByPartim)
%h=histogram(C,'BarWidth',0.5)

% se utiliza anova analysis 2 ways.
% se le entrega la matriz con las tasas de cada uno de los trials asociados
% del for anterior.


disp("anova")

[p,tbl,stats] = anova2(percentArrayByParti(:,[2,3,4,5]),1);




%intentar a nova
anovaGSNickelArra= percentArrayByParti(:,2)
anovaGSDollarArra= percentArrayByParti(:,3)
anovaNGSNickelArra= percentArrayByParti(:,4)
anovaNGSDollarArra= percentArrayByParti(:,5)
X=table(anovaGSNickelArra,anovaGSDollarArra,anovaNGSNickelArra,anovaNGSDollarArra)
mdl = fitlm(X)
tbl_1 = anova(mdl);
standard=std(percentArrayByParti(:,2))

%variables salida
%p con un valor que si es bajo demostrara que el restulado es
%estadisticamente significativo
%tbl entregara  un matriz con la informacion resultante de Anova
%stat tendra informacion de entrada para realizar un test de
%multicomparacion

disp("multcompare")
[c,m] = multcompare(stats)

% variable salida
% c tendra una matriz de pares resultado de la funcion multicompare
% m tambien es una matriz donde la primera columna es la media estimada de cada
% grupo y la segunda la desviacion standar de error que usa en el grafico
% 2A














%intentar a nova
anovaGSNickelArra= percentArrayByParti(:,2)
anovaGSDollarArra= percentArrayByParti(:,3)
anovaNGSNickelArra= percentArrayByParti(:,4)
anovaNGSDollarArra= percentArrayByParti(:,5)
X=table(anovaGSNickelArra,anovaGSDollarArra,anovaNGSNickelArra,anovaNGSDollarArra)
mdl = fitlm(X)
tbl_1 = anova(mdl);





% graficar la informacion







