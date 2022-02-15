%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 1

all=dir;

all([all.isdir])=[];
all = all([all.isdir]==0);
% the same

%% 2

this is a text file with mixed strings and numbers. 
each row contains different information, some useful and some useless.
we'll use matlab to read in each line separately, figure
out whether to keep or trash that line, and extract the data we want. 

in this file, label-value data pairs are separated by tabs. it's the one 
useful thing we have to go on here. 


behavioral data begin on the following line
trial	1	choice	2	rt	450	accuracy	1
choice	2	trial	2	accuracy	0	rt	830
well, i could go on and on, but by this time you'll get the idea

%% 3

csv = csvread('../ch08/somedata.csv')

%% 5

tic;
for i=1:100000, str2num('4'); end
t(1)=toc;


tic;
for i=1:100000, sscanf('4','%g'); end
t(2)=toc


%%
