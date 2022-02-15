%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 1

% 'measured' data
data      = round(randn(1,6)*5);
datatimes = 1:6;

% requested (interpolated) time points
newtimes  = 1:.001:6;

F = griddedInterpolant(datatimes,data,'spline');
newdata = F(newtimes);


% padded data
zeropadN = length(data)*10;
x = linspace(1,length(data)+1-length(data)/zeropadN,zeropadN);
datapad = real( ifft( fft(data)/length(data),zeropadN)*zeropadN );



clf,
plot(datatimes,data,'ko-','markersize',15,'markerfacecolor','k'), hold on
plot(newtimes,newdata,x,datapad,'linew',2)
legend({'orig';'interp';'zero-pad'})
%
% clf
% plot(datatimes,data,'ko-','markersize',20,'markerfacecolor','k'), hold on
% plot(x,datapad,'linew',2)

%% 2

% original data
data  = randn(3000,1);
srate = 1000;
time  = 0:1/srate:3-1/srate;

dsfact = 5;

% downsampled
datads = data(1:dsfact:end);
timeds = time(1:dsfact:end);


% upsampled via spline
F = griddedInterpolant(timeds,datads,'spline');
dataupSpl = F(time);

% upsampled via linear
F = griddedInterpolant(timeds,datads,'linear');
dataupLin = F(time);

clf
subplot(211)
plot(time,data,'m'), hold on
plot(time,dataupSpl,'r')
plot(time,dataupLin,'k')
set(gca,'xlim',[1 1.2])


subplot(212)
hz = linspace(0,srate/2,floor(length(time)/2)+1);
fOrg = 2*abs(fft(data)/length(time));
fSpl = 2*abs(fft(dataupSpl)/length(time));
fLin = 2*abs(fft(dataupLin)/length(time));

plot(hz,fOrg(1:length(hz)),'m'), hold on
plot(hz,fSpl(1:length(hz)),'r'), hold on
plot(hz,fLin(1:length(hz)),'k'), hold on
legend({'orig';'spline';'linear'})

%% 3

%% 2D interpolation using real EEG data

% load some sample EEG data
load ../ch13/EEGexample.mat

% convert polar to cartesian coordinates
[eX,eY] = pol2cart(pi/180*[chanlocs.theta],[chanlocs.radius]);
clf

intfax = round(linspace(5,200,16));

for inti=1:length(intfax)

    % interpolation factor, and define grid spacing
    intFact = intfax(inti);
    interpX = linspace(min(eX),max(eX),intFact);
    interpY = linspace(min(eY),max(eY),intFact);

    % now define grid in which to interpolate
    [gridX,gridY] = ndgrid(interpX,interpY);


    % now define the interpolation object, this time using scatteredInterpolant
    F = scatteredInterpolant(eX',eY',eeg(:,300),'linear','none');
    interpDat = F(gridX,gridY);


    % image the interpolated map
    subplot(4,4,inti)
    imagesc(interpX,interpY,interpDat')
    axis off, axis image
    axis([-.7 .6 -.6 .6])

    % draw actual electrode positions
    hold on
    plot(eX,eY,'ko','markerfacecolor','w','markersize',2)
    title([ 'Interpolation factor ' num2str(intfax(inti)) ])
end

%% 4

[~,idx] = sort(eX);
[~,idy] = sort(eY);

newx = round(eX(idx)*50+50);
newy = round(eY(idy)*50+50);

[x,y] = ndgrid(newx,newy);

edat = zeros(size(x));
for i=1:64
    edat( newx(idx(i)) , newy(idy(i)) ) = eeg(i,300);
end


Flin  = griddedInterpolant(x,y,edat,'linear');

grid = zeros(100);

%% 7

old_srate = 1000;
new_srate =  300;

upsample_to = lcm(old_srate,new_srate);
downsample_by = upsample_to/new_srate;

disp([ 'upsample to ' num2str(upsample_to) ' then skip by ' num2str(downsample_by) ])


%%
