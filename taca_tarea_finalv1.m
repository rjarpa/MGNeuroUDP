clear all;
%% 2

%path='D:\OneDrive\Magister - Neurociencias\TACA-TECNICAS DE ANALISIS CUANTITATIVO AVAN\DataSets_Behavior_CognitiveTasks\HUMAN_ULTIMATUM';
%HUMAN_ULTIMATUM
path='/Users/rjarpa/OneDrive/Magister - Neurociencias/TACA-TECNICAS DE ANALISIS CUANTITATIVO AVAN/DataSets_Behavior_CognitiveTasks/HUMAN_ULTIMATUM';
var_rescue_RT = 'RT_seq';
AllData_RT=load_file(path,var_rescue_RT);

var_rescue_Offer = 'Offer_seq';
AllData_Offer=load_file(path,var_rescue_Offer);

var_rescue_Face = 'Face_seq';
AllData_Face=load_file(path,var_rescue_Face);

var_rescue_Block = 'Block_dumm';
AllData_Block=load_file(path,var_rescue_Block);

var_rescue_Choice = 'Choice_seq';
AllData_Choice=load_file(path,var_rescue_Choice);

info_rescue_Gender = 'Subject_Gender';
field_name='info';
AllData_Info_Gender=load_file_2(path,field_name,info_rescue_Gender);

[rows,cols]=size(AllData_Offer);
%crear matriz X  e Y
behaviour_y=[];
choice_y=[];
rt_y=[];
offer_x=[];


cont_trial=1;
cont_row=1;

for i = 1:rows 
    for j = 1:cols
        %behaviour_y(cont_row,1)=AllData(i,j);
        choice_y(cont_row,1)=AllData_Choice(i,j);
        rt_y(cont_row,1)=AllData_RT(i,j);
        offer_x(cont_row,1)=AllData_Offer(i,j);
       cont_row=cont_row+1;
    end  
    cont_trial=cont_trial+1;
end


%T=table(ERP,Group,SCR)
T=table(rt_y,choice_y,offer_x)
%simple
LM=fitlm(T,'rt_y~1+choice_y','ResponseVar','rt_y',...
    'PredictorVars',{'choice_y'},'CategoricalVar',{'choice_y'})



%anova(LM);

%T=table(ERP,Group,SCR)
T=table(rt_y,choice_y,offer_x)
%simple 1:05 Dec 01 SIN INTERACCION
LM=fitlm(T,'rt_y~1+offer_x+choice_y','ResponseVar','rt_y',...
    'PredictorVars',{'choice_y','offer_x'},'CategoricalVar',{'choice_y'})
%anova(LM)
%como se responde a la velocidad en funcion de la seleccion y el ratio de
%oferta
% rt= b0  + b1 * offer +b2 * choice

%simple 1:05 Dec 01 CON INTERACCION
%LM=fitlm(T,'rt_y~1+offer_x*choice_y','ResponseVar','rt_y',...
%   'PredictorVars',{'choice_y','offer_x'},'CategoricalVar',{'choice_y'})
LM=fitlm(T,'rt_y~1+offer_x*choice_y','ResponseVar','rt_y',...
    'PredictorVars',{'choice_y','offer_x'})
tbl_=anova(LM);
%tbl_var=anova(LM,'summary')

reject = 1
acccept = 2


figure;
hold on;
% se grafican los puntos en la figura
%plot(offer_x,rt_y,'or',offer_x,choice_y,'ok');
%(x,y1,x,y2)
%plot(rt_y,offer_x,'or',rt_y,choice_y,'ok');
%plot(offer_x(choice_y==0),rt_y(choice_y==0),'or');
%plot(offer_x(choice_y==1),rt_y(choice_y==1),'ok');
scatter(offer_x(choice_y==0),rt_y(choice_y==0),'.r','jitter','on','jitterAmount',0.02);
scatter(offer_x(choice_y==1),rt_y(choice_y==1),'.b','jitter','on','jitterAmount',0.02);
%plot(LM,'linear')
%plot([xdata(1,:)-0.15; xdata(1,:) + 0.15], repmat(mean(ydata, 1), 2, 1), 'k-')


%plot(rt_y,choice_y,'ok');
legend('reject','accept')


%se gregan etiquetas de los ejes
xlabel('Offer');
ylabel(strcat(' ', var_rescue_RT));

var_Estimate=LM.Coefficients.Estimate

XG1=[min(offer_x) max(offer_x)]
YG1=var_Estimate(1) + (var_Estimate(2)+var_Estimate(4)) .* XG1 + var_Estimate(3);


XG0=[min(offer_x) max(offer_x)]
YG0=var_Estimate(1) + var_Estimate(2).*XG1


%d
% se grafica la ecuacion de la recta
plot(XG1,YG1,'-r');
plot(XG0,YG0,'-b');

refline(var_Estimate(2),var_Estimate(1)); 


return;


%codigo para validar
%mdl=fitlm(offer_x,rt_y)
%p=anova(mdl,'summary')

%% funcion para cargar codigo

function arraVar=load_file(path,var_rescue)
% definir directorio o ruta donde están los archivos
my_path=path;

% usar comando 'dir' para obtener la información (nombres) de los archivos
% (añadir que solo extraiga la info de los archivos .mat)
D=dir([my_path filesep '*.mat']);

%prealocar para guardar los datos
%VR=nan(10000,numel(D));
VR=[];

for thisFile = 1: numel(D)  %loop por los archivos (i.e., por los participantes)
    
    filename=horzcat(D(thisFile).folder,filesep,D(thisFile).name);
    
    load(filename)  %carga del archivo
    
    %rt=BehavData.vars({'RT_seq'});  %extracción de la variable
    vr=getfield(BehavData,'vars',var_rescue);  %extracción de la variable
    VR(1:numel(vr),thisFile)=vr;   %guardado de la variable en una matriz
    
end

arraVar=VR;

end



function arraVar=load_file_2(path,field_name,var_rescue)
% definir directorio o ruta donde están los archivos
my_path=path;

% usar comando 'dir' para obtener la información (nombres) de los archivos
% (añadir que solo extraiga la info de los archivos .mat)
D=dir([my_path filesep '*.mat']);

%prealocar para guardar los datos
%VR=nan(10000,numel(D));
VR=[];

for thisFile = 1: numel(D)  %loop por los archivos (i.e., por los participantes)
    
    filename=horzcat(D(thisFile).folder,filesep,D(thisFile).name);
    
    load(filename)  %carga del archivo
    
    %rt=BehavData.vars({'RT_seq'});  %extracción de la variable
    if isfield(BehavData,field_name)
     vr=getfield(BehavData,field_name,var_rescue);  %extracción de la variable
    end 
    if(vr=='F')
        VR(thisFile)=1;   %guardado de la variable en una matriz
    else
        VR(thisFile)=2;
    end
end

arraVar=VR;

end
