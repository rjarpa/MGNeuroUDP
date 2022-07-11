
% Ejercicios 6

% 1
T=1.5;  % tiempo total en segundos
Fs=1024;   % frec muestro, en Hz

%1a
LN=Fs/2;  %Lim de Nyquist

%1b
N=T*Fs;   %Num total de muestras de la serie de tiempo

nFourier=(N/2)+1;  % num de elementos de la transformada Y(f)

df=Fs/N;  %resolución en frecuencia (Hz)

%% 2

%2a
T=5.5;
Fs=1024;
dt=1/Fs;
t=dt:dt:T;

N=Fs*T;

A1=1;
A2=0.5;
f1=15;
f2=45;
phi1=0;
phi2=pi;


y1=A1*sin(2*pi*f1*t+phi1);
y2=A2*sin(2*pi*f2*t+phi2);

R=10*rand(size(y1));  %ruido
%2b
figure;
subplot(311)
hold on
plot(t,y1,'r')
plot(t,y2,'k')
xlim([1 1.55])
subplot(312)
plot(t,y1+y2)

xlim([1 1.55])
subplot(313)
plot(t,y1+y2+R)
xlabel('Time (s)')
xlim([1 1.55])
%% 3



%3a
Y=fft(y1+y2+R);  % resultado de fft (complejo)
P2=abs(Y).^2;  %espectro de poder doble
P1=P2(1:(N/2)+1);  % espectro de poder single

df=Fs/N;

f=0:df:(Fs/2);


figure;
plot(f,P1)
xlabel('Frequency (Hz)')
ylabel('Power')
xlim([0 120])




