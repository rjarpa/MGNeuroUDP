%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 1

v=1:15;
mod(v-1,3)+1

%% 2

% recomputes randn

if randn>1
    disp('big.')
elseif randn>-1 && randn<0
    disp('small')
else disp('super-small.')
end

%% 3

% see function testNumberMatrix.m

%% 4

v = -5:1.1:6;

for i=1:length(v)

    % exercise 5
    if i==1, sqxy=zeros(length(v),2); end

    sqxy(i,1) = v(i);
    sqxy(i,2) = v(i)^2;
end

%% 6

sqxy(:,1) = v;
sqxy(:,2) = v.^2;

%% 7

asdf = 1;
if asdf==1
    data = 10;
elseif asdf==0
    data = 5;
end

data = 5+5*asdf;

%% 8

e = [1 4];

try
    if e(3)>6, disp('e(3) is big.'), end
catch me;
    if e(2)>6, disp('e(2) is big.')
    else disp('e(1) is my friend.')
    end
end


if numel(e)==3
    if e(3)>6, disp('e(3) is big.'); end
elseif numel(e)==2
    if e(2)>6, disp('e(2) is big.');
    else disp('e(1) is my friend.')
    end
end


%% 9

%% 10

for i=1:6
    i=3;
    varA(i) = i*43;
end

%% 11

a=1;
for i=1:numel(a)
    disp(i)
    a(i+1)=rand;
end

% i don't think it's possible

%% 12

i=3; i=rand(i);
i=[3 2]; r=rand(i); r(3,3);
i=[3 2]; i(1), i(2)
i=3; i(1), i(2)


%% 13

% option A
i=0;
while i<5
    i=i+1;
    fprintf('%g ',i)
end
fprintf('\n')


% option B
i=0;
while i<5
    fprintf('%g ',i)
    i=i+1;
end
fprintf('\n')

%%
