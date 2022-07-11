Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 90;             % Length of signal
t = (0:L-1)*T;        % Time vector



S=sin(2*pi*4*t)+1.5*sin(2*pi*12*t);

X=S+2.5*randn(size(t));

figure;
plot(t,X)

%%

Y=fft(X);

P2=2*sqrt(abs(Y/L).^2);
P1=P2(1:(L/2)+1);

P2=abs(Y/L).^2;
P1_2=P2(1:(L/2)+1);

P2=abs(Y/L);
P1_3=P2(1:(L/2)+1);


f=Fs*(0:(L/2))./L;

df=Fs/L;

f1=0:df:Fs/2;


figure;
hold on
plot(f,P1)
plot(f,P1_2,'r')
plot(f,P1_3,'k')

xlabel('Frequency (Hz)')
xlim([0 100])


%%


L=[1500 1000 500 250 150 100 50 5];

DF=Fs./L;



figure;

plot(L,DF,'ok')












