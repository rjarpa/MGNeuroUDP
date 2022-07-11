
Fs=1000;
dt=1/Fs;
t=dt:dt:2;


A1=2;
f1=5; % Hz
theta1=0;

A2=0.5;
f2=7;
theta2=0;

A3=3;
f3=1;
theta3=0;

A4=0.5;
f4=25;
theta4=0;


y1=A1*sin(2*pi*f1*t + theta1);
y2=A2*sin(2*pi*f2*t + theta2);
y3=A3*sin(2*pi*f3*t + theta3);
y4=A4*sin(2*pi*f4*t + theta4);


figure;
subplot(211); hold  on
plot(t,y1)
plot(t,y2)
plot(t,y3)
plot(t,y4)

subplot(212)
plot(t, y1+y2+y3+y4)

xlabel('Time (s)')