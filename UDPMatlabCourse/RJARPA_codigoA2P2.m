% Trabajo de Aplicacion 2
% Pregunta 2
%
% Considere que dat1 es el vector original con las edades de las madres
% 


%Se asigna a la variable dat2 el contenido del vector dat1
dat2 = dat1;
% se excluyen los valores no numericos del vector dat2 y se asigna, ya que
% se prefiltran los nan y al negarlos se obtienen los valores numericos
aux = dat2(~isnan(dat2));

%se obtiene el promedio de los valores del vector aux
pr = mean(aux);

%se obtiene la cantidad de elementos de la COLUMNA del vector dat1 
ar = size(dat1,1);

% se asigna nuevamente el contenido el vector dat1 a la variable dat2
dat2 = dat1;
% se ejectuta un ciclo for desde 1 el unicio hasta el tamaño total del
% vector original dat1
for ik = 1:1:ar
    % se consulta si el valor del elemento dat1 en la posicion ik del ciclo
    % for es un valor NAN
   if isnan(dat1(ik))
       % si es nan se reemplaza el valor por el promedio en el vector dat2
       dat2(ik) = pr;
   else
       % si no es un valor nan se asigna el valor directamente de la
       % posicion actual de dat1 en el ciclo for a dat2 en la misma
       % posicion
       dat2(ik) = dat1(ik);
   end
end

%abre una nueva ventana de figura con sus valores de propiedades por
%defecto
figure
% grafica el contenido de los datos vector del vector dat2 sobre la ventana
% de figura, el grafico sera de lineas.
plot(dat2)


%El script grafica las edades de las madres pero asegurando de reemplazar
%por el promedio los valores de tipo nan para no afectar la operacion