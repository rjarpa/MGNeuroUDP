%% version 1

nP=100;  % n preguntas
nA= 5;  % n alternativas
nSims=500; % n simulaciones

R=randi([1 nA], nP,nSims);

%% version 2

nP=100;  % n preguntas
nA= 5;  % n alternativas
nSims=500; % n simulaciones

R=nan(nP,nSims); %prealocar
for j=1:nSims
    
    r=randi([1 nA], nP,1);
    
    R(:, j)=r;
    
end

%% dos niveles de simulaciones


nP=100;  % n preguntas
nA= 5;  % n alternativas
nSims=500; % n simulaciones

nSims_level2=10;  % n simulaciones de 2do nivel

m=nan(nSims_level2,1); %prealocar
for i=1:nSims_level2
    
    R=nan(nP,nSims);
    
    for j=1:nSims
        r=randi([1 nA], nP,1);
        R(:, j)=r;
    end
    
    m(i)=mean(mean(R));
    
end
