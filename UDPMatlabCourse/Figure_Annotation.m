figure('Name','Datos a medir');
plot([1 2 3 4 5 ],[2 4 6 8 10]);
dim = [0.2 0.5 0.3 0.3];
variable_texto = 'Linea recta desde 1 a 10';
annotation('textbox',dim,'String',variable_texto,'FitBoxToText','on');