%%Exercises
clear all;
%% Variables

%1
    
matriz30_4 = nan (30, 4);
matriz30_4(31,10)= 10;

matriz = zeros(30,4);
matriz(31,10)=10;
matriz2 = [30,4];
%matriz3 = [1:30,1:4][1:15,1:3];
matriz4 = double.empty(30,4,0);


%2 

mouse.name = 'mickey';
mouse.surgeryDate = '24 March';
mouse.geneType = 'wildtype';
mouse.age = 65; % in days since 
birthmouse.numElectrodes = 3;


mouse(2).name = 'minney';
mouse(2).surgeryDate = '2 April';
mouse(2).geneType = 'GAD2Cre';
mouse(2).age = 82; % in days since 
birthmouse(2).numElectrodes = 6;

ages = [mouse.age];
%respuesta logica.
ages = ages<70;

%3 
%datamat(1:.5:end)
var_end=50
datamat=(1:.5:var_end)

1:4:3
[ [1 2:3 4:5] (6:10) ]'

[ [1 2:3 4:5]; (6:10) ]
%cvar = 4;-5
cvar = 4:-1:-5
var = ones(1,10)';
var = [1:10]';


%4

aa4=0:.1:(2>1)
bb4=(0:.1:2)>1
cc4= 0:.1:4>1

%5

aa5=[0:9 10 9:-1:0]'
aa5=aa5+4
aa5_8 = aa5==8

%6

%clear a borra variable a
%clear a* borra todas las variables por a

%7 

total_electrode = sum ([birthmouse.numElectrodes])


%8 

matriz8 = zeros(50,40)

matriz8(1:10) = [10]

matriz8(40:5) = [5]

%9

aa9= 4+(4/5)
bb9= 18 * (48 ^-4)
cc9= (4+3)/8
dd9 = 4+(3/8)


%10
na10 = zeros(3,5)/0;
nb10 = 3+ones(3,5)/0;
nc10 = nan(3,5);


%11
%illegal
%7mac11i
%HeartData!
%data set

%good
%variablesRgr8

%12
%ok
aMatrx = [1 3 2 3; 6 7 8 9];
%no ok
%aMatrx = [1 3 2 3; 5 3 6; 7 8 9];
%no ok
%aMatrx = [1 3; 5 6; 7 8];
%no ok
%aMatrx = [1 3 2; 5 6; 7 8 9];

%13
aa13=aMatrx + 4
bb13=aa13*6.4
cc13=bb13-100

dd13 =aMatrx(1,1) +4
ee13 =aMatrx(1:4) +4
ff13 =aMatrx(:,2) +4

%Funciones
[maxval,maxidx] = max([ 1 2 1 1 5 5 1 5 ])

data = randi (10,[10,5])
meanval          =  mean(data);
medianval  = median(data);
minval     = min(data);
maxval     = max(data);
N           = length(data);