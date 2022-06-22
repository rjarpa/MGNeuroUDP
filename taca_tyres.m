clear all;

%se carga la informacion del archivo txt
varloadTable=floadTable('D:\OneDrive\MATLAB\TYRE_WEAR.txt');




%se asigan los valores de edad para eje x
treatment_size_x = table2array(varloadTable(:,1));
%se asignan los valores de colesterol para eje y
%chol_y = table2array(varloadTable(:,2));
treatment_location_x = table2array(varloadTable(:,2));





%media de volume y
%media_y_2 =mean(behaviour_y);


% se obtiene la suma de cuadrados de la media SCtot
SS_tot_y_2 = sum((behaviour_y-media_y_2 ).^2);



%funcion de carga de archivo ejericicio 5
function floadTable=floadTable(path)

%lectura de tabla del disco local de la ruta del parametro.
floadTable = readtable(path);

end
