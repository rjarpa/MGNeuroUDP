% A) Crear dos vectores aleatorios de 1 fila

AA1=rand(1,100);
AA2=rand(1,100);

% B) Crear un grafico de linea de estos dato 

f1=figure('Name','Tarea3 P3_Lineas');
AA1=AA1*100;
AA2=AA2*100;
hold on;
plot(AA1,'rx-.');
plot(AA2,'bd-');
xlim([-10 110]);
ylim([0 100]);
f1.Position=[100 550 1280 400];
f2=figure('Name','Tarea3 P3_Barras');

% C) crear grafico de barra
AA3=[transpose(AA1) transpose(AA2)];
bar(AA3);

xlim([-10 110]);
ylim([0 100]);
f2.Position=[100 50 1280 400];


