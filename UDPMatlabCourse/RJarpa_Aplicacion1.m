%% PROBLEMA 1
truetable_AND = [0,0,and(0,0);
1,0,and(1,0);
0,1,and(0,1);
1,1,and(1,1)];

truetable_AND

truetable_OR = [0,0,or(0,0);
1,0,or(1,0);
0,1,or(0,1);
1,1,or(1,1)];

truetable_OR 

truetable_NOT = [0,not(0);
1,not(1)];

truetable_NOT

%% PROBLEMA 2

x=0;
y=0;
%(x AND NOT(y)) OR (NOT(x) & y)

TT_2 = [0,0, ; 1,0,; 0,1, ; 1,1, ];

%truetable_2(1,3) = [x,y,or(and((x),not(y)),not(x) & y);

x = TT_2(1,1);
y = TT_2(1,2);
TT_2(1,3) = or(and((x),not(y)),not(x) & y);

x = TT_2(2,1);
y = TT_2(2,2);
TT_2(2,3) = or(and((x),not(y)),not(x) & y);

x = TT_2(3,1);
y = TT_2(3,2);
TT_2(3,3) = or(and((x),not(y)),not(x) & y);

x = TT_2(4,1);
y = TT_2(4,2);
TT_2(4,3) = or(and((x),not(y)),not(x) & y);


TT_problema2 = TT_2

%implementacion del XOR
respuesta_problema2 = "Tabla de verdad del XOR"




%% PROBLEMA 3
% Resolver los errores de este script (si quieren pueden pegar este pedazo
% de codigo en otro script mientras lo arreglan

%AA = [1 2 3 4 5;6 7 8 10;11 12 13 14 15];
%AA(1,2:6)
%AA(4,5) = 20


AA = [1 2 3 4 5;6 7 8 9 10;11 12 13 14 15]; % faltaba el numero 9 para poder manter la dimension correcta
AA(1,2:5) % asumiendo que se quiere obtener un subtabla dejar solo hasta la columna 5 no la 6
AA(4,5) = 20 % No hay error pero quedaran ceros en los numeros faltantes de la fila 4




%% PROBLEMA 4
% 
% Procesador: Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz 2.90 GHz
% RAM 16.0 (15.9 Usable)
% Almacenamiento 1 TB SSD Nvme
% Resolucion Pantalla 1080p (1920 x 1080 pixeles)
% SO Windows 10
%

string_CPU = "Procesador: Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz 2.90 GHz"
string_RAM = "RAM: 16.0 (15.9 Usable)"
string_RAM = "Almacenamiento: 1 TB SSD Nvme"
string_Resolucion = "Resolucion Pantalla: 1080p (1920 x 1080 pixeles)"
string_SO = "SO: Windows 10"




