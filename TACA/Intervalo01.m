clear all
% media u  MU
% stabndard deviation o sigma 
% n = 200
media = 1.67
%????
varmean=  1.65
sd= .15
n=20

%Arra1 = randn([n])

%x=grades(:,1) 
z= varmean - (varmean - media / sqrt(n))

%% Comienza el ejercicio

%Example 1: Generate values from a normal distribution with mean 10 mu
%        and standard deviation 2 sigma.

n= 100;
r = 10 + 2.*randn(n,1);
rmean = mean(r);
rsd = std(r);

%Arra1 = randn(n)
%suma=sum(Arra1)
suma=sum(r)
%distrmuestral = sum(Arra1) / n
distrmuestral = sum(r) /10
pd = fitdist (r,'Normal')
%intervalo de confianza
ci = paramci(pd, 'Alpha', .05)
%bar(1:20,distribucionmuestral);xlabel('Test')
%bar(1:n,suma);xlabel('Test')
bar(1:n,r);xlabel('Test')
promedio = mean(distrmuestral)

z2= promedio - (promedio - pd(1).mu / sqrt(n))

%ci2_low = distrmuestral - 
%ci2_high =