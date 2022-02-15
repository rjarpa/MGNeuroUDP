%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 8

d = round(rand(10000,1)*(2345-14)+14);
clf
histogram(d,50)

dd = prctile(d,98);

dsort = sort(d);
dsort(round(.98*length(d)));


title([ 'Range: ' num2str(min(d)) ' - ' num2str(max(d)) '; 98%: ' num2str(dd) ])

%%
