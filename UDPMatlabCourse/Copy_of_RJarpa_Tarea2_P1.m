% segun el diagrama de flujo almacene los datos en 6 matrices 
% ENTRADAS
% rewardArray contiene los premios de cada participante  
%       columnas (Numero participante,  Es reward por Nickel ?, es GO? )
%   
% lostArray contiene los errores de cada participante
%       columnas (Numero participante,  Es reward por Nickel ?, es GO? )
% GSNikelArray contienene los errores de 
%        columnas (Numero de participante, un numero 1)
% GSDollarArray contienene los errores de 
%        columnas (Numero de participante, un numero 1)
% NGSNickelArray contienene los errores de 
%        columnas (Numero de participante, un numero 1)
% NGSDollarArray contienene los errores de 
%        columnas (Numero de participante, un numero 1)


    rewardArray = []
    lostArray = []
    GSNickelArray =[]
    GSDollarArray  =  []
    NGSNickelArray = []
    NGSDollarArray = []
% Utilizando la funcion size para obtener las dimensiones de la matriz


    [rowsLost,colsLost] = size(lostArray)
    
%   Inicializar los contadores de perdidas
    contlostGSNickel=0
    contlostGSDollar =0
    contlostNGSNickel =0
    contlostNGSDollar =0
    
%   Se va a recorrer solo la matriz de perdida para acumular los contadores
%   de cada tipo de perdidad
    for i = 1: 1: rowsLost
        if lostArray("isRewardNickel") == 1 &&  rewardArray("isGO") == 1
             contlostGSNickel=contlostGSNickel+1;
        elseif lostArray("isRewardNickel") == 0 &&  rewardArray("isGO") == 1
            contlostGSDollar=contlostGSNickel+1;
        elseif lostArray("isRewardNickel") == 1 &&  rewardArray("isGO") == 0
            contlostNGSNickel=contlostGSNickel+1;
        elseif lostArray("isRewardNickel") == 0 &&  rewardArray("isGO") == 0
            contlostNGSDollar=contlostGSNickel+1;
        end
        
    end
    
   
%   Se utiliza la funcion suma para obtener la acumulacion de todos los
%   numeros 1 de cada respuesta correcta por tipo de moneda (estan en
%   matrices distintas registradas)
    contrewardGSNickel = sum(GSNickelArray);
    contrewardGSDollar = sum(GSDollarArray);
    contrewardNGSNickel = sum(NGSNickelArray);
    contrewardNGSDollar = sum(NGSDollarArray);
    
% Se obtiene el % de acierto de cada tipo (GS vs. NGS × dollar vs. nickel)
    percenGSNickel = (contrewardGSNickel/(contrewardGSNickel+contlostGSNickel))*100
    percenGSDollar = (contrewardGSDollar/(contrewardGSDollar+contlostGSDollar))*100
    percewardNGSNickel = (contrewardNGSNickel/(contrewardNGSNickel+contlostNGSNickel))*100
    percenNGSDollar = (contrewardNGSDollar/(contrewardNGSDollar+contlostNGSDollar))*100



% por cada 







