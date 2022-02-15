clear all;
%n lanzamiento de dado tipico

% a 
NLaza=1000;
valorbuscado = 3;
E=randi([1 6],NLaza,1 );

%Probabilidad clasica
Pcla=sum(E==valorbuscado)/NLaza;

AcertaArray =[];
ProbabilidadArray =[];

%valor acumulado de simulaciones
for i=1:NLaza
    
    tempArrayLanza=(E(1:i));
    
    AcertaArray =sum(tempArrayLanza==valorbuscado);
    ProbabilidadArray(i) = AcertaArray/i;
    
end



figure,plot(ProbabilidadArray)