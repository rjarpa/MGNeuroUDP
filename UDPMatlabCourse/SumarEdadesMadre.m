ED= [-1, 27.26,22.12,27.51, 36.58,-1,-13,23.61,22.45,31.6,18.75,24.62,20.35,28.49,26.81,31.04,37.86,22.31,19.12 ];

%I = len(AA)


largo=20;
suma=0;

Validos=0
for(ii=1:1:20)
    edad = ED(1,ii) 
    if (edad==-1) || (edad<=10)
        ED(1,ii)=nan;
    
    end
        suma=suma+ED(1,ii)
    
    
    
   
end

promedioedad = suma/largo