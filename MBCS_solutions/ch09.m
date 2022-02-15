%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 1

pic = imread('saturn.png');
contour(pic(:,:,1),10,'linecolor','m')

%% 4

randImg = round( 255*rand(800,600,3) );
randImg = 255*round( rand(800,600,3) );
imagesc(randImg)

%% 5

ri = randn(10);
subplot(121), pcolor(ri)
subplot(122), imagesc(ri), axis xy

%% 8

x = -8:.0132:8;
y = (x./5).^3 + 1./sin(x.^2) - 1;

clf
plot(x,y)
set(gca,'ylim',[-100 100])

%% 9

plot(x,log(x),x,log10(x),x,log2(x),'linew',3)
legend({'log';'log_1_0';'log_2'})

%% 10

fibseq = [0 1];
for i=3:1000
    fibseq(i) = fibseq(i-2)+fibseq(i-1);
end

plot(log(fibseq))

%% 16

x=-5:.1:5;

plot(x,tan(x))

%%
