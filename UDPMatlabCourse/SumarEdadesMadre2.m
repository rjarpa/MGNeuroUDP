ED= [-1, 27.26,22.12,27.51, 36.58,-1,-1,3,23.61,22.45,31.6,18.75,24.62,20.35,28.49,26.81,31.04,37.86,22.31,19.12 ];

largo=length(ED);
suma=0;
validos=0;
for(ii=1:1:largo)
    edad = ED(1,ii) 
    if (edad==-1) || (edad<=10)
        ED(1,ii)=nan;
    
    else
        validos=validos+1
        suma=suma+ED(1,ii)
    end
   
   
end

promedioedad = suma/validos;
