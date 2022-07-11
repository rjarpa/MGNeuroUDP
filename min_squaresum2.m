
clear all;
%% regresion lineal
% calcular los parametros de la recta que minimiza la suma de cuadrados
% para el siguiente caso
%suma de cuadrados
   CAmark_x = [87 79 88 98 96 73 83 79 91 94]
   Finalmark_y = [70 74 80 84 80 67 70 64 74 82]

   
  promedio_x = mean(CAmark_x)
  promedio_y = mean(Finalmark_y)
  
  sumacuadrado = 
   %covarianza de los datos 
Sxy = cov(CAmark_x,Finalmark_y)

Sx=cov(CAmark_x)
Sy=cov(Finalmark_y)

%varianza de los datos
Sx2 = var(CAmark_x)

hat_b = Sxy(2,1)/Sx2

hat_a = promedio_y - hat_b*promedio_x

figure;
hold on;
scatter(CAmark_x,Finalmark_y)
xlabel("CA Mark")
ylabel("Final mark")
% y = a + bx

x1= 70
x2= 100
y1=hat_a + hat_b * x1
y2=hat_a + hat_b * x2
X= [x1 x2]
Y =[y1 y2]
plot(X,Y)