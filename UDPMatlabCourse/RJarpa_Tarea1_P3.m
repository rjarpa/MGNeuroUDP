%% Inicializar Variables

M1=[1,2,3,4;5,6,7,8;9,10,11,12;13,14,15,16;17,18,19,20]; 
M2=[2,3,5,7;11,13,17,19;23,29,31,37;41,43,47,53;59,61,67,71];
M3=[2,4,6,8;10,12,14,16;18,20,22,24;26,28,30,32;34,36,38,40];
DD=[2,2,2,2;2,2,2,2;2,2,2,2;2,2,2,2;2,2,2,2];



%% A) Sumar todas ellas (+)

ANSA=M1+M2+M3+DD


%% B) Multiplicar todas ellas (.*)
ANSB=M1.*M2.*M3.*DD

%% C) Multiplicar una de ellas por la matriz DD (.*).

ANSC=M1.*DD


%% D) Restar 2 de ellas (-)

ANSD=M3-DD



%% E) Dividir 2 de ellas (./)

ANSE=M3./DD


%% F) Multiplicar una de ellas por 2 (*).

ANSD=M3*2


%% G) Explique las diferencias/similitudes entre la operación realizada en la letra B, C, F.


%Similitudes: todas las operaciones fueron realizas sobre de los valores 
%       escalares internos de las matrices y sus coordenadas comunes.
%Diferencias: Los operadores (.*) y (./) se aplican entre los valores 
%               escalares almacenados dentro de la matriz
%               a diferencia de (*) y (/) que aplicarian utilizando 
%               las propiedades de multiplicacion y division de matrices,
%               aunque si es posible multiplicar una matriz por un solo
%               valor escalar como en el ejercicio F utilizando el operador
%               (*)

%% H) Seleccione una columna de cada matriz y súmelas.

ANDH = M1(:,1)+M2(:,1)+M3(:,1)+DD(:,1)






