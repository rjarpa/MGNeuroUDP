
continuo=true
while continuo == true
    mensaje = 'Diga un numero entre 1 y 1000 \n';
    x=input(mensaje);
    
    if x=='k'
        
        continuo=false
    else
        if isempty(x)
            disp("No ingreso valor");
        end
        
        if x<=1 || x>=1000
            disp('Numero fuera de rango\n');
        elseif x==999
            disp('EMPATAMOS!\n');
        else
            
            disp("Yo gano con el "+(x+1));
        end
        
    end
    
end