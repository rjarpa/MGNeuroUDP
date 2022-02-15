% participanteArray contiene los identificadores (Numero) de cada participante
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


partN=67;
participantArray=[1:partN];

% Numero de trials
trialsN=15;

%initizalizando los arreglos
rewardArray=[];
lostArray=[];
GSDollarArray=[];
GSNickelArray=[];
NGSDollarArray=[];
NGSNickelArray=[];

%inicializacion contadores
contGSDollarArray=1;
contGSNickelArray=1;
contNGSDollarArray=1;
contNGSNickelArray=1;
contlostArray=1;
contrewardArray=1;


for xx = 1:1:partN %ciclo por el total de participantes
    trialType=rand(trialsN);
    [rowsTrialType,colTrialType]=size(trialType);
    for ii = 1:1:colTrialType %ciclo por el total de trials
        DollarOrNickel=rand(1);
        responsepart=rand(1);
    
        if trialType(ii)<=.66 && DollarOrNickel <= 0.5     % GoDollar
            
           
            if responsepart>0.5  %sucess
                rewardArray(contrewardArray,1)=xx;
                rewardArray(contrewardArray,2)=0;
                rewardArray(contrewardArray,3)=1;
                GSDollarArray(contGSDollarArray,1)= xx;
                GSDollarArray(contGSDollarArray,2)= 1;
                contGSDollarArray= contGSDollarArray+1;
                contrewardArray= contrewardArray+1;
                
            else %fail
                lostArray(contlostArray,1)=xx;
                lostArray(contlostArray,2)=0;
                lostArray(contlostArray,3)=1;
                
                contlostArray= contlostArray+1;
            end
            
           
        elseif trialType(ii)<=0.66 && DollarOrNickel>0.5 % Go Nickel
           
            if responsepart>0.5 %sucess
                rewardArray(contrewardArray,1)=xx;
                rewardArray(contrewardArray,2)=1;
                rewardArray(contrewardArray,3)=1;
                GSNickelArray(contGSNickelArray,1)=xx;
                GSNickelArray(contGSNickelArray,2)=1;
                contGSNickelArray= contGSNickelArray+1;
                contrewardArray= contrewardArray+1;
                
            else
                lostArray(contlostArray,1)=xx; %fail
                lostArray(contlostArray,2)=1;
                lostArray(contlostArray,3)=1;
                
                contlostArray= contlostArray+1;
            end
            
        elseif trialType(ii)>0.66 && DollarOrNickel<=0.5 % NoGo Dollar
            
            if responsepart>0.5 % success
                rewardArray(contrewardArray,1)=xx;
                rewardArray(contrewardArray,2)=0;
                rewardArray(contrewardArray,3)=0;
                NGSDollarArray(contNGSDollarArray,1)=xx;
                NGSDollarArray(contNGSDollarArray,2)=1;
                contNGSDollarArray= contNGSDollarArray+1;
                contrewardArray= contrewardArray+1;
                
            else %fail
                lostArray(contlostArray,1)=xx;
                lostArray(contlostArray,2)=0;
                lostArray(contlostArray,3)=0;
                
                contlostArray= contlostArray+1;
            end
            
           
        elseif trialType(ii)>0.66 && DollarOrNickel>0.5  % NoGo Nickel
            if responsepart>0.5 % success
                rewardArray(contrewardArray,1)=xx;
                rewardArray(contrewardArray,2)=1;
                rewardArray(contrewardArray,3)=0;
                NGSNickelArray(contNGSNickelArray,1)=xx;
                NGSNickelArray(contNGSNickelArray,2)=1;
                contNGSNickelArray= contNGSNickelArray+1;
                contrewardArray= contrewardArray+1;
            else %fail
                lostArray(contlostArray,1)=xx;
                lostArray(contlostArray,2)=1;
                lostArray(contlostArray,3)=0;
                contlostArray= contlostArray+1;
                
            end
        end
        
        
    end
end

