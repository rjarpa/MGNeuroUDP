%Taller_EJ1_P11

nSimu= 1000
Emba=randi([0 1],nSimu,1)

%rand 

test=rand(nSimu,1)

% se recorre vector para simular test.
contaEmbaTestPos  = 0
contaEmbaTestNeg = 0
contaNoEmbaTestPos = 0
contaNoEmbaTestNeg = 0

%arreglos para calcular falsos positivos
frecFalsosPositivos=[]
frecFalsosNegativos=[]

contarPositivos = 0
contarNegativos = 0

sumaFalsosPositivos = 0
sumaFalsosNegativos = 0

for i = 1:nSimu
    if Emba(i)==0 
        contarNegativos= contarNegativos+1
        if test(i)<=0.05
            contaNoEmbaTestPos= contaNoEmbaTestPos+1
            sumaFalsosNegativos  = sumaFalsosNegativos+1        
            frecFalsosNegativos(contarNegativos)= sumaFalsosNegativos/contarNegativos
        else
            contaNoEmbaTestNeg = contaNoEmbaTestNeg +1
            frecFalsosNegativos(contarNegativos)= sumaFalsosNegativos/contarNegativos
            
        end
    else
        contarPositivos= contarPositivos +1 
        if test(i)<=0.1
            contaEmbaTestNeg = contaEmbaTestNeg +1
            
            sumaFalsosPositivos = sumaFalsosPositivos+1
            frecFalsosPositivos(contarPositivos)= sumaFalsosPositivos/contarPositivos
        else
            
            contaEmbaTestPos= contaEmbaTestPos+1
            frecFalsosPositivos(contarPositivos)= sumaFalsosPositivos/contarPositivos
        end
        
        
    end
        
        
end


TablaFinal  =[contaEmbaTestPos,contaEmbaTestNeg ; contaNoEmbaTestPos, contaNoEmbaTestNeg]


figure

plot(frecFalsosNegativos)
hold on

plot(frecFalsosPositivos)