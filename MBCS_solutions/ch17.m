%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 1


x = [ 1*randn(1,1000) .5*randn(1,1000) ];
whos x

%% 2

% run eigface code from ch17

eigvals = 100*diag(facevals)./sum(diag(facevals));

clf
plot(eigvals,'o-')

disp([ num2str(sum(eigvals(end-50:end))) '% variance from first 50 components' ])


cumvar = cumsum(eigvals(end:-1:1));

targpct = 73;
[~,compnum] = min(abs(cumvar-targpct));
disp([ 'First ' num2str(compnum) ' components account for ' num2str(targpct) '% of the variance.' ])

%% 5


% data
x = [ 1*randn(1000,1) .3*randn(1000,1) .6*randn(1000,1)];

% rotation matrix
th = pi/4;
R1 = [ cos(th) -sin(th) -cos(th);
       sin(th)  cos(th) -sin(th);
       0        0       1];

% rotate data
y = x*R1;

% PCA of x (original data)
x = bsxfun(@minus,x,mean(x,1));
covmat = (x'*x) / length(x);
[evecsX,evalsX] = eig(covmat);

% PCA of y (correlated data)
y = bsxfun(@minus,y,mean(y,1));
covmat = (y'*y) / length(y);
[evecsY,evalsY] = eig(covmat);


figure(2), clf
% plot original data
subplot(121)
plot3(y(:,1),y(:,2),y(:,3),'m.','markersize',5)
set(gca,'xlim',[-3 3],'ylim',[-3 3],'zlim',[-3 3])
hold on

evalsY = evalsY*2;
plot3(evalsY(1,1)*[0 evecsY(1,1)],evalsY(1,1)*[0 evecsY(2,1)],evalsY(1,1)*[0 evecsY(3,1)],'k','linew',4)
plot3(evalsY(2,2)*[0 evecsY(1,2)],evalsY(2,2)*[0 evecsY(2,2)],evalsY(2,2)*[0 evecsY(3,2)],'k','linew',4)
plot3(evalsY(3,3)*[0 evecsY(1,3)],evalsY(3,3)*[0 evecsY(2,3)],evalsY(3,3)*[0 evecsY(3,3)],'k','linew',4)
xlabel('x-axis'), ylabel('y-axis')
axis square, rotate3d on

% compute component scores
pc1 = y*evecsY(:,1);
pc2 = y*evecsY(:,2);
pc3 = y*evecsY(:,3);

subplot(133)
plot3(pc3,pc2,pc1,'m.')
set(gca,'xlim',[-5 5],'ylim',[-5 5])
xlabel('PC1 axis'), ylabel('PC2 axis')
axis square

%% 6

d = randn(9);

[evecs,evals] = eig(d);

sqrt(sum(abs(evecs).^2,1))

%% 9


% run eigface code from ch17

sse = zeros(200,2);

for nPCs=1:200
    facescores = allfaces*facevecs(:,end-nPCs+1:end);
    sse(nPCs,1) = mean( sum(( allfaces - facescores*facevecs(:,end-nPCs+1:end)' ).^2 ,2) );
    sse(nPCs,2) = std(  sum(( allfaces - facescores*facevecs(:,end-nPCs+1:end)' ).^2 ,2) );
end

clf
patch([ 1:200 199:-1:1 ]',[ sse(:,1)+sse(:,2); sse(end-1:-1:1,1)-sse(end-1:-1:1,2) ]','m','facealpha',.4,'edgecolor','b')
hold on
plot(sse(:,1),'k','linew',4)
xlabel('Number of components')
ylabel('Reconstruction error')


%% 11

covmat = [  1 .2  .9;
           .2  1  .3;
           .9 .3  1];

[evecs,evals] = eig(covmat);

n=100000;
newdat = randn(n,3) * (evecs*sqrt(evals))';

newdat = bsxfun(@minus,newdat,mean(newdat,1));
newdat = bsxfun(@rdivide,newdat,std(newdat,[],1));
newdat'*newdat/(n-1)

%% 14


% data
x = [ 1*randn(1000,1) .4*randn(1000,1) ];

% rotation matrix
th = pi/4;
R1 = [ cos(th) -sin(th); sin(th) cos(th) ];

% rotate data
y = x*R1;

% PCA of y (correlated data)
y = bsxfun(@minus,y,mean(y,1));
covmat = (y'*y) / length(y);
[evecsY,evalsY] = eig(covmat);


clf
% plot original data
subplot(131)
plot(y(:,1),y(:,2),'m.','markersize',5)
set(gca,'xlim',[-5 5],'ylim',[-5 5])
hold on
plot(evalsY(1,1)*[0 evecsY(1,1)],evalsY(1,1)*[0 evecsY(2,1)],'k','linew',4)
plot(evalsY(2,2)*[0 evecsY(1,2)],evalsY(2,2)*[0 evecsY(2,2)],'k','linew',4)
xlabel('x-axis'), ylabel('y-axis')
axis square
title('original space with PCs')


% compute component scores
pc1 = y*evecsY(:,1);
pc2 = y*evecsY(:,2);

subplot(132)
plot(pc2,pc1,'m.')
set(gca,'xlim',[-5 5],'ylim',[-5 5])
xlabel('PC1 axis'), ylabel('PC2 axis')
axis square
title('PC space')



%%% now for ica
addpath('../ch17')
w = jader(x');
c = w*x';

subplot(133)
plot(c(1,:),c(2,:),'m.')
set(gca,'xlim',[-5 5],'ylim',[-5 5])
xlabel('IC1 axis'), ylabel('IC2 axis')
axis square
title('IC space')

%% 15

% data
x = [ 1*randn(1000,1) .4*randn(1000,1) ];

% rotation matrix
th = pi/4;
R1 = [ cos(th) -sin(th); sin(th) cos(th) ];

% rotate data
y = x*R1;

% PCA of y
y = bsxfun(@minus,y,mean(y,1));
covmat = (y'*y) / length(y);
[evecs,evals] = eig(covmat);

yHat = y*evecs*sqrt(inv(evals));


clf,
plot(y(:,1),y(:,2),'m.','markersize',40), hold on
plot(yHat(:,1),yHat(:,2),'k.','markersize',20)

%%
