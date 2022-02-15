function [A,B,C] = RJarpa_Tarea2_P2()

    AA=rand(7,9);
    
    A = AA ;
    disp("A:"+A);
    rows = 0 ;
    cols = 0;
    
    [rows,cols] = size(AA);
    sum = 0;
    for i=1:1:rows
        for j=1:1:cols         
            sum = sum + AA(i,j);
        end
    end
    
    B= sum;
    disp("B:"+B);
    
    sum = 0;
   
   for i=1:1:rows
        for j=1:1:cols
            if AA(i,j)>0.5
          
            sum = sum + AA(i,j);
            end
        end
    end
   
   C=sum;
    disp("C:"+C);
    
end