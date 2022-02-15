%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 1, 2, 3


% convert counts to probabilities
x  = .01:.01:.99;
dp = bsxfun(@minus,norminv(x)',norminv(x));
rb = -bsxfun(@plus,norminv(x)',norminv(x))/2;

% % following code is for #3
% x  = norminv(.01:.01:.99);
% dp = bsxfun(@minus,x',x);
% rb = -bsxfun(@plus,x',x)/2;


% show the 2D d' space
clf
contourf(x,x,dp,80,'linecolor','none')
% imagesc(x,x,dp), axis xy
xlabel('False alarm rate')
ylabel('Hit rate')
hold on % we'll plot lines on top
axis square

% colors for isosensitivity curves
colorz = 'rbmk';

% the d' values
dp2plot = [ 1 1.5 2 2.5];
rb2plot = [.3 .5 .9 1.5];
tol = .01;

for dpi=1:length(dp2plot)

    % find points
    idx = find(dp>dp2plot(dpi)-tol & dp<dp2plot(dpi)+tol);

    % and plot isosensitivity curves
    [yi,xi] = ind2sub(size(dp),idx);
    plot(x(xi),x(yi),[ colorz(dpi) 'o-' ],'linew',1,'markersize',6,'markerfacecolor',colorz(dpi))



    % find points
    idx = find(rb>rb2plot(dpi)-tol & rb<rb2plot(dpi)+tol);

    % and plot isosensitivity curves
    [yi,xi] = ind2sub(size(rb),idx);
    plot(x(xi),x(yi),[ colorz(dpi) 'o-' ],'linew',1,'markersize',6,'markerfacecolor',colorz(dpi))

end

% set(gca,'xscale','li','yscale','log')

%% 5


load ../ch14/behavioralDataRK.mat
clf

for nbins = 4:40

    % and now discretize
    drank = ceil( nbins*tiedrank(beh(:,2))/length(beh) );

    % initialize and compute
    caf = zeros(nbins,2);
    for i=1:nbins
        caf(i,1) = mean(beh(drank==i,2));
        caf(i,2) = mean(beh(drank==i,1));
    end

    % and plot
    hold on
    plot(caf(:,1),caf(:,2),'o-','markerfacecolor','r','markersize',7)
end

xlabel('Average RT')
ylabel('Average accuracy')


%%
