% simulation parameters
%means
m1= 300;
m2= 450;
%deviations
s1=100;
s2=100;
% sample size
n=30;
% create data
group1=m1 + s1*randn(n,1);
group2=m2 + s2*randn(n,1);

% plot parameters
fsize=14;
ms=22;
lw=4;
col1=[0.6 0.4 0.1];
col2=[0.1 0.4 0.6];

%produce plot
fig1=figure;

ax=axes('parent', fig1, 'tickdir', 'out', 'xtick', [0 1], 'xticklabel', {'g1', 'g2'}, 'fontsize', fsize);
hold(ax,'all')

%create jittered X
X=randn(n,1)/15;

% plot data points
plot(X, group1, 'marker', '.', 'markersize' , ms, 'linestyle', 'none', 'color', col1)
plot(X+1, group2, 'marker', '.', 'markersize' , ms, 'linestyle', 'none', 'color', col2)

%plot means
plot([-0.2 0.2], [mean(group1) mean(group1)], 'linewidth',lw, 'color', col1)
plot([0.8 1.2], [mean(group2) mean(group2)], 'linewidth',lw, 'color', col2)

ylabel('Variable')
xlabel('Treatment')


print(fig1, 'TwoGroups', '-dpng', '-r350')





