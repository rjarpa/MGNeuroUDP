%Taller_EJ1_P10
clear
cantP = 100
cantResp = 5
nSimu =10

pautacorreccion=randi([1 cantResp],cantP,1);


repuestasPAlumno=[]

for i = 1:nSimu
respuestas = randi([1 cantResp],cantP,1);
repuestasPAlumno = [repuestasPAlumno, respuestas]
end

%verificar respuesta correctas
correccion=[]
temp=[]
for i = 1:nSimu
    temp=(repuestasPAlumno(:,i)==pautacorreccion)
    correccion=[correccion,temp]
end

totalsum=sum(correccion)
totalpor=(sum(correccion)/cantP)*100


Promedio = mean(totalpor)
StdDev= std(totalpor)


