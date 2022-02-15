%% MATLAB for Brain and Cognitive Scientists (MIT Press 2017)
% mikexcohen@gmail.com
%
% This script contains solutions and tips for most exercises in the book.
% If you are struggling with an exercise not in this list, email me with an
% explanation of what you've already tried and what you need help with.

%% 8


% parameters that control neuron's behavior
a = .03;
b = .25;
c = -60;
d =   4;

V = -70;

u=b*V;
VV=[]; uu=[];

tau = 0.25;
tspan = 0:tau:1000;

% define time series of input
T1 = zeros(size(tspan));
T1(dsearchn(tspan',200):dsearchn(tspan',800)) = 14;

ampvals = linspace(1,30,100);
freqvals = linspace(1,60,80);
numspikes = zeros(length(freqvals),length(ampvals));

for fi=1:length(freqvals)
    for ai=1:length(ampvals)
        T1 = (sin(2*pi*freqvals(fi)*tspan/1000)+1)*ampvals(ai);

        u=b*V;
        VV=[]; uu=[];
        for t=1:length(tspan)

            V = V + tau*(0.04*V^2+5*V+140-u+T1(t));
            u = u + tau*a*(b*V-u);

            if V > 30 % there was a spike
                VV(end+1)=30;
                V = c;
                u = u + d;
            else % there was no spike
                VV(end+1)=V;
            end
            uu(end+1)=u;
        end

        peeks = find(diff(sign(diff(VV)))<0)+1;
        peeks(VV(peeks)<0) = [];
        numspikes(fi,ai) = numel(peeks);
    end
end

figure,clf
contourf(freqvals,ampvals,numspikes',40,'linecolor','none')
colormap hot
xlabel('Frequency (Hz)'), ylabel('Amplitude')

%%
