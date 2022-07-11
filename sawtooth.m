Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1600;             % Length of signal
t = (0:L-1)*T;        % Time vector





S1=(1/1)*sin(2*pi*1*t);
S2=(1/2)*sin(2*pi*2*t);

N=200;


S=nan(numel(t),N);
for f=1:2:N

    S(:,f)=(1/f)*sin(2*pi*f*t);

end

figure;
plot(t,nansum(S,2))
xlabel('Time (s)')
title(['N=' num2str(N)])

%%
figure;
plot(t,S)
xlabel('Time (s)')
title(['N=' num2str(N)])