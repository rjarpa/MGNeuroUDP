%PROCESO GRÁFICO 1

GSN = randi([40 70],15,67);
GSD = randi([70 85],15,67);
NGSN = randi([85 100],15,67);
NGSD = randi([80 95],15,67);

GS= [GSN,GSD];
NGS=[NGSN,NGSD];

%Parrafo 1 .Calculo de promedio y ds de Go_exito_niquel
%Columnas (promedio de cada participante)
Prom_GSN= mean(GSN);
PROM_GSN=Prom_GSN.'; % Promedio en Columna
%filas(promedio total de la muestra)
Tprom_GSN= mean(PROM_GSN);
%Columnas (ds de cada participante)
DE_GSN = std(GSN);
de_gsn=DE_GSN.';
%filas(ds total de la muestra)
TDE_GSN= std(de_gsn);

%Siguen el mismo orden de frase anterior, pero este es Go_exito_dolar
Prom_GSD= mean(GSD);
PROM_GSD = Prom_GSD.'; % Promedio en Columna
TPROM_GSD= mean(PROM_GSD);
DE_GSD=std(GSD);
de_gsd=DE_GSD.';
TDE_GSD = std(de_gsd);

%Calculo de promedio y ds de NO_Go_exito_niquel
%Siguen estructura parrafo 1
Prom_NGSN= mean(NGSN);
PROM_NGSN=Prom_NGSN.'; % Promedio en Columna
Tprom_NGSN = mean(PROM_NGSN);
DE_NGSN=std(NGSN);
de_ngsn=DE_NGSN.';
TDE_NGSN = std(de_ngsn);

%Calculo de promedio y ds de NO_Go_exito_dolar
Prom_NGSD= mean(NGSD);
PROM_NGSD=Prom_NGSD'; % Promedio en Columna
Tprom_NGSD = mean(PROM_NGSD);
DE_NGSD=std(NGSD);
de_ngsn=DE_NGSD.';
TDE_NGSD = std(DE_NGSD);

disp('Promedio y Desviación estandar total GSN')
disp(Tprom_GSN)
disp(TDE_GSN)
disp('Promedio y Desviación estandar total GSD')
disp(TPROM_GSD)
disp(TDE_GSD)
disp('Promedio y Desviación estandar total NGSN')
disp(Tprom_NGSN)
disp(TDE_NGSN)
disp('Promedio y Desviación estandar total NGSD')
disp(Tprom_NGSD)
disp(TDE_NGSD)

%Display anova  se muestra en tabla . Calculo anova de
%Prueba Go exitosa entre niquel y dolar
%pGS = anova2(GS,15)
%pGS=anova2(GSN,GSD,15)



%Prueba No_Go exitosa entre niquel y dolar
%pGNS = anova2(NGS,15)

%Tabla con lo promedios por sujeto
porceParti = [PROM_GSN, PROM_GSD, PROM_NGSN, PROM_NGSD];

% Calculo de anova
[pnova,tbl,stats] = anova2(porceParti);

[pnova2,tbl2,stats2] = anova2([PROM_GSN, PROM_GSD]);
[pnova3,tbl3,stats3] = anova2([PROM_NGSN, PROM_NGSD]);

% standar error
errorestandar= std(porceParti)/sqrt(length(porceParti));


%Grafico figura 2a 
figure
c = categorical({'GSN','GSD'});
PROM = [Tprom_GSN TPROM_GSD ];
bar(c,PROM, 0.7, 'k');
hold;
c = categorical({'NGSN','NGSD'});
PROM = [Tprom_NGSN Tprom_NGSD];
bar(c,PROM, 0.7, 'w');
title('A');
ylabel('Rate (%)');

return


% %PROCESO GRAFICO 2b. TIEMPO DE REACCIÓN
 GSN_RT = randi([350 380],15,67);
 GSD_RT = randi([345 355],15,67);
 NGEN_RT = randi([400 430],15,67);
 NGED_RT = randi([350 370],15,67);
 
GS_RT= [GSN_RT,GSD_RT];
NGE_RT=[NGEN_RT,NGED_RT];

%calculo tiempo reaccion GSN
Prom_GSN_RT= mean(GSN_RT);
IProm_GSN_RT=Prom_GSN_RT.';
TProm_GSN_RT=mean(IProm_GSN_RT);
DE_GSN_RT=std(GSN_RT);
IDE_GSN_RT= DE_GSN_RT.';
TDE_GSN_RT=std(IDE_GSN_RT);

%calculo tiempo reaccion GSD
Prom_GSD_RT= mean(GSD_RT);
IProm_GSD_RT=Prom_GSD_RT.';
TProm_GSD_RT=mean(IProm_GSD_RT);
DE_GSD_RT=std(GSD_RT);
IDE_GSD_RT=DE_GSD_RT.';
TDE_GSD_RT=IDE_GSD_RT;

%calculo tiempo reaccion NO GO erroneo niquel
Prom_NGEN_RT= mean(NGEN_RT);
IProm_NGEN_RT= Prom_NGEN_RT.';
TProm_NGEN_RT=mean(Prom_NGEN_RT);
DE_NGEN_RT=std(NGEN_RT);
IDE_NGEN_RT=DE_NGEN_RT.';
TDE_NGEN_RT=std(IDE_NGEN_RT);

%calculo tiempo reaccion NO GO erroneo dolar
Prom_NGED_RT= mean(NGED_RT);
IProm_NGED_RT=Prom_NGED_RT.';
TProm_NGED_RT=mean(IProm_NGED_RT);
DE_NGED_RT=std(NGED_RT);
IDE_NGED_RT=DE_NGED_RT.';
TDE_NGED_RT=std(IDE_NGED_RT);

disp('Promedio y Desviación estandar total tiempo de reacción GSN ')
disp(TProm_GSN_RT)
disp(TDE_GSN_RT)
disp('Promedio y Desviación estandar total tiempo de reacción GSD')
disp(TProm_GSD_RT)
disp(TDE_GSD_RT)
disp('Promedio y Desviación estandar total tiempo de reacción NGSN')
disp(TProm_NGEN_RT)
disp(TDE_NGEN_RT)
disp('Promedio y Desviación estandar total tiempo de reacción NGSD')
disp(TProm_NGED_RT)
disp(TDE_NGED_RT)

% Display de anova se muestra en tabla
[p,tbl] = anova2(GS_RT,15);
[p,tbl] = anova2(NGE_RT,15);

 %grafico figura 2b
figure
c = categorical({'GSN','GSD'});
PROM = [TProm_GSN_RT TProm_GSD_RT];
bar(c,PROM, 0.7, 'k')
hold
c = categorical({'NGEN','NGED'});
PROM2 = [ TProm_NGEN_RT TProm_NGED_RT];
bar(c,PROM2, 0.7, 'w')
hold
title('B')
ylabel('Rate (ms)')


% 
% 
