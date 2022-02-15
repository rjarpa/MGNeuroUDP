%Taller_EJ1_P12

% RAndom Walk
clear
NSteps= 1000


step_directions = rand(NSteps,1)


% Izq = 0.3 < .03
% Der =0.2 <
% Up = 0.4
% Down = 0.1



Leftp=.3
Rightp=.2
Upp=.4
Downp=.1


ifdir=[Leftp;Rightp;Upp;Downp]

%plano de Y X
plano=[0,0];
for i= 2:NSteps+1
    display(i)
    if step_directions(i-1)<sum(ifdir(1,:)) % Paso Izq
        
        plano (i,1)=plano (i-1,1)-1
        plano (i,2)=plano (i-1,2)
        
    elseif step_directions(i-1)>=sum(ifdir(1,:)) && step_directions(i-1)<sum(ifdir(1:2,:)) % paso Der
        plano (i,1)=plano (i-1,1)+1
        plano (i,2)=plano (i-1,2)
        
    elseif step_directions(i-1)>=sum(ifdir(1:2,:)) && step_directions(i-1)<sum(ifdir(1:3,:)) % paso Arriba
        plano (i,1)=plano (i-1,1)
        plano (i,2)=plano (i-1,2)+1
        
    else % paso abajo
        
        plano (i,1)=plano (i-1,1)
        plano (i,2)=plano (i-1,2)-1
    end
end

    figure,plot(plano(:,1),plano(:,2))



