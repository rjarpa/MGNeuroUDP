function [sm,bg] =  rango(A)
    sm=min(A,[],'all'); % This syntax is valid for MATLAB® versions R2018b and later.
    bg=max(A,[],'all'); % This syntax is valid for MATLAB® versions R2018b and later.
end