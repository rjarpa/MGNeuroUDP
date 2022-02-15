

dat01=TmData01
dat02=TmData02
dat03=TmData03



%Go

%'0 Go 1 NoGo


indxTypeTrial = dat01(:,2)==0 % Go
temp_dat01_go= dat01(indxTypeTrial ,:)

prom_go_dat01=mean(temp_dat01_go(:,1))
mediana_go_dat01=median(temp_dat01_go(:,1))



indxTypeTrial = dat02(:,2)==0 % Go
temp_dat02_go= dat02(indxTypeTrial ,:)

prom_go_dat02=mean(temp_dat02_go(:,1))
mediana_go_dat02=median(temp_dat02_go(:,1))


indxTypeTrial = dat03(:,2)==0 % Go
temp_dat03_go= dat03(indxTypeTrial ,:)

prom_go_dat03=mean(temp_dat03_go(:,1))
mediana_go_dat03=median(temp_dat03_go(:,1))



indxTypeTrial = dat01(:,2)==1 % NoGo
temp_dat01_nogo= dat01(indxTypeTrial ,:)

prom_nogo_dat01=mean(temp_dat01_nogo(:,1))
mediana_nogo_dat01=median(temp_dat01_nogo(:,1))


indxTypeTrial = dat02(:,2)==1 % NoGo
temp_dat02_nogo= dat02(indxTypeTrial ,:)

prom_nogo_dat02=mean(temp_dat02_nogo(:,1))
mediana_nogo_dat02=median(temp_dat02_nogo(:,1))


indxTypeTrial = dat03(:,2)==1 % NoGo
temp_dat03_nogo= dat03(indxTypeTrial ,:)

prom_nogo_dat03=mean(temp_dat03_nogo(:,1))
mediana_nogo_dat03=median(temp_dat03_nogo(:,1))




% C) Graficar

f1=figure('Name','Tarea3 P3_Lineas');

hold on;
%plot(dat01(:,1),'rx-.');
%plot(dat02(:,1),'bd-');
%plot(dat03(:,1),'gv-');

plot(temp_dat01_go,'rx-.');
plot(temp_dat02_go,'bd-');
plot(temp_dat03_go,'gv-');

plot(temp_dat01_nogo,'cx-.');
plot(temp_dat02_nogo,'md-');
plot(temp_dat03_nogo,'yv-');


xlim([-10 40]);
%ylim([0 100]);
f1.Position=[100 550 1280 400];


