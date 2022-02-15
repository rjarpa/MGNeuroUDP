M1=randi(500,500)
M2=uint8(M1)

f1=figure
plot(M1)
f2=figure
plot(M2)

figure,pcolor(M1), shading flat
figure,pcolor(M2), shading flat
