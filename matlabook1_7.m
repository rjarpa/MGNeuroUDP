%% exercices
for i=1:3
    for j=i:10
        disp(i*j)
    end
end


%% Variable

%Variable for numbers = scalar

anArray = [1 3 2 5 3 6 7 9];


aMatrx = [1 3 2; 5 3 6; 7 8 9];


%Mathematical expresion

a = 4;
b = 3;
b^2
a+b
a*b
(a*4) + (b/2)

a*4+b/2


%data = double(data);

%Variable for Truth

isEverythingOK = 1==2

var = true; % or var=false;
var + 4
%Variable for String

nameVariable = 'Mike X Cohen@#$%';

string4 = '4';
number4 = 4;
number4 + string4

%variable for Cells

a = [52 'hello' 52]

celery{1} = 52;
celery{2} = "hello";
celery{3} = 52;

%Variable for structures

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

mouse.age
mouse.geneType

%colon

%cuenta de a 1
1:5
%count by 2 middle aprameter
1:2:5

numbers = 1:2:200;


c = 1:3;

c([ true false true ])

%extract elements from 51 to 100
logicalIdx = 1:100>50
numbers(logicalIdx)
numbers(double(logicalIdx))
numbers(double(logicalIdx))

numbers(double(logicalIdx))

mat1 = zeros(3);
mat2 = zeros(3,3);

mat3 = ones(2,4);
mat4 = 7.43*ones(2,4) + 10;
mat5 = true(1,3);
mat6 = nan(8,2,3,4,5,2);

%Functions

%Control Statments


