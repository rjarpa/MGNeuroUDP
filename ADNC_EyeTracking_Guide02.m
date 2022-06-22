
clear all;
load('Example_EyeTracking_Data')
%1


T=917545/1000 % tiempo en segundos

S2 = EyeDataMatrix(:,1);

LeftEyeX = EyeDataMatrix(:,2);
LeftEyeY = EyeDataMatrix(:,3);

RightEyeX = EyeDataMatrix(:,5);
RightEyeY = EyeDataMatrix(:,6);

T_Start = EyeDataMatrix(1,1);
T_End = EyeDataMatrix(length(LeftEyeX),1);
T = T_End-T_Start;

S3 = S2-T_Start;
S3=S3/1000;

figure; 
%plot(S2,[LeftEyeX LeftEyeY])

plot(LeftEyeX,LeftEyeY)
figure;
plot(S2,LeftEyeX,S2,LeftEyeY)
XX=0:1920

figure;
hold on
plot(LeftEyeX,LeftEyeY)

xlim([0 1920])
ylim([0 1080])
%plot(S2,LeftEyeY)



% 2 


%hola2()
idx=20;

Fs=500
start=EyeDataMatrix(1,1)

t1=EyeDataMatrix(:,1);
tevents=1

idcs_events = [time_events(1,1)-start,time_events(2,1)-start];

idcs_events = idcs_events / 1000

idcs_events=idcs_events/0.002
idcs_events=idcs_events*Fs
%idcs=[idx idx+1499]

idcs=[idcs_events(1),idcs_events(2)]

EyeDataMatrix2=[EyeDataMatrix(:,1)-start EyeDataMatrix(:,[2 3])]
ST=EyeDataMatrix2(idcs(1):idcs(2),2) %posit x

t=EyeDataMatrix2(idcs(1):idcs(2),1)./1000;
t=t-t(1);

figure;

plot(t,ST)

t1=EyeDataMatrix(idx,1);

%title("t inicial=" numrstr())

% plotEpochs(S3,LeftEyeX,LeftEyeY,10,3);


%% listado de funcionaes
%function value_p_permuta=p_permuta(arraPermuta,valor_ori) 

function test()

display('hola')

end

function v_epoch=plotEpochs(OriSerieT,OriSerieX,OriSerieY,Start,Duration)


Fs=1/0.02 
STemp=OriSerieT(Start:Start+Duration)
STemp2=STemp-lenght(STemp)

SX=OriSerieX(Start*1000,Duration*1000)
SY=OriSerieY(Start*1000,Duration*1000)

figure; 
%plot(S2,[LeftEyeX LeftEyeY])
hold on
plot(STemp2,SX,'k')
plot(STemp2,SY,'g')


v_epoch=true

end

