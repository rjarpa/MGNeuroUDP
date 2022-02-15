function [sse,outparams] = fitSigmoid(params,x,y)

% make sure it's column-format
x=x(:); y=y(:);

%% setup sigmoid

v = params(1); % amplitude of gaussian at peak
s = params(2); % width (aka standard deviation)
m = params(3); % x-axis point of peak lcation


% predicted value
predY = v./(1 + exp( -s.*(x-m) ) );

% predictors and sse (minimization objective)
outparams = [ v s m ];
sse = sum( (predY-y).^2 ) / sum( y.^2 );

% optional plotting
plot(x,y,'ro',x,predY,'k-'); drawnow; pause(.01)

%%
