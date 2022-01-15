clear all
[NumData,~,AllData]=xlsread('TREES.csv')

Xdata=NumData(:,2);
Ydata=NumData(:,3);

fig1=figure;
fsize=14;

ax=axes('parent',fig1,'fontsize',fsize,'tickdir','out');
hold(ax,'all')
plot(Xdata,Ydata,'ok')
xlabel('Height');
ylabel('Volume');
print('Height_vs_Volume', '-dpng','-r350' ) % dot per inch

%% a

n=numel(Xdata);
temp=sum((Xdata-mean(Xdata).*(Ydata-mean(Ydata))));
Covar=temp/(n-1);
B=Covar/var(Xdata);
A=mean(Ydata)-B*mean(Xdata);

Xplot=[min(Xdata) max(Xdata)];
Yplot=A+B.*Xplot;
plot(Xplot,Yplot,'linewidth',2);

Ymodel=A+B*Xdata;

r=Covar/(std(Xdata)*std(Ydata));
r_sqr=r*r;

SS_model=sum((mean(Ydata)-Ymodel).^2)
SS_error=sum((Ydata-Ymodel).^2)
SS_Total= sum((Ydata-mean(Ydata)).^2)

df_model=1
df_error=n-2;
df_total= n-1;

MS_model= SS_model/df_model;

MS_error = SS_error/df_error;

F= MS_model/MS_error;

pval=1-fcdf(F,df_model,df_error)
% acumulative distribution functiona



nSims=1e3;
As=nan(nSims,1)


%%distribucion de la varianza 
%muestra calcular varianza

%otra muestra otra calculo de varainza

efe= 0:0.01:5;
P=fpdf(efe,df_model,df_error)

figure;

plot(efe,P)





%% 

LM=fitlm(Xdata,Ydata)
anova(LM)



