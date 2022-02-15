%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 1

amat = zeros(30,4);
whos
amat(31,10) = 1;
whos

%% 2

ages = [mouse.age];
ages = ages<70;

ages = [mouse.age]<70;

%% 3


% legal (version-dependent) but confusing
datamat = randn(20,1);
datamat(1:.5:end)

% legal but produces 1
1:4:3

% illegal (trying to combine row and column vectors
[ [1 2:3 4:5]  (6:10)' ]

% legal and OK
[ [1 2:3 4:5]; (6:10)  ]

% legal but potentially confusing
cvar = 4;-5

% legal but better would be ones(10,1)
var = ones(1,10)';

% legal but transposing 10 does nothing
var = [1:10'];

%% 4

0:.1:(2>1)

% these two are the same
(0:.1:2)>1
0:.1:2>1

%% 5

ary = [1:10 9:-1:1];
ary = ary+4;

ary==8

%% 6

clear a
clear a*

%% 7

nElecs = sum([mouse.numElectrodes]);

%% 8

amat = zeros(50,40);

amat(1:10,1:20) = 10;
amat(end-5:end,1:20) = 5;

%% 9

% 9a
4 + 5/4

% 9b
19 * 48^-4

% 9c
(4+3)/8

% 9d
4 + 3/8

% 9e
-(4 + 5^3 - .39) / (2^4 * 17.26)

%% 10

n = zeros(3,5)/0;
n = 3+ones(3,5)/0;
n = nan(3,5);

%% 11


%% 12

aMatrx = [1 3 2 3; 6 7 8 9]; % OK
aMatrx = [1 3 2 3; 5 3 6; 7 8 9]; % not OK
aMatrx = [1 3; 5 6; 7 8]; % OK
aMatrx = [1 3 2; 5 6; 7 8 9]; % not OK

%% 13

aMatrx + 4;
aMatrx .* 6.4;
