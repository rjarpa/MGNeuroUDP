%% 4a.	Defina dos hipótesis diferentes con respecto al funcionamiento del dado y tradúzcalas a parámetros específicos de una distribución de probabilidad relevante. [1p]

n=25
X1=0:n
X2=0:n

%probabilidad de dado normal 3 pares posible de 6 = 3/6 = 1/2
P1 = 0.5
%probabilidad que el dado tuviese 4 numeros pares 6 = 4/6 = 2/3
P2 = 0.66

D1 = binopdf(X1,n,P1)
D2 = binopdf(X2,n,P2)


%% 4b.	Grafique ambas distribuciones en un mismo gráfico. [1p]

figure("Name", "4a."), 
bar(X1,D1,'DisplayName','3 Pares en el Dado')
hold on
bar(X2,D2,'DisplayName','4 Pares en el Dado')
xlabel("Cantidad de Pares")
ylabel("Probabilidad")
hold off
lgd1 = legend;
%%	4c. Calcule la probabilidad P(X=15|Bino_(n,p) ) de obtener el valor X=15 en su variable, como función del parámetro p. Para ello, elija un conjunto de valores de p y calcule en cada caso la probabilidad requerida. [1p]

p = 0.5
X3 = 0:n
X=15

%valores de p
D3=binopdf(X3,n,p)
%probabilidad de X=15
D4=binopdf(X,n,p)


%%	4d. Presente los resultados de la pregunta c en un gráfico P(X=15|Bino_(n,p) ) versus p. [1p]

figure("Name","4d")
bar(X3,P3,'DisplayName','Probabilidad del Dado')
hold on
%cantidad de pares
bar(15,P4,'y','DisplayName','Probabilidad de X=15')
xlabel("Posibles Valores X")
ylabel("Probabilidad")
hold off
lgd1 = legend;


%% 5a.	Defina una variable aleatoria X que: se distribuya de manera uniforme, sea simulable en código Matlab y sea diferente a las analizadas en clases, [1p]


%disparos de una pistola calibre 
%bolitas de una tombola con reposicion
%sacar fichas de token de una bolsa en un juego de rol
%robar cartas de un maso con reposicion
n=500
nn=6
p=1/nn
X5=1:nn

%% 5b.	Calcule el valor esperado E[X] y la varianza E[〖(X-μ)〗^2]. [1p]

%valor_esperado
EX=sum(X5*p)

%varianza E[〖(X-μ)〗^2]
EXArray=power((X5-EX),2)
varianza = sum(EXArray)

%% 5c. Produzca un conjunto de N valores de la variable (N≥500), y construya la distribución de probabilidad “empírica” de la variable a partir de estos N valores. [2p]
%lanzar 

%empirica=randi([1 nn],n ,1)
empirica=randi([1 nn],n ,1)
m=100
value_unique_empirica=unique(empirica) 
p_empirica = []
for j=1:numel(value_unique_empirica)
    cuantos=sum(empirica==value_unique_empirica(j))
    p_empirica(j) = cuantos/n    
end
figure("Name","5c")
bar(value_unique_empirica, p_empirica,'DisplayName','Valores')
xlabel("Posibles Valores")
ylabel("Probabilidad")
lgd1 = legend;

%mediaArray=[]
%for i=1:m
    %simuempirica=randi([1 nn],n ,1)
    %mediaArray(i) = mean(simuempirica)
%end
%figure,
%bar([1:6],MediaArra)

%% 5d.	Simule un procedimiento de muestreo de una población de la variable X, donde pueda tomar m muestras de tamaño n y calcular la media de cada muestra. [1p]

nnn=15
mmm=100

simuempirica2=randi([1 6],nnn ,mmm)
prom=mean(simuempirica2)
prom=round(prom,1)
value_unique_empirica2=unique(prom) 
p_empirica2 = []
for ii=1:numel(value_unique_empirica2)
    
    cuantos=sum(prom==value_unique_empirica2(ii))
    p_empirica2(ii) = cuantos/mmm
    
end

figure("Name","5d")
bar(value_unique_empirica2, p_empirica2,'DisplayName',mmm + " muestras de n =" + nnn)
xlabel("Media Muestral")
ylabel("Probabilidad")
lgd1 = legend;


%calcualr mu despues
Mu=3.5
%figure
%bar(mediaArray2(i))

%% 5e.	Construya y grafique distribuciones muestrales de la media para n=5, n=10, n=20, n=30. Para ello utilice m≥100. [1p]

%n=10, n=10, n=10, n=30

nArray=[15 10 20 30]
mmm=100
for xx=1:numel(nArray)
    simuempirica2=randi([1 6],nArray(xx) ,mmm)
    prom=mean(simuempirica2)
    prom=round(prom,1)
    value_unique_empirica2=unique(prom) 
    p_empirica2 = []
    for ii=1:numel(value_unique_empirica2)
        cuantos=sum(prom==value_unique_empirica2(ii))
        p_empirica2(ii) = cuantos/mmm
    end
    
    figure("Name","5e n="+nArray(xx))
    bar(value_unique_empirica2, p_empirica2,'DisplayName',mmm + " muestras de n =" + nArray(xx))
    xlabel("Media Muestral")
    ylabel("Probabilidad")
    lgd1 = legend;
    
end 





%% 5f.	Grafique las medias de las distribuciones muestrales como función del tamaño de muestra n, para n desde 2 hasta 100. Incluya en el gráfico, como referencia, el valor teórico de la población μ=E[X]. [1p] 


nInicio=2
nFin=100
nArray=nInicio:nFin
mmm=100
p_empirica=[]
for xx=1:numel(nArray)
    simuempirica2=randi([1 6],nArray(xx) ,mmm)
    prom=mean(simuempirica2)
    prom=round(prom,1)
    value_unique_empirica2=unique(prom) 
    p_empirica2 = []
    for ii=1:numel(value_unique_empirica2)
        cuantos=sum(prom==value_unique_empirica2(ii))
        p_empirica2(ii) = cuantos/mmm
    end
    
    p_empirica3(xx)=mean(p_empirica2)
    
end 

 figure("Name","5f n="+nInicio+" hasta " +nFin) 
    bar(value_unique_empirica2, p_empirica2,'DisplayName',mmm + " muestras de n =" + nArray(xx))
    xlabel("Media Muestral de las Muestras")
    ylabel("Probabilidad")
    lgd1 = legend;
