%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 2

t = -5:.01:5;
z = abs(mod(t,2)-.66) .* sin(2*pi*10*t) - .08*sin(2*pi*10.*(t-1))./(t-1);

clf
plot(t,z,'k','linew',2)

%% 6


% generate a triangle distribution
a = .2;
c = .6;
b = .9;
x = rand(1,10000);

y(x<c) = a + sqrt( x(x<c).*(b-a).*(c-a) );
y(x>c) = b - sqrt( (1-x(x>c)).*(b-a).*(b-c) );

% convert x and y into a distribution
[y,x] = hist(y,100);
[~,i]=sort(x);
x=x(i); y=y(i);
x=x(:); y=y(:);

for bi=1:length(x)

    % first piece
    x1 = [ones(bi,1) x(1:bi)];
    y1 = y(1:bi);
    b1 = (x1'*x1)\(x1'*y1);

    % second piece
    x2 = [ones(length(x)-bi,1) x(bi+1:end)];
    y2 = y(bi+1:end);
    b2 = (x2'*x2)\(x2'*y2);

    % evaluate model
    yHat = [b1(1)+b1(2)*x1(:,2); b2(1)+b2(2)*x2(:,2)];

    % predictors and sse (minimization objective)
    r2(bi) = 1 - (sum( (yHat-y).^2 ) / sum( y.^2 ));
end

plot(r2,'ks-','linew',2,'markersi',8,'markerfacecolor','w')
xlabel('breakpoint'), ylabel('R^2 model fit')

%% 9

cd('../ch29')

% parameters of the Gaussian
peak = 4;
fwhm = 1;
cent = 3;

x = -10:.1:10;

d = zeros(10,50);
noiselevels = linspace(0,4,10);
for ni=1:10

    for i=1:50
        gaus = peak*exp( -(x-cent).^2 / (2*fwhm^2) );
        gaus = gaus + noiselevels(ni)*randn(size(gaus));
        initParms = [   2     2      -2   ];
        funch = @(initParms) fitGaussian(initParms,x,gaus);

        [outparams,sse,exitflag,fmininfo] = fminsearch(funch,initParms);
        d(ni,i) = sum( (outparams-[peak fwhm cent]).^2 );
    end
end

plot(noiselevels,median(d,2),'ks-','linew',3)
xlabel('Noise level'), ylabel('Error')

%% 11

% weibull:
x = 0:.01:3;
k = 7;
l = 1;

w = (k/l) .* (x./l).^(k-1) .* exp( -(x./l).^k );

clf
plot(x,w,'linew',3)
title([ 'Parameters: k=' num2str(k) ', l=' num2str(l) ])

%% 15

x = [0 .05 .3 .7 .9 1]+1;

% initialize:  v   s   m
initParms = [  1  1.5  3.5   ];
funch = @(initParms) fitSigmoid(initParms,1:length(x),x);

clf
outparams = fminsearch(funch,initParms);

%%
