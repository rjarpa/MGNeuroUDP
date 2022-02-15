
nSims=15;

E=2;

D=randi([1 6], nSims,1);
L=D==E;
NE=sum(L);


acum_nE=nan(nSims,1);
PacumE=nan(nSims,1);
for j=1:nSims
    
    d=D(1:j);
    
    l=d==E;
    
    acum_nE(j)=sum(l);
    PacumE(j)=acum_nE(j)/j;
end
    
    
    

