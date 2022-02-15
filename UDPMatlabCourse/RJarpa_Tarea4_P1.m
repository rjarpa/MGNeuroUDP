

%A
load('Data_T4P1.mat');

dat_GO=RT_Go;
dat_NoGo=RT_NoGo;

%B
prom_Go= mean(dat_GO,'omitnan');
median_Go= median(dat_GO,'omitnan');

%C
prom_NoGo= mean(dat_NoGo,'omitnan');
median_NoGo= median(dat_NoGo,'omitnan');

%D) Mediana Go y NoGo

f1=figure('Name','Tarea4 P1 D) Mediana Go y NoGo');

hold on;


plot(median_Go,'rx-.','DisplayName','Mediana Go');
plot(median_NoGo,'bd-','DisplayName','Mediana NoGo');


f1.Position=[100 550 1280 400];
xlim([-3 15]);

hold off;
lgd1 = legend;

%E) Media Go y NoGo

f2=figure('Name','Tarea4 P1 E) Media Go y NoGo');

hold on;
plot(transpose(prom_Go),'gx-.','DisplayName','Media Go');
plot(transpose(prom_NoGo),'md-','DisplayName','Media NoGo');

f2.Position=[100 50 1280 400];

xlim([-3 15]);
hold off;
lgd2 = legend;
