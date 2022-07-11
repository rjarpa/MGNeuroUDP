clear all
%% 4
%escriba un codio que le permita, dado un vedctor de datos cualquiera calcular la suna de cuadrados

% #### Hacer la funcion
Vec4=2+3.*randn(10,1)

SS_tot_4=var(Vec4);

SS_tot_4 = sum ((Vec4 - mean(Vec4)).^2)
%df=numel(Vec4)-1;
%media = mean(Vec4);
%v = SS/df

%%  5

%a

AGEHOLEST=load('AGECHOLEST.mat').AGECHOLEST

age_x=AGEHOLEST(:,1)
chol_y=AGEHOLEST(:,2)

figure;hold on;

plot(age_x,chol_y,'ok')

xlabel('age')
ylabel('cholesterol')

SS_tot_y_5 = sum((chol_y- mean(chol_y)).^2)
%df_tot_y_5 = numel(chol_y)-1
%v_y_5=SS_tot_y_5/df_tot_y_5
%SS_y=var(chol_y)

SS_tot_x_5 = sum((age_x- mean(age_x)).^2)
%df_tot_x_5 = numel(age_x)-1
%v_x_5=SS_tot_x_5/df_tot_x_5
%SS_x=var(age_x)



%b
cov_b= cov(age_x,chol_y)
cov_b= cov_b(2,1)

%c
Sxy = cov(age_x,chol_y)
Sxy = Sxy(2,1)
Sy2 = var(chol_y)
Sx2 = var(age_x)

b_hat_5 = Sxy/Sx2
a_hat_5 = mean(chol_y) - b_hat_5*mean(age_x)
%y= a +bx

X_5=[min(age_x) max(age_x)]
Y_5=a_hat_5 + b_hat_5  .*X_5

%X_5_M=[min(age_x) max(age_x)]
%Y_5_M=[mean(chol_y) mean(chol_y)]
%X_5_M=[min(x) max(x)]
%Y_5_M=[mean(y) mean(y)]

%d
plot(X_5,Y_5)
%plot(X_5_M,Y_5_M)

hold on;
%% 6

A_6=2;
B_6=3;

%a

X_6=1:20;
Y_6=A_6+B_6.*X_6+randn(size(X_6)).*4;

Sxy_6_r = cov(X_6,Y_6)
%se obtiene el data que nos sirve entre X e Y
Sxy_6_r = Sxy_6_r(2,1)
Sx2_6_r = var(X_6)

b_hat_r=Sxy_6_r/Sx2_6_r
a_hat_r=mean(Y_6)-b_hat_r*mean(X_6);

Y_est=a_hat_r+b_hat_r*X_6;

SS_err=sum((Y_6-Y_est).^2)
df_err=numel(X_6)-2
var_err=SS_err/df_err


%sigma en 3
%sd=3
sd=sqrt(var(Y_6))
sd2=sqrt(var(Y_est))
sd3=sqrt(var_err)

%b
%tamaño del arreglo generado en el punto 1
vsize=size(X_6)
%se simula valores de y utilizando media 0 y lo que contenga variable sd
%como distribucion
Y_6_e = A_6+B_6*X_6+randn(vsize).*sd3;
%se grafica resultado 
figure;
plot(X_6,Y_6_e,'ok'); hold on


%c 
%se busca los valores de a hat y b hat utilizando la recta que minimiza la
%suma de cuadrados
%se calcula la covarianza
Sxy_6 = cov(X_6,Y_6_e)
%se obtiene el data que nos sirve entre X e Y
Sxy_6 = Sxy_6(2,1)

%se sacan las varianzas de Y y X
Sy2_6 = var(Y_6_e)
Sx2_6 = var(X_6)

Rxy_6= Sxy_6/(Sx2_6*Sy2_6)

%obtenemos el valor de b hat
hat_b_6 = Sxy_6/Sx2_6
%obtenemos el valor de a hat
hat_a_6 = mean(Y_6_e) - hat_b_6*mean(X_6)

%simulamos los valores que se obtienen con a y b hat

%Y_6_i= hat_a_6 + hat_b_6.*X_6;
% graficamos en otro color 
%plot(X_6,Y_6_i,'og');

%c

%graficamos la recta que minimiza la suma de cuadrados
XX_6=[0 20]
YY_6=hat_a_6 + hat_b_6  .*XX_6

plot(XX_6,YY_6)


%d 
%Estimar la distribucion de b
nSims = 500
for i=1:nSims
    Y_6_simu = A_6+B_6*X_6+randn(vsize).*sd3;
    cov_6_simu=sum((X_6-mean(X_6)).*(Y_6_simu-mean(Y_6_simu)))./numel(X_6)
    hat_b_6_simu(i) = cov_6_simu/Sx2_6
    hat_a_6_simu(i) = mean(Y_6_simu) - hat_b_6_simu(i)*mean(X_6)
end

figure;
histogram(hat_b_6_simu)
figure;
histogram(hat_a_6_simu)


% viernes de las 5  hasta el mates antes de lac 

