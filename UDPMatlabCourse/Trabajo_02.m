%% 4a.	Defina dos hipótesis diferentes con respecto al funcionamiento del dado y tradúzcalas a parámetros específicos de una distribución de probabilidad relevante. [1p]

%cantidad de intentos
n=25;
%arreglo con cada valor de X
X1=0:n;
X2=0:n;

%probabilidad de dado normal 3 pares posible de 6 = 3/6 = 1/2
P1 = 0.5;
%probabilidad que el dado tuviese 4 numeros pares 6 = 4/6 = 2/3
P2 = 0.66;

%evaluar la probabilidad binominal  para cada posible valor de la variable aleatoria
D1 = binopdf(X1,n,P1);
D2 = binopdf(X2,n,P2);


%% 4b.	Grafique ambas distribuciones en un mismo gráfico. [1p]

figure("Name", "4b."),
bar(X1,D1,'DisplayName','Dist 3 Pares en el Dado');
hold on;
bar(X2,D2,'DisplayName','Dist 4 Pares en el Dado');
xlabel("Cantidad de Pares");
ylabel("Probabilidad");
hold off;
lgd1 = legend;
%%	4c. Calcule la probabilidad P(X=15|Bino_(n,p) ) de obtener el valor X=15 en su variable, como función del parámetro p. Para ello, elija un conjunto de valores de p y calcule en cada caso la probabilidad requerida. [1p]

%conjunto de valores de p
p = [0.1, 0.2 , 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];
%valor variable aleatoria X=15
X=15;
probvalores_p=[];
for ii=1:numel(p)
    %evaluar la probabilidad binominal de la variable aleatoria X=15
    probvalores_p(ii)=binopdf(X,n,p(ii));
end



%%	4d. Presente los resultados de la pregunta c en un gráfico P(X=15|Bino_(n,p) ) versus p. [1p]

figure("Name","4d");
bar(p,probvalores_p,'DisplayName','Dist Probabilidad de X=15');
hold on;
xlabel("Valores de p");
ylabel("Probabilidad");
hold off;
lgd1 = legend;;

%% 5a.	Defina una variable aleatoria X que: se distribuya de manera uniforme, sea simulable en código Matlab y sea diferente a las analizadas en clases, [1p]

%X: posibilidad de obtener  un AS de una baraja de 52 cartas inglesa sin los
%comodines con reposicion asumiendo el AS como numero 13 - Jack -10 Reina-11  Rey-12 .
%referencia baraja inglesa https://es.wikipedia.org/wiki/Baraja_inglesa#/media/Archivo:Set_of_playing_cards_52.JPG


%valores posibles
val_posibles=13;

%resultados posibles del evento
resultado_posibles_de_X=4;

%total de elementos
total_resultados_posibles=52;

%probabilidad asociada equiprobable
p=resultado_posibles_de_X/total_resultados_posibles;

%arreglo con cada valor de X
X5=1:val_posibles;

%% 5b.	Calcule el valor esperado E[X] y la varianza E[〖(X-μ)〗^2]. [1p]

%valor_esperado
valor_esperado=sum(X5*p);
disp("valor_esperado:" + valor_esperado);
%varianza E[〖(X-μ)〗^2]
EXArray=power((X5-valor_esperado),2);
Varianza = sum(EXArray)/val_posibles;
disp("Varianza:" + Varianza);
%% 5c. Produzca un conjunto de N valores de la variable (N≥500), y construya la distribución de probabilidad “empírica” de la variable a partir de estos N valores. [2p]

% dimension del conjunto
n=500;

% simular intentos
empirica=randi([1 val_posibles],n ,1);
value_unique_empirica=unique(empirica) ;
p_empirica = [];
% ciclo para contar cuantos valores unicos aparecieron en la simulacion
% y obtener su promedio por intento
for j=1:numel(value_unique_empirica)
    cuantos=sum(empirica==value_unique_empirica(j));
    p_empirica(j) = cuantos/n    ;
end

figure("Name","5c");
bar(value_unique_empirica, p_empirica,'DisplayName','Distribucion');
xlabel("Posibles Valores");
ylabel("Probabilidad");
lgd1 = legend;

%% 5d.	Simule un procedimiento de muestreo de una población de la variable X, donde pueda tomar m muestras de tamaño n y calcular la media de cada muestra. [1p]


%tamano de cada muestra
n=15;
%cantidad  de muestras 
m=100;

%simulacion donde el tamaño de las muestras son el largo de la columna y
%cada muestra se almacena en cada columna n x m
simu=randi([1 val_posibles],n ,m);
%promedio de los valores de las muestras
prom=mean(simu);
%redondeo de las cifras para evitar tanta dispersion del grafico
prom=round(prom,1);
%obtener cuantos valores de promedios diferentes aparecieron en el grafico
value_unique_=unique(prom) ;
p_ = [];
for ii=1:numel(value_unique_)
    cuantos=sum(prom==value_unique_(ii));
    p_(ii) = cuantos/m;
end

figure("Name","5d")
bar(value_unique_, p_,'DisplayName',m + " muestras de n=" + n)
xlabel("Medias de cada muestra")
ylabel("Probabilidad")
lgd1 = legend;


%% 5e.	Construya y grafique distribuciones muestrales de la media para n=5, n=10, n=20, n=30. Para ello utilice m≥100. [1p]

%tamaño de las muestras n=10, n=10, n=10, n=30
nArray=[5 10 20 30];
%cantidad muestras
m=100;
for xx=1:numel(nArray)
    simu2=randi([1 val_posibles],nArray(xx) ,m);
    prom2=mean(simu2);
    prom2=round(prom2,1);
    value_unique_2=unique(prom2) ;
    p_2 = [];
    for ii=1:numel(value_unique_2)
        cuantos=sum(prom2==value_unique_2(ii));
        p_2(ii) = cuantos/m;
    end
    
    figure("Name","5e n="+nArray(xx))
    bar(value_unique_2, p_2,'DisplayName',m + " muestras de n =" + nArray(xx))
    xlabel("Medias de cada muestra")
    ylabel("Probabilidad")
    lgd1 = legend;
    
end 


%% 5f.	Grafique las medias de las distribuciones muestrales como función del tamaño de muestra n, para n desde 2 hasta 100. Incluya en el gráfico, como referencia, el valor teórico de la población μ=E[X]. [1p] 

%inicio de tamaño de muestras
nInicio=2;
%fin de tamaño de muestras
nFin=100;
%todos loa valores entre tamaños de muestras
nArray=nInicio:nFin;
%arreglo para almacenar la media de 
promedios=[];

%ciclo para sacar las medias de n= 2 a 100
for xx=1:numel(nArray)
    simu3=randi([1 val_posibles],nArray(xx),1);
    %se saca el promedio de cada muestra
    prom3=mean(simu3);
    promedios(xx)=round(prom3,1);
end 
    
    % valor teorico de la poblacion 
    vteorico= sum (1:val_posibles) / val_posibles;
    figure("Name","5f Dist de medias n="+nInicio+" hasta " +nFin) ;
    plot(nArray,promedios,'DisplayName',"Dist de medias de n ="+nInicio+" hasta " +nFin );
    %linea para graficar el valor teorico
    line([nFin;0],[vteorico;vteorico],'linestyle','-','DisplayName',"Valor Teorico","Color","red");
    hold on
    
    dim=[.3 .8 .2 0];
    
    annotation('textbox',dim,'String',"Valor teorico:" + vteorico,'FitBoxToText','on','FontSize',8);
    xlabel("Valores de tamaños de muestra ");
    ylabel("Medias")
    lgd1 = legend;
    
    

    
    