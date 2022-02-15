%Taller_EJ1_P9
%ecuacion de ka recta y= A + Bx

%funcional y=A+Bx

nSimul=100
A=2
B=4

x0=randi([1 nSimul],nSimul,1)
x1=randi([1 nSimul],nSimul,1)


y0=A+(B*x0)
y1=A+(B*x1)


%colores
len = length(x0)
figure
plot([x0(1) x1(1)],[y0(1) y1(1)],'Color',RGB)
hold on

for j=2:len
RGB=rand(3,1);
plot([x0(j) x1(j)],[y0(j) y1(j)],'Color',RGB)
end