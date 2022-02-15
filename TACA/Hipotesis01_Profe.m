nSims=50;
nPregs = 20;

Data= randi([1 4],nSims,nPregs);
Pauta =randi([1 4],1,nPregs);

Corr = Data==Pauta(1,:)

CorrT=transpose(Corr)

Total = sum(CorrT)/nPregs

%%histogram(Corr,12)
