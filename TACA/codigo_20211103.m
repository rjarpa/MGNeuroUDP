nSims=50;
nPregs=20;

Data=randi([1 4], nSims, nPregs);
Pauta=randi([1 4], 1, nPregs);

Corr=nan(nSims,1);
for j =1:nSims
    C=nan(1,nPregs);
    for i = 1:nPregs
        if Data(j,i)==Pauta(i)
            C(i)=1;
        else
            C(i)=0;
        end
    end
    Corr(j)=sum(C)/nPregs;
end
    
% histogram(Corr,12)






cuantas=sum(Corr>=0.65);

pVal=cuantas/nSims
