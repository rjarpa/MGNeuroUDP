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


%% Creacion de Data

partN=67;
participantArray=[1:partN];

% Numero de trials
trialsN=15;

%initizalizando los arreglos
rewardArray=[];
lostArray=[];
GSDollarArray=[];
GSNickelArray=[];
NGSDollarArray=[];
NGSNickelArray=[];

%inicializacion contadores
contGSDollarArray=1;
contGSNickelArray=1;
contNGSDollarArray=1;
contNGSNickelArray=1;
contlostArray=1;
contrewardArray=1;


for xx = 1:1:partN %ciclo por el total de participantes
    trialType=rand(trialsN);
    [rowsTrialType,colTrialType]=size(trialType);
    for ii = 1:1:colTrialType %ciclo por el total de trials
        DollarOrNickel=rand(1);
        responsepart=rand(1);
    
        if trialType(ii)<=.66 && DollarOrNickel <= 0.5     % GoDollar
            
           
            if responsepart>0.5  %sucess
                rewardArray(contrewardArray,1)=xx;
                rewardArray(contrewardArray,2)=0;
                rewardArray(contrewardArray,3)=1;
                GSDollarArray(contGSDollarArray,1)= xx;
                GSDollarArray(contGSDollarArray,2)= 1;
                contGSDollarArray= contGSDollarArray+1;
                contrewardArray= contrewardArray+1;
                
            else %fail
                lostArray(contlostArray,1)=xx;
                lostArray(contlostArray,2)=0;
                lostArray(contlostArray,3)=1;
                
                contlostArray= contlostArray+1;
            end
            
           
        elseif trialType(ii)<=0.66 && DollarOrNickel>0.5 % Go Nickel
           
            if responsepart>0.5 %sucess
                rewardArray(contrewardArray,1)=xx;
                rewardArray(contrewardArray,2)=1;
                rewardArray(contrewardArray,3)=1;
                GSNickelArray(contGSNickelArray,1)=xx;
                GSNickelArray(contGSNickelArray,2)=1;
                contGSNickelArray= contGSNickelArray+1;
                contrewardArray= contrewardArray+1;
                
            else
                lostArray(contlostArray,1)=xx; %fail
                lostArray(contlostArray,2)=1;
                lostArray(contlostArray,3)=1;
                
                contlostArray= contlostArray+1;
            end
            
        elseif trialType(ii)>0.66 && DollarOrNickel<=0.5 % NoGo Dollar
            
            if responsepart>0.5 % success
                rewardArray(contrewardArray,1)=xx;
                rewardArray(contrewardArray,2)=0;
                rewardArray(contrewardArray,3)=0;
                NGSDollarArray(contNGSDollarArray,1)=xx;
                NGSDollarArray(contNGSDollarArray,2)=1;
                contNGSDollarArray= contNGSDollarArray+1;
                contrewardArray= contrewardArray+1;
                
            else %fail
                lostArray(contlostArray,1)=xx;
                lostArray(contlostArray,2)=0;
                lostArray(contlostArray,3)=0;
                
                contlostArray= contlostArray+1;
            end
            
           
        elseif trialType(ii)>0.66 && DollarOrNickel>0.5  % NoGo Nickel
            if responsepart>0.5 % success
                rewardArray(contrewardArray,1)=xx;
                rewardArray(contrewardArray,2)=1;
                rewardArray(contrewardArray,3)=0;
                NGSNickelArray(contNGSNickelArray,1)=xx;
                NGSNickelArray(contNGSNickelArray,2)=1;
                contNGSNickelArray= contNGSNickelArray+1;
                contrewardArray= contrewardArray+1;
            else %fail
                lostArray(contlostArray,1)=xx;
                lostArray(contlostArray,2)=1;
                lostArray(contlostArray,3)=0;
                contlostArray= contlostArray+1;
                
            end
        end
        
        
    end
end


%% Calculos 


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

%used to Proof real paper data
%percentArrayByParti=testActualData;

% para analisis post hoc
% se utiliza la funcion ttest para comparar las 4 variables
% se crea una matriz para

disp("ttest");
[h,p,ci,stats2] = ttest(percentArrayByParti(:,[2,3,4,5]));

%variable salida
%h sera un 0 o 1 si  la hipotesis es valida
% ci es el importante que entregara la tasa de cada columna con sus limites
% superiores e inferiores de sus medias.

%c=categorical(percentArrayByPartim)
%h=histogram(C,'BarWidth',0.5)

% se utiliza anova analysis 2 ways.
% se le entrega la matriz con las tasas de cada uno de los trials asociados
% del for anterior.

disp("anova");
[p_value_anova2,tbl,stats] = anova2(percentArrayByParti(:,[2,3,4,5]));

%variables salida
%p con un valor que si es bajo demostrara que el restulado es
%estadisticamente significativo
%tbl entregara  un matriz con la informacion resultante de Anova
%stat tendra informacion de entrada para realizar un test de
%multicomparacion

disp("multcompare");
[c,m] = multcompare(stats);

% variable salida
% c tendra una matriz de pares resultado de la funcion multicompare
% m tambien es una matriz donde la primera columna es la media estimada de cada
% grupo y la segunda la desviacion standar de error que usa en el grafico
% 2A

%https://stats.stackexchange.com/questions/159973/standard-error-computed-by-matlab-multcompare

%estandar error
SEM=std(percentArrayByParti(:,[2,3,4,5]))/sqrt(length(percentArrayByParti(:,[2,3,4,5])));

%graficar
f1=figure;

bar_1=bar(m(:,1))
bar_1.FaceColor = 'flat';

bar_1.CData(1,:) = [0.8500 0.3250 0.0980];
bar_1.CData(2,:) = [0.8500 0.3250 0.0980];

bar_1.CData(3,:) = [0.4940 0.1840 0.5560];
bar_1.CData(4,:) = [0.4940 0.1840 0.5560];
hold on ;
ylabel('Rate (%)');

set(gca,'xticklabel',{'GS Nickel','GS Dollar','NGS Nickel','NGS Dollar'} );


%form [x y w h]

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


%errlow=abs(transpose(m(:,1))-ci(1,:));
%errhigh=abs(transpose(m(:,1))-ci(2,:));
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






