%%%%%%% Codigo final

% 4 variables con las cateogrías presentadas (1,60) y 4 variables para
% respuestas realizadas por los participantes (67,60).

%Cargar variables.

%CA1, CA2, CA3, CA4
%RR1, RR2, RR3, RR4

%%
% Unir vectores.

%(TCA = TOTAL CATEGORIAS)
TCA = [(CA1), (CA2), (CA3), (CA4)];
%(TRR = TOTAL RESPUESTAS REALIZADAS)
TRR = [(RR1), (RR2), (RR3), (RR4)];
%(RL = TOTAL CATEGORÍAS LÓGICAS)
TCL = TCA;

%convierto matriz de categorías, en vector lógico. CA 1 Y 2 = go, CA3 Y 4=
%no go.
for ik = 1:1:240
    if TCL(ik) <= 2
       TCL(ik) = 1;
    elseif TCL(ik) >= 3
       TCL(ik) = 0;
    end
end

%%

% Comparar y pocentuar.

% Comparo vector lógico con respuestas realizadas.

%(RCOM = RESPUESTAS COMPARADAS)
RCOM = TCL == TRR;
%(PRCOM = PORCENTAJE RESP COMPARADAS)
RRCO = ((sum(RCOM))*100)/67;

%Unir vector con matriz para recorrer,
%(PTC = PORCENTAJE TRIALS CATEGORIA)
PTC = [(TCA); (RRCO)];

% Sumar por categorías para sacar porcentajes totales.
Sum1 = 0;
Sum2 = 0;
Sum3 = 0;
Sum4 = 0;

[f,c] = size(PTC);

for j = 1:c
    for i = 1
        
       if PTC(i,j) == 1
       Sum1 = Sum1 + PTC(:,j);
       
       elseif PTC(i,j) == 2
       Sum2 = Sum2 + PTC(:,j);
      
       elseif PTC (i,j) == 3
      Sum3 = Sum3 + PTC(:,j);
      
       elseif PTC (i,j) == 4
      Sum4 = Sum4 + PTC(:,j);
        end 
    end
end

%Dividir para sacar porcentajes totales por categoría.
%(PCN = PORCENTAJE CATEGORIA N)

PC1 = (Sum1(2,1))./(Sum1(1,1));
PC2 = (Sum2(2,1))./((Sum2(1,1))/2);
PC3 = (Sum3(2,1))./((Sum3(1,1))/3);
PC4 = (Sum4(2,1))./((Sum4(1,1))/4);

%Vector de porcentajes totales por categoría
%(VPTC = VECTOR PORCENT TOTAL POR CATEGORÍA)
 VPTC= [(PC1),(PC2),(PC3),(PC4)]

%%
%Calculos estadísticos y gráficos

%Calcular anova


%calcular error bar ????
% hacer ttest ????

%Graficar

x = categorical({'GD', 'GN', 'NGD', 'NGN'}) 
 
BAR1 = bar(x, VPTC, 'k')

ylabel({'% aciertos'});

xlabel({'categorías'});

title({'Porcentaje de aciertos por categoría'});

