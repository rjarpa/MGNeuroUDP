%% varios
sin(2*pi());


Fs=1000;
dt=1/Fs;
t=dt:dt:2;
t=(0:1999)/Fs;


A1=1.5;
f1=10; % Hz
theta1=0;

A2=1.2;
f2=3.5;
theta2=0;


y1=A1*sin(2*pi*f1*t + theta1);
y2=A2*sin(2*pi*f2*t + theta2)




figure;
subplot(211); hold  on
plot(t,y1)
plot(t,y2)


subplot(212)
plot(t, y1+y2)

xlabel('Time (s)')





%% 1 


A1=1;

f1=1.5; % Hz
theta1=0;

Fs1=1; % frecuencia de muestreo
Fs2=10;
Fs3=50;

dt1=1/Fs1;
t1=dt1:dt1:2.5;

dt2=1/Fs2;
t2=dt2:dt2:2.5;

dt3=1/Fs3;
t3=dt3:dt3:2.5;


y1=A1*sin(2*pi*f1*t1 + theta1);
y2=A1*sin(2*pi*f1*t2 + theta1);
y3=A1*sin(2*pi*f1*t3 + theta1);



figure;
subplot(211); hold  on
plot(t1,y1)
plot(t2,y2)
plot(t3,y3)



%subplot(212)
%plot(t, y1+y2)

xlabel('Time (s)')


%% 2


Fs=1000;
dt=1/Fs;
t=dt:dt:2;

A1=1.5;  % Magnitude
f1=10; % Hz frecuencia sinosoidal
theta1=0; % Theta

A2=1.2;
f2=3.5;
theta2=0;

A3=1.0;
f3=5;
theta3=0;

A4=0.5;
f4=7.0;
theta4=0;

y1=A1*sin(2*pi*f1*t + theta1);
y2=A2*sin(2*pi*f2*t + theta2);
y3=A3*sin(2*pi*f3*t + theta3);
y4=A4*sin(2*pi*f4*t + theta4);



figure;
subplot(211); hold  on
plot(t,y1);
plot(t,y2);
plot(t,y3);
plot(t,y4);


subplot(212);
plot(t, y1+y2+y3+y4);

xlabel('Time (s)');




%% 3 


N=100

Fs=1000;
dt=1/Fs;
t=dt:dt:2;
theta1=0;

arrawaves=nan(N,numel(t));

for i=1:N

        arrawaves(i,:)=(1/i)*sin(2*pi*i*t + theta1);

end




figure;


subplot(211); hold  on

plot(t,arrawaves(1,:));
plot(t,arrawaves(10,:));
plot(t,arrawaves(100,:));


subplot(212)
plot(t, arrawaves(1,:)+arrawaves(10,:)+arrawaves(100,:));

xlabel('Time (s)');




for i=1:N

        arrawaves(i,:)=(1/i)*cos(2*pi*i*t + theta1);

end




figure;


subplot(211); hold  on

plot(t,arrawaves(1,:));
plot(t,arrawaves(10,:));
plot(t,arrawaves(100,:));


subplot(212)
plot(t, arrawaves(1,:)+arrawaves(10,:)+arrawaves(100,:));

xlabel('Time (s)');

