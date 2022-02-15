%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 1

zmat = zeros( round( max( randn(30,1) ) ) );

%% 2

N = 14;
randnums = rand(N,2);
rn_size = size(randnums);
zeromat = zeros(rn_size(1),1);

zeromat = zeros(N,1);

%% 3

d = randn(20,1);

i = sort(d);
maxval = i(end);


%% 4

[maxval,maxidx] = max([ 1 2 1 1 5 5 1 5 ])

maxidxes = find([ 1 2 1 1 5 5 1 5 ]==maxval);

%% 5

fprintf('%g, %g\n',maxval,maxidx);

%% 6

r = randn;

if r>.5
    fprintf('The value is %g and is greater than .5.\n',r)
end

%% 7

a = randn(4,3,2);

max(a,2)
mean(a,3)

%% 8

0/0
nan

%% 9

v = [1 0 0 1 NaN 1 NaN 0];

mean(v)
nanmean(v)
mean(v(isfinite(v)))

%% 10

8+2*randperm(6)

d = 10:2:20;
[~,i] = sort(randn(size(d)));
d(i)


%% 11

strfind('Hello, my name is Mike.','m')

%% 12

strncmp('Hello, my name is Mike.','Hell',1)

%% 13

fiveD = zeros(2,3,4,5,6);

prod(size(fiveD))

numel(fiveD)

%% 14

asdf=
    4;

asdf=4; asdf2=6;

asdf = ...
    4;

%% end
