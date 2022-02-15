%% 	3. Con respecto al problema de los dados normal y cargado (pregunta 2): 
%% a.	Construya un código que permita simular n lanzamientos de los dados normal y cargado. [1p]
clear all ;

%cantidad de lanzamientos
NLanza=400;
%numero sobre representado
valorS=4;
Dn = randi([1 6],NLanza,1); % Dado normal
Dc = randi([1 6],NLanza,1); % Dado cargado
% se hacen los reemplazos del numero 5 y 6 por el numero sobrerepresentado
Dc(Dc==5)=valorS;
Dc(Dc==6)=valorS;

%% b.	Grafique la frecuencia relativa acumulada de la ocurrencia del número S, como función del número de lanzadas. Realice esto para cada dado, en un mismo gráfico. Procure que se distingan claramente las dos curvas. Rotule adecuadamente los ejes. [2p]

%Se realiza ciclo para guardar frecuencia acumulada de Dado Normal
for i=1:NLanza
    
    tempArrayLanza=(Dn(1:i));
    
    AcertaArray =sum(tempArrayLanza==valorS);
    frecuenciaArrayDn(i) = AcertaArray/i;
    
end

%Se realiza ciclo para guardar frecuencia acumulada de Dado Cargado
for i=1:NLanza
    
    tempArrayLanza=(Dc(1:i));
    
    AcertaArray =sum(tempArrayLanza==valorS);
    frecuenciaArrayDc(i) = AcertaArray/i;
    
end

%Graficar resultados en azul Frecuencia dado normal y en Rojo Dado Cargado
f1=figure('Name','3.b - frecuencia relativa Dado Normal y Dado Cargado');
plot(frecuenciaArrayDn,'b','DisplayName','Frecuencia S Dado Normal');

hold on ;
plot(frecuenciaArrayDc,'r','DisplayName','Frecuencia S Dado Cargado');
ylabel('Resultado acumulados Dado Normal y Cargado');
xlabel('Simulaciones');
lgd1 = legend;

%%	c.Utilice los resultados de las simulaciones realizadas en (a) para calcular los datos requeridos para llenar la siguiente tabla:
 
%se guarda en una tabla los valores 
tabla=[sum(Dn==valorS) sum(Dn~=valorS);sum(Dc==valorS) sum(Dc~=valorS) ];

disp("Resultado Tabla");
disp(tabla);
%se muestra datos de la tabla
disp("_ _ _ _ _ _   |Numero S	| Numero~=S	|")
disp("Dado Normal	|	" + num2str(tabla(1,1)) + "		|	" + num2str(tabla(1,2)) + "		|")
disp("------------------------------------  |")
disp("Dado Cargado  |     " + num2str(tabla(2,1)) + "    	| 	" + num2str(tabla(2,2)) + "		|")
disp("------------------------------------  |")



 
%% d.	Para cada simulación implementada, calcule la suma de los resultados de ambos dados (normal y cargado). Grafique estos resultados. [2p]

% ciclo para sumar los valores de ambos dados
for i=1:NLanza
    
    totalArray(i) =sum(Dc(i)+Dn(i));
     
end

%graficar el resultado de la suma de los dados.
f2=figure('Name','3.d - suma resultado de ambos dados');
plot(totalArray,'b','DisplayName','Suma de resultado de los dados');
ylabel('Suma ambos dados');
xlabel('Simulaciones');
lgd1 = legend;
%% e.	Calcule la frecuencia relativa (número de ocurrencias con respecto al total de simulaciones) con que ocurre cada valor posible de la suma de los resultados de ambos dados. Grafique este resultado [2p]

%ciclo para calcular la frecuencia relativa de la suma de ambos datos.
for i=1:NLanza
    
    totalfArray =sum(Dc(1:i)+Dn(1:i));
    frecuenciaTotalArray(i) = totalfArray/i;
    
end
%graficar en azul la fercuencia relativa de la suma de ambos dados.
f3=figure('Name','3.e - frecuencia relativa de la suma de ambos dados');
plot(frecuenciaTotalArray,'b','DisplayName','Frecuencia Suma de resultado de los dados');
ylabel('Suma ambos dados');
xlabel('Simulaciones');
 lgd1 = legend;
%% 4. Una tarea cognitiva consiste en 300 trials. En cada trial se presenta, en la pantalla de un computador, uno de ocho estímulos posibles . La tarea de la persona participante es aprender a clasificar cada estímulo presentado en una de dos categorías.
%% a. Construya una secuencia de estímulos para esta tarea, procurando que estén todos representados en aproximadamente la misma proporción. [1p]

%variable para el n numero de Trials
NTrials= 300;

%calculo aleatorio de la aparacion de 8 estimulos distintos por la cantidad
%de trials
representaciones=randi([1 8],NTrials,1);

%% b. Simule la secuencia de respuestas de una persona, asumiendo que contesta al azar cada uno de los trials. [1p]

%generacion aleatoria de respuesta de la persona evaluada un 1 identifica
%clasificacion numero impar y numero 2 clasificacion numero par.
seleccion=randi([1 2],NTrials,1);


%% c. Defina una relación entre estímulos y respuestas que le permita calcular si una respuesta es correcta o incorrecta. En base a esto, calcule el desempeño de cada trial y el desempeño promedio que se obtiene en la simulación realizada en (a). [1p]
%evaluacion relacion si es par o es impar

resultTrial=[];

for i=1:NTrials
    
    
    if mod(seleccion(i),2)==0
        if mod(representaciones(i),2)==0
            resultTrial(i)=1;
        else
            resultTrial(i)=1;
        end
        
    else
        
        if mod(representaciones(i),2)==0
            resultTrial(i)=0;
        else
            resultTrial(i)=1;
        end
    end
    
    
end

%% d. Repita la simulación de (a) n veces (n≥50), y en cada caso calcule el desempeño promedio. [1p]

%variable para la cantidad de simulaciones
NSimu=50;
simuArrayres = [];
simuArraysel = [];
%ciclo para los calculos de n simulaciones
for j = 1:NSimu
    %generacion aleatoria de los Trials de estimulos
    simuArrayres(:,j)=randi([1 8],NTrials,1);
    %generacion aleatoria de la respuesta de los participantes
    simuArraysel(:,j)=randi([1 2],NTrials,1);
    %comparativa si las respuestas coinciden si es par o impar el resultado
    %es una matriz logica de aciertos o no
    simuArrayAcierto(:,j)=~mod(simuArrayres(:,j),2)==~mod(simuArraysel(:,j),2);
    
end

%desempeño por cada trial 
desempSimu = sum (simuArrayAcierto)/NTrials;


%% e. Grafique los resultados de (d), desempeño como función del número de simulación. [1p]

%graficar
f4=figure('Name','4.e - desempeño de las simulaciones');
plot(desempSimu,'b','DisplayName','desempeño de las simulaciones');
ylabel('Desempeño Acierto');
xlabel('Simulaciones');
lgd1 = legend;

%x y w h
%alinear graficos

f1.Position=[0 601 600 400];
f2.Position=[601 601 600 400];
f3.Position=[0 80 600 400];
f4.Position=[601 80 600 400];


