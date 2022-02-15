function y = calculaPromedio(ED)
    largo=length(ED);
    suma=0;
    validos=0;
    for ii=1:1:largo
        edad = ED(1,ii);
        if (isnan(edad)) || (edad<=10)
            ED(1,ii)=nan;
        else
            validos=validos+1;
            suma=suma+ED(1,ii);
        end


    end

    promedioedad = suma/validos;
    y=promedioedad;

end