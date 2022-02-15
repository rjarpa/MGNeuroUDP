clear all
%% 2
%a
X=0:15
proba=binopdf(X,15,0.5)
totalproba = sum(proba)

%% c
Xc=0:5
probac=binopdf(Xc,15,0.5)
