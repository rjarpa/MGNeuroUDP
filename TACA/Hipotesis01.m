X=0:20
P=binopdf(X,20,0.25)
bar(X,P);xlabel('Aciertos en 20 preguntas')
hold on;
%%P=normpdf(X,20,0.25)
XX=13:20
PP=sum(binopdf(XX,20,0.25))
%bar(XX,PP);xlabel('Aciertos en > 13 preguntas')
