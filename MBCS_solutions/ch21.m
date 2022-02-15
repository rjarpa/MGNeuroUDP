%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 4

ns = linspace(1000,10000000,10);

dfa = zeros(size(ns));
nScales = 20;

for ni=1:length(ns)

    data = ( randn(1,round(ns(ni))) );
    data = cumsum(data-mean(data));

    ranges  = round([.01 .2]*ns(ni));
    scales  = ceil(logspace(log10(ranges(1)),log10(ranges(2)),nScales));
    rmses   = zeros(size(scales));


    for scalei = 1:length(scales)

        % epoch
        n = floor(ns(ni)/scales(scalei)); % number of epochs
        epochs = reshape( data(1:n*scales(scalei)) ,scales(scalei),n)';

        % detrend
        depochs = detrend(epochs')';

        % RMS and average
        rmses(scalei) = mean( sqrt( mean(depochs.^2,1) ) );
    end

    % fit a linear model to quantify scaling exponent
    A = [ ones(length(scales),1) log10(scales)' ];
    tmp = (A'*A) \ (A'*log10(rmses)');

    dfa(ni) = tmp(2);

end

clf
plot(ns,dfa,'o-','linewi',2,'markersize',15,'markerfacecolor','k')
set(gca,'ylim',[0 1])
xlabel('N'), ylabel('DFA')

%% 7

g = gausswin(100,10);
gg = abs(g-.5);

haf = find(diff(sign(diff(gg)))>0)+1;
haf(gg(haf)>.1)=[];

clf
plot(g,'linew',3)
hold on
plot(haf,g(haf),'ro','markersize',10,'markerfacecolor','k')


%%
