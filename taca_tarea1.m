clear all;
%% 4
%escriba un codio que le permita, dado un vedctor de datos cualquiera calcular la suna de cuadrados

% Se genera un vector temporal para probar la funcion
Vec_temp  = 2+3.*randn(1,10);

% se entrega comp parametro el vector a la funcion creada
SStotvar=SStot(Vec_temp);

%se despliega el valor resultante de la funcion de suma de cuadrados de la
%media
display("Suma de cuadrado diferencia entre datos y media:" + num2str(SStotvar))


%%  5

%a

%se carga la informacion del archivo txt
varloadTable=floadTable('D:\OneDrive\MATLAB\AGE_CHOLEST.txt');

%se asigan los valores de edad para eje x
age_x = table2array(varloadTable(:,1));
%se asignan los valores de colesterol para eje y
chol_y = table2array(varloadTable(:,2));

figure;hold on;
% se grafican los puntos en la figura
plot(age_x,chol_y,'ok')

%se gregan etiquetas de los ejes
xlabel('age');
ylabel('cholesterol');

%media de y
media_y_5 =mean(chol_y);
% se obtiene la suma de cuadrados de la media SCtot
SS_tot_y_5 = sum((chol_y-media_y_5 ).^2);

%media de x
media_x_5 =mean(age_x);
% se obtiene la suma de curadrado
SS_tot_x_5 = sum((age_x- media_x_5 ).^2);

%b

%se ocupa funciona de matlab para obtener la covarianza de X e Y
cov_b= cov(age_x,chol_y);
%valor de la covarianza entre X e Y
cov_b= cov_b(2,1);

%c

% se asigna la covarianza a la variable
Sxy = cov_b;
% se obtiene la varianza de x
Sx2 = var(age_x);

% se calcula el valor de b_hat
b_hat_5 = Sxy/Sx2;
a_hat_5 = media_y_5 - b_hat_5*media_x_5;
%y= a +bx

X_5=[min(age_x) max(age_x)];
Y_5=a_hat_5 + b_hat_5  .*X_5;


%d
% se grafica la ecuacion de la recta
plot(X_5,Y_5);



%% 6

%a
% valor de intercepto
A_6=2;
%valor de la pendiente
B_6=3;
%desviacion standard
sd=4;

% 20 valores
X_6=1:20;


%b

%se simula valores de y utilizando media 0 y lo que contenga variable sd
%como distribucion
Y_6=A_6+B_6.*X_6+randn(size(X_6)).*sd;
%se calcula la covarianza
Sxy_6 = cov(X_6,Y_6);
%se obtiene el data que nos sirve entre X e Y
Sxy_6 = Sxy_6(2,1);
%se sacan las varianzas de Y y X
Sx2_6 = var(X_6);

%obtenemos el valor de b hat
b_hat_6=Sxy_6/Sx2_6;
%obtenemos el valor de a hat
a_hat_6=mean(Y_6)-b_hat_6*mean(X_6);

%se grafica resultado 
figure;
plot(X_6,Y_6,'ok'); hold on
xlabel("X");
ylabel("Y");


%c 
%se busca los valores de a hat y b hat utilizando la recta que minimiza la
%suma de cuadrados

%graficamos la recta que minimiza la suma de cuadrados
XX_6=[min(X_6) max(X_6)];
YY_6=a_hat_6 + b_hat_6  .*XX_6;
plot(XX_6,YY_6);

%d 
%Estimar un Y desde b hat y a hat
Y_6_est=a_hat_6+b_hat_6*X_6;
%obtener SC error
SS_err=sum((Y_6-Y_6_est).^2);
%grado de libertad de SC error
df_err=numel(X_6)-2;
%varianza de SC errpr
var_err=SS_err/df_err;
%obtener sigma del error para las simulaciones
sd3=sqrt(var_err);

% realizamos simulaciones para ver como varia b_hat y a_hat
nSims = 500000;
for i=1:nSims
    % se realiza la simulacion de y con sd de la varianza SC error
    Y_6_simu = A_6+B_6*X_6+randn(size(X_6)).*sd3;
    cov_6_simu=sum((X_6-mean(X_6)).*(Y_6_simu-mean(Y_6_simu)))./(numel(X_6)-1);
    hat_b_6_simu(i) = cov_6_simu/Sx2_6;
    hat_a_6_simu(i) = mean(Y_6_simu) - hat_b_6_simu(i)*mean(X_6);
end


%graficar distribucion de b_hat
figure;hold on;
mean_hat_b_simu=mean(hat_b_6_simu);
histogram(hat_b_6_simu,'Normalization','probability');
%se grafica media de b_hat
xline(mean_hat_b_simu,'r');
ylabel('probabilidad');
xlabel('b hat');
dim=[.15 .8 .2 0];
annotation('textbox',dim,'String',"Valor b:" + B_6,'FitBoxToText','on','FontSize',8);
hold off;

%graficar distribucion de a_hat
figure;hold on;
mean_hat_a_simu=mean(hat_a_6_simu);
histogram(hat_a_6_simu);
%se grafica media de a_hat
xline(mean_hat_a_simu,'r');
ylabel('probabilidad');
xlabel('a hat');
dim=[.15 .8 .2 0];
annotation('textbox',dim,'String',"Valor a:" + A_6,'FitBoxToText','on','FontSize',8);

%%funciones

% funcion de ejercicio 4
function SStotvar = SStot(Vec)

%vector vacio
Vec4 = [];
% se asigna el vector que se paso por la funcion
Vec4=Vec;
% se obtiene dimension del vector
[rows,cols]=size(Vec4);

% se pregunta el vector tenga las dimensiones correctas
if ((rows==1)&&(cols>0))||((rows>0)&&(cols==1))
    SS_tot_4 = sum ((Vec4 - mean(Vec4)).^2);
    SStotvar=SS_tot_4;
else
    disp("Wrong vector dimension"); % mensaje de error
end
end

%funcion de carga de archivo ejericicio 5
function floadTable=floadTable(path)

%lectura de tabla del disco local de la ruta del parametro.
floadTable = readtable(path);

end
