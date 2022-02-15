% Carga de los datos
load('RJarpa_datAP3P1.mat')
%% Calculo de datos
totalparticipantes  = length(participantArray);
percentArrayByParti=[];
for jj=1:1:totalparticipantes
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
        if auxArraylost(i,2) == 1 &&  auxArraylost(i,3) == 1 % es Nickel? es Go?
            contlostGSNickel=contlostGSNickel+1;
        elseif auxArraylost(i,2) == 0 &&  auxArraylost(i,3) == 1 % es Dollar? es Go?
            contlostGSDollar=contlostGSDollar+1;
        elseif auxArraylost(i,2) == 1 &&  auxArraylost(i,3) == 0 % es Nickel? es noGo?
            contlostNGSNickel=contlostNGSNickel+1;
        elseif auxArraylost(i,2) == 0 &&  auxArraylost(i,3) == 0 % es Dollar? es noGo?
            contlostNGSDollar=contlostNGSDollar+1;
        end
    end
    
    %   Se utiliza la funcion suma para obtener la acumulacion de todos los
    %   numeros 1 de cada respuesta correcta por tipo de moneda (estan en
    %   matrices distintas registradas)
    indxReward   = GSNickelArray(:,1)==jj;
    auxArrayReward = GSNickelArray(indxReward,:);
    contrewardGSNickel = sum(auxArrayReward(:,2));
    % Se obtiene el % de acierto de cada tipo (GS vs. NGS × dollar vs. nickel)
    percenGSNickel = (contrewardGSNickel/(contrewardGSNickel+contlostGSNickel))*100;
    % por cada  usuario  se almacena el porcentaje en la matriz se utiliza la
    percentArrayByParti(jj,1)= jj;
    percentArrayByParti(jj,2)= percenGSNickel;
    
end
promGSNickel=mean(percentArrayByParti(:,2),'omitnan');
for xx=1:1:totalparticipantes
    if isnan(percentArrayByParti(xx,2))
        percentArrayByParti(xx,2)=promGSNickel;
    end
end
strSalida="'GS Nickel','GS Dollar','NGS Nickel','NGS Dollar'";
% se utiliza anova analysis 2 ways.
% se le entrega la matriz con las tasas de cada uno de los trials asociados
% del for anterior.
[p_value_anova2,tbl,stats] = anova2(percentArrayByParti(:,[2,3,4,5]));
%variables salida
%p_value_anova2 con un valor que si es bajo demostrara que el restulado es
%estadisticamente significativo
%tbl entregara  un matriz con la informacion resultante de Anova
%stat tendra informacion de entrada para realizar un test de multicomparacion
[c,m] = multcompare(stats);
% variable salida
% c tendra las medias y m calculo estandar error
SEM=std(percentArrayByParti(:,[2,3,4,5]))/sqrt(length(percentArrayByParti(:,[2,3,4,5])));
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
%graficar los standard error
errhigh=SEM;
errlow=zeros(size(SEM));
x = 1:4;
er = errorbar(x,transpose(m(:,1)),errlow,errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';
ylim([0 110]);
yticks(0:10:100);

hold off

