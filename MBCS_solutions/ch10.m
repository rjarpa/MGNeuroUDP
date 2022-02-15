%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 2

v1 = [1 -3];
v2 = [3  1];

plot([0 v1(1)],[0 v1(2)],[0 v2(1)],[0 v2(2)])
axis([-5 5 -5 5])
legend({'v1';'v2'})
title([ 'Dot product: ' num2str(dot(v1,v2)) ])

%% 3

aNumber = randn;
round(10*aNumber)/10
round(100*aNumber)/100

%% 5

plot3([0 v2(1)],[0 v2(2)])
a=rand(2,3,4); a'
inv(rand(2,3))

%% 6

a = [1 2; 2 4];

inv(a)
p = pinv(a);
p*a'
a'*p

%% 7

a = randn(2,3);
subplot(121), imagesc(a'*a), axis image
subplot(122), imagesc(a*a'), axis image

%% 9

v = randn(3,1);
sum(v.*v)
dot(v,v)

%% 10

A = [ 1   3   3;
      0  -1  -2;
      7   2  -17];

rank(A)

%% 11

%% 12

m = randn(3,4);
v = randn(1,4);

m*v

m.*repmat(v,3,1)

%% 13

bsxfun(@times,m,v)


%% 14

diag([2 1 5 6])
diag( diag(repmat(1,10,1)) )

diag(rand(4))

%% 15

v1 = [1 3 2];
v2 = [5 2 3];

v1*v2'

%%
