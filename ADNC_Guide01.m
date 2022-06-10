%% primero


% 1 segundos 1 HZ
% 0.1 segundos 10 HZ
% 0.01 segundos 100 HZ
% 0.001 segundos 1000 HZ

%clase
delta_t=0.001
T=800
vector=(0:delta_t:T)'


%% guia de ejercicios

%1
T=20
Fs_a=50

N_a=Fs_a*T
delta_t_a=T/N_a
arra_a = 0:delta_t_a:T

%1.b
Fs_b=500

N_b=Fs_b*T
delta_t_b=T/N_b
arra_b = 0:delta_t_b:T


Fs_c=2040

N_c=Fs_c*T
delta_t_c=T/N_c
arra_c = 0:delta_t_c:T

%2

N_2=5000
S1=randn(1,N_2)
Fs_2=250
T=5000/Fs_2 %segundos
delta_t_2=T/N

S2=0:delta_t_2:T


% 3 Z



%Construya una nueva señal aleatoria S2 -> S1 y su correspondiente vector de 
% tiempo (S2), asumiendo que fue muestreada a 1020 Hz y que tiene una duración de 5.2 segundos.
%a. ¿Cuánto tiempo transcurre entre cada toma de muestras?
%b. ¿Cuántas muestras tiene S2?

Fs_3=1020
T_3=5.2
N_3=Fs_3*T_3
delta_t_3=T_3/N_3
S1_3=randn(1,N_3)
S2_3=0:delta_t_3:T_3 % serie de tiempo


%% 4

Fs_4= Fs_3/2

%% 5
%Tanto para S1 como para S2, construya vectores 
% de tiempo en que 
% el tiempo = 0 corresponda a:
%a. El momento en que ha transcurrido un 50% 
%       de la serie de tiempo
%b. El momento en que ha transcurrido 0.5 
%       segundo desde el inicio de la serie de tiempo.


%S1_5_a = S1_3(N_3/2:N_3)
S1_5_a = S1_3(N_3/2:N_3)
%S2_5_a = S2_3(N_3/2:N_3)  % tiempo
S2_5_a = 0:delta_t_3:T_3*0.5  % tiempo


N_at_5_b=0.5/delta_t_3 % cuantas muestras en 
N_at_5_b_fs=Fs_3*0.5 % 

%S1_5_b = S1_3(N_at_5_b:N_3)
%S2_5_b = S2_3(N_at_5_b_fs:N_3)  % tiempo
S2_5_b = 0:delta_t_3:T_3-0.5  % tiempo


% 6 
%6. Construya un vector de tiempo para una serie de duración de 950 ms, 
% con una frecuencia de muestreo de 30000 Hz.

Fs_6=30000
T_6=0.95
N_6=Fs_6*T_6
delta_t_6=T_6/N_6
%S1_6=randn(1,N_6)
S2_6=0:delta_t_6:T_6 % serie de tiempo


%7 Construya tres vectores de tiempo, cada uno con una frecuencia de
% muestreo diferente, pero todos con el mismo número de elementos.





N_7=1500
T_7_1=300
T_7_2=30
T_7_3=3

Fs_7_1=N_7/T_7_1
Fs_7_2=N_7/T_7_2
Fs_7_3=N_7/T_7_3

delta_t_7_1=1/Fs_7_1
delta_t_7_2=1/Fs_7_2
delta_t_7_3=1/Fs_7_3


%S1_6=randn(1,N_6)
S2_7_1=0:delta_t_7_1:T_7_1 % serie de tiempo
S2_7_2=0:delta_t_7_2:T_7_2 % serie de tiempo
S2_7_3=0:delta_t_7_3:T_7_3 % serie de tiempo


%8 Construya tres vectores de tiempo, todos de la misma duración 
% en segundos, pero cada uno con diferente número de elementos.


T_8=800

delta_t_8_1=0.003
delta_t_8_2=0.03
delta_t_8_3=0.3

N_8_1=T_8/delta_t_8_1
N_8_2=T_8/delta_t_8_2
N_8_3=T_8/delta_t_8_3

S2_8_1=0:delta_t_8_1:T_8
S2_8_2=0:delta_t_8_2:T_8
S2_8_3=0:delta_t_8_3:T_8

% 9
% En un cierto experimento de neurociencia cognitiva, 
% cada trial dura 1250 ms.


N_9=1000/1250 % cantidad de muestras por segundo
%delta_t=1/1250 
delta_trial_9=1/N_9


% a. Construya un vector de tiempo que sirva para cada trial,
%     suponiendo que la frecuencia de muestreo es 1000 Hz.


Fs_9_a=1000
T_9=N_9/Fs_9_a
%S2_9_a=0:delta_t_9:10*delta_t_9*10
%S2_9_a=(0:0.001:10*1.25*10)'
S2_9_a=(1:1:1250)';
S2_9_a=S2_9_a/1000;
%S2_9_a=(0:0.001:1.25)';

%b. Construye 10 series de tiempo (números aleatorios) 
%   correspondientes a 10 trials de este experimento.

N_9_b=1250
%S1_9_arra=[]


S1_9_arra=randn(N_9_b,10)

%c. Normaliza el vector de tiempo usando como tiempo = 0 
%    el momento de presentación
%   del estímulo, que ocurre 350 ms luego de iniciado el trial.

S2_9_d=S2_9_a-.350;


%d. Grafica algunos trials utilizando el vector de tiempo normalizado.

figure;
%plot(S2_9_d, S1_9_arra(:,[2:4]))
plot(S2_9_d, S1_9_arra(:,[2]))
figure;
%plot(S2_9_d, S1_9_arra(:,[2:4]))
plot(S2_9_d, S1_9_arra(:,[3]))



%% 11


n_trials=5
c_channels=10
s_subjects=20

arra_11=randn(n_trials,c_channels,s_subjects);

arra_11_show=[]

for i = 1:s_subjects
   
    arra_11_show(i).subject=i
    arra_11_show(i).trialschannel=arra_11(:,:,i);
end