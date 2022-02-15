%%%%%%%%%%%%%%%%% CODIGO FINAL

%Cargar variables:
% Variables de categorías presentadas: CA1, CA2, CA3, CA4.
% Variables de respuestas participantes: RR1, RR2, RR3, RR4.

CA1 = randi(4,1,60);
CA2 = randi(4,1,60);
CA3 = randi(4,1,60);
CA4 = randi(4,1,60);

RR1 = randi(0:1,67,60);
RR2 = randi(0:1,67,60);
RR3 = randi(0:1,67,60);
RR4 = randi(0:1,67,60);

return
%%
%%%%%%%%%%%%%%%%%%%%%%% SES1

CAM4 = CA1;

%Convierto vector de categorías, en vector lógico. 1 Y 2 = go, 3 Y 4=
%no go.

for ik = 1:1:70
    if CAM4(ik) <= 2
       CAM4(ik) = 1;
    elseif CAM4(ik) >= 3
       CAM4(ik) = 0;
    end
end

%Comparar y porcentuar.

RCOM4 = CAM4 == RR1;
PRCOM4 = ((sum(RCOM4))*100)/67;

%Unir vector con matriz para recorrer,

PTC4 = [(CA1); (PRCOM4)];

% Sumar por categorías para sacar porcentajes totales.
SCA14 = 0;
SCA24 = 0;
SCA34 = 0;
SCA44 = 0;

[f,c] = size(PTC4);

for j = 1:c
    for i = 1
        
       if PTC4(i,j) == 1
       SCA14 = SCA14 + PTC4(:,j);
       
       elseif PTC4(i,j) == 2
       SCA24 = SCA24 + PTC4(:,j);
      
       elseif PTC4 (i,j) == 3
      SCA34 = SCA34 + PTC4(:,j);
      
       elseif PTC4 (i,j) == 4
      SCA44 = SCA44 + PTC4(:,j);
        end 
    end
end

%Dividir para sacar porcentajes totales por categoría.
%(PCN = PORCENTAJE CATEGORIA N)

PC14 = (SCA14(2,1))./(SCA14(1,1));
PC24 = (SCA24(2,1))./((SCA24(1,1))/2);
PC34 = (SCA34(2,1))./((SCA34(1,1))/3);
PC44 = (SCA44(2,1))./((SCA44(1,1))/4);

PSES1 = [(PC14), (PC24), (PC34), (PC44)];

%%

%%%%%%%%%%%%%%%%%%%%%%% SES2

CAM4 = CA2;

%Convierto vector de categorías, en vector lógico. 1 Y 2 = go, 3 Y 4=
%no go.

for ik = 1:1:70
    if CAM4(ik) <= 2
       CAM4(ik) = 1;
    elseif CAM4(ik) >= 3
       CAM4(ik) = 0;
    end
end

%Comparar y porcentuar.

RCOM4 = CAM4 == RR2;
PRCOM4 = ((sum(RCOM4))*100)/67;

%Unir vector con matriz para recorrer,

PTC4 = [(CA2); (PRCOM4)];

% Sumar por categorías para sacar porcentajes totales.
SCA14 = 0;
SCA24 = 0;
SCA34 = 0;
SCA44 = 0;

[f,c] = size(PTC4);

for j = 1:c
    for i = 1
        
       if PTC4(i,j) == 1
       SCA14 = SCA14 + PTC4(:,j);
       
       elseif PTC4(i,j) == 2
       SCA24 = SCA24 + PTC4(:,j);
      
       elseif PTC4 (i,j) == 3
      SCA34 = SCA34 + PTC4(:,j);
      
       elseif PTC4 (i,j) == 4
      SCA44 = SCA44 + PTC4(:,j);
        end 
    end
end

%Dividir para sacar porcentajes totales por categoría.
%(PCN = PORCENTAJE CATEGORIA N)

PC14 = (SCA14(2,1))./(SCA14(1,1));
PC24 = (SCA24(2,1))./((SCA24(1,1))/2);
PC34 = (SCA34(2,1))./((SCA34(1,1))/3);
PC44 = (SCA44(2,1))./((SCA44(1,1))/4);

PSES2 = [(PC14), (PC24), (PC34), (PC44)];

%%

%%%%%%%%%%%%%%%%%%%%%%% SES3

CAM4 = CA3;

%Convierto vector de categorías, en vector lógico. 1 Y 2 = go, 3 Y 4=
%no go.

for ik = 1:1:70
    if CAM4(ik) <= 2
       CAM4(ik) = 1;
    elseif CAM4(ik) >= 3
       CAM4(ik) = 0;
    end
end

%Comparar y porcentuar.

RCOM4 = CAM4 == RR3;
PRCOM4 = ((sum(RCOM4))*100)/67;

%Unir vector con matriz para recorrer,

PTC4 = [(CA3); (PRCOM4)];

% Sumar por categorías para sacar porcentajes totales.
SCA14 = 0;
SCA24 = 0;
SCA34 = 0;
SCA44 = 0;

[f,c] = size(PTC4);

for j = 1:c
    for i = 1
        
       if PTC4(i,j) == 1
       SCA14 = SCA14 + PTC4(:,j);
       
       elseif PTC4(i,j) == 2
       SCA24 = SCA24 + PTC4(:,j);
      
       elseif PTC4 (i,j) == 3
      SCA34 = SCA34 + PTC4(:,j);
      
       elseif PTC4 (i,j) == 4
      SCA44 = SCA44 + PTC4(:,j);
        end 
    end
end

%Dividir para sacar porcentajes totales por categoría.
%(PCN = PORCENTAJE CATEGORIA N)

PC14 = (SCA14(2,1))./(SCA14(1,1));
PC24 = (SCA24(2,1))./((SCA24(1,1))/2);
PC34 = (SCA34(2,1))./((SCA34(1,1))/3);
PC44 = (SCA44(2,1))./((SCA44(1,1))/4);

PSES3 = [(PC14), (PC24), (PC34), (PC44)];

%%

%%%%%%%%%%%%%%%%%%%%%%% SES4

CAM4 = CA4;

%Convierto vector de categorías, en vector lógico. 1 Y 2 = go, 3 Y 4=
%no go.

for ik = 1:1:70
    if CAM4(ik) <= 2
       CAM4(ik) = 1;
    elseif CAM4(ik) >= 3
       CAM4(ik) = 0;
    end
end

%Comparar y porcentuar.

RCOM4 = CAM4 == RR4;
PRCOM4 = ((sum(RCOM4))*100)/67;

%Unir vector con matriz para recorrer,

PTC4 = [(CA4); (PRCOM4)];

% Sumar por categorías para sacar porcentajes totales.
SCA14 = 0;
SCA24 = 0;
SCA34 = 0;
SCA44 = 0;

[f,c] = size(PTC4);

for j = 1:c
    for i = 1
        
       if PTC4(i,j) == 1
       SCA14 = SCA14 + PTC4(:,j);
       
       elseif PTC4(i,j) == 2
       SCA24 = SCA24 + PTC4(:,j);
      
       elseif PTC4 (i,j) == 3
      SCA34 = SCA34 + PTC4(:,j);
      
       elseif PTC4 (i,j) == 4
      SCA44 = SCA44 + PTC4(:,j);
        end 
    end
end

%Dividir para sacar porcentajes totales por categoría.
%(PCN = PORCENTAJE CATEGORIA N)

PC14 = (SCA14(2,1))./(SCA14(1,1));
PC24 = (SCA24(2,1))./((SCA24(1,1))/2);
PC34 = (SCA34(2,1))./((SCA34(1,1))/3);
PC44 = (SCA44(2,1))./((SCA44(1,1))/4);

PSES4 = [(PC14), (PC24), (PC34), (PC44)];

%%

PORTOT = [(PSES1); (PSES2); (PSES3); (PSES4)]

%Cálculos estadísticos y grafico.

% [p, tbl, stats] = anova1(PORTOT)
% [h,p,ci,stats] = ttest2(PORTOT)

% Gráfico

graf1 = (sum(PORTOT))/4

x = categorical({'GD', 'GN', 'NGD', 'NGN'}) 
 
BAR1 = bar(x, graf1, 'k')

ylabel({'% aciertos'});

xlabel({'categorías'});

title({'Porcentaje de aciertos por categoría'});