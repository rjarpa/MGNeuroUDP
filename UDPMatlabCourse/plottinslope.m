% Data
a = -2;
b = 3;
c = 8;
x = 3;
y = -2/3;
% Now the plotting.
pp = [-a,-c]/b; % Polynomial as MATLAB likes it.
X = linspace(x-1,x+1);  % Where to plot the line...
pv = polyval(pp,X);  % Evaluate the polynomial.
plot(X,pv,'-b',x,y,'*r')