clear all;
%% Cargar Datos


disp("Cargar Datos")
path='D:\OneDrive\Magister - Neurociencias\TACA-TECNICAS DE ANALISIS CUANTITATIVO AVAN\DataSets_Behavior_CognitiveTasks\HUMAN_ULTIMATUM';
%HUMAN_ULTIMATUM
%path='/Users/rjarpa/OneDrive/Magister - Neurociencias/TACA-TECNICAS DE ANALISIS CUANTITATIVO AVAN/DataSets_Behavior_CognitiveTasks/HUMAN_ULTIMATUM';
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
block=[];
face=[];
participant_id = [];

cont_trial=1;
cont_row=1;

disp("dejar la informacion en vectores separados")
for i = 1:rows 
    for j = 1:cols
        %behaviour_y(cont_row,1)=AllData(i,j);
        choice_y(cont_row,1)=AllData_Choice(i,j);
        rt_y(cont_row,1)=AllData_RT(i,j);
        offer_x(cont_row,1)=AllData_Offer(i,j);
        block(cont_row,1) =AllData_Block(i,j);
        face(cont_row,1) =AllData_Face(i,j);
        
        participant_id(cont_row,1) =j;
       cont_row=cont_row+1;
    end  
    cont_trial=cont_trial+1;
end


prom_parti=[];

rt_y_block1=rt_y(block==1);
rt_y_block2=rt_y(block==2);

rt_y_block1_par=rt_y((block==1)&(participant_id==1));
rt_y_block2_par=rt_y((block==2)&(participant_id==1));


% plot parameters
fsize=14;
ms=22;
lw=4;
col1=[0.6 0.4 0.1];
col2=[0.1 0.4 0.6];


% se toman los valores unicos 
offer_type= unique(offer_x);

%choice_y_block1_parxoffer=choice_y((block==1)&(participant_id==1)&(offer_x==offer_type(4)))
%cantidad_opciones=numel(choice_y_block1_parxoffer)
%suma_choice=sum(choice_y_block1_parxoffer)
%promedio_choice_partxoffer_block1=suma_choice/cantidad_opciones


id_part_b1 = [];
offer_part_b1 = [];
porce_part_b1 = [];
group_b1 = [];

id_part_b2 = [];
offer_part_b2 = [];
porce_part_b2 = [];
group_b2 = [];

cont_arra=1;
for i= 1:numel(unique(participant_id))
    for j= 1:numel(offer_type)

        choice_y_block1_parxoffer=choice_y((block==1)&(participant_id==i)&(offer_x==offer_type(j)));
        
        cantidad_opciones=numel(choice_y_block1_parxoffer);
        suma_choice=sum(choice_y_block1_parxoffer);
        promedio_choice_partxoffer_block1=suma_choice/cantidad_opciones;
        
        id_part_b1(cont_arra) = i;
        offer_part_b1(cont_arra) = offer_type(j);
        porce_part_b1(cont_arra) = promedio_choice_partxoffer_block1;
        group_b1(cont_arra)=1;
        
        choice_y_block2_parxoffer=choice_y((block==2)&(participant_id==i)&(offer_x==offer_type(j)));
        
        cantidad_opciones=numel(choice_y_block2_parxoffer);
        suma_choice=sum(choice_y_block2_parxoffer);
        promedio_choice_partxoffer_block2=suma_choice/cantidad_opciones;
        
        id_part_b2(cont_arra) = i;
        offer_part_b2(cont_arra) = offer_type(j);
        porce_part_b2(cont_arra) = promedio_choice_partxoffer_block2;
        group_b2(cont_arra)=2;

        
        cont_arra=cont_arra+1;
    end

end 


%% codigo bloque sin caras

disp("codigo bloque sin caras");
mdl_bloc1=fitlm(offer_part_b1,porce_part_b1)
tbl_bloc1=anova(mdl_bloc1)
var_Estimate=mdl_bloc1.Coefficients.Estimate;

f1=figure('Name','Tipo de oferta bloque 1 - Sin Caras');
hold on;
%ax=axes('parent', f1, 'tickdir', 'out', 'xtick', offer_type, 'xticklabel', offer_type, 'fontsize', fsize);
%hold(ax,'all');
%scatter(porce_acepta_part_block1,promedio_offer_part_block1,'.r','jitter','on','jitterAmount',0.02);
scatter(offer_part_b1,porce_part_b1,'or','jitter','on','jitterAmount',0.02);



B0=var_Estimate(1);
B1=var_Estimate(2);

X1=[min(offer_part_b1) max(porce_part_b1)];
Y1= B0 + B1 .* X1 ;
plot(X1,Y1,'-r');

%se gregan etiquetas de los ejes
xlabel('Offer');
ylabel('Acceptance Rate %');

dim=[.15 .8 .2 0];
%annotation('textbox',dim,'String',"Model Equation Volume=" + a_hat_2+" + " + b_hat_2+ " * Height + e(0,"+s_2+")",'FitBoxToText','on','FontSize',8);
annotation('textbox',dim,'String',"Model Equation Volume=" + B0+" + " + B1+ " * Offer ",'FitBoxToText','on','FontSize',14);
%dim=[.15 .6 .2 0];
%annotation('textbox',dim,'String',"R square=" + Rxy2_2,'FitBoxToText','on','FontSize',8);

hold off;

print(f1, 'Tipo de oferta bloque 1 - Sin Caras', '-dpng', '-r350');


%simulacion de bloques sin caras
simu_distrmuestral(mdl_bloc1,tbl_bloc1,offer_part_b1,B1 ,1000,'Bloque sin Caras','Diff of means','Probability')


%% codigo bloque con caras


disp("codigo bloque con caras");

mdl_bloc2=fitlm(offer_part_b2,porce_part_b2)
tbl_bloc2=anova(mdl_bloc2)
var_Estimate=mdl_bloc2.Coefficients.Estimate;

f2=figure('Name','Tipo de oferta bloque 2 - Con Caras');;
hold on;
%scatter(porce_acepta_part_block1,promedio_offer_part_block1,'.r','jitter','on','jitterAmount',0.02);
scatter(offer_part_b2,porce_part_b2,'ob','jitter','on','jitterAmount',0.02);
B0=var_Estimate(1);
B1=var_Estimate(2);
X2=[min(offer_part_b2) max(offer_part_b2)];
Y2= B0 + B1 .* X1 ;
plot(X2,Y2,'-b');
%se gregan etiquetas de los ejes
xlabel('Offer');
ylabel('Acceptance Rate %');

dim=[.15 .8 .2 0];
%annotation('textbox',dim,'String',"Model Equation Volume=" + a_hat_2+" + " + b_hat_2+ " * Height + e(0,"+s_2+")",'FitBoxToText','on','FontSize',8);
annotation('textbox',dim,'String',"Model Equation Volume=" + B0+" + " + B1+ " * Offer ",'FitBoxToText','on','FontSize',14);


hold off;
print(f2, 'Tipo de oferta bloque 1 - Sin Caras', '-dpng', '-r350');


%simulacion de bloques con caras
simu_distrmuestral(mdl_bloc2,tbl_bloc2,offer_part_b2,B1 ,1000,'Bloque con Caras','Diff of means','Probability')


%% grupos de caras y sin caras

disp("grupos de caras y sin caras");
porce_acceptance_y=vertcat(transpose(porce_part_b1),transpose(porce_part_b2));
group_block=vertcat(transpose(group_b1),transpose(group_b2));
type_offer_x= vertcat(transpose(offer_part_b1),transpose(offer_part_b2));

T=table(porce_acceptance_y,group_block,type_offer_x);
%SIN INTERACCION
LM=fitlm(T,'porce_acceptance_y~1+group_block','ResponseVar','porce_acceptance_y',...
    'PredictorVars',{'group_block',},'CategoricalVar',{'group_block'})

%SIN INTERACCION SIN CATEGORIA
%LM=fitlm(T,'porce_acceptance_y~1+type_offer_x+group_block','ResponseVar','porce_acceptance_y',...
%    'PredictorVars',{'type_offer_x','group_block',},'CategoricalVar',{'group_block'})

%CON INTERACCION
%LM=fitlm(T,'porce_acceptance_y~1+type_offer_x*group_block','ResponseVar','porce_acceptance_y',...
%    'PredictorVars',{'group_block','type_offer_x'},'CategoricalVar',{'group_block'})

%INTERACCION SIN VARIABLE CATEGORICA
%LM=fitlm(T,'porce_acceptance_y~1+type_offer_x*group_block','ResponseVar','porce_acceptance_y',...
%    'PredictorVars',{'group_block','type_offer_x'})


tbl_=anova(LM)
var_Estimate=LM.Coefficients.Estimate;

B0=var_Estimate(1);
B1=var_Estimate(2);
%B2=var_Estimate(3)

%XG2=[min(type_offer_x) max(type_offer_x)];
%YG2=var_Estimate(1) + (var_Estimate(2)+var_Estimate(4)) .* XG2 + var_Estimate(3);
%YG2=B0 + (B1) .* XG2 + B2;
XG1=[min(group_block)-0.1 max(group_block)+0.1];
YG1=B0 + B1 .*XG1;


f3=figure('Name','Modelo Lineal y Bloque Con_Sin Caras ');
%hold on;
ax=axes('parent', f3, 'tickdir', 'out', 'xtick', [1 2], 'xticklabel', {'No Face', 'Face'}, 'fontsize', fsize);
hold(ax,'all');
%scatter(porce_acepta_part_block1,promedio_offer_part_block1,'.r','jitter','on','jitterAmount',0.02);
scatter(group_b1,porce_part_b1,'.r','jitter','on','jitterAmount',0.05);
scatter(group_b2,porce_part_b2,'.b','jitter','on','jitterAmount',0.05);
% se grafica la ecuacion de la recta
plot(XG1,YG1,'-g');
%plot(XG2,YG2,'-b');
%refline(var_Estimate(2),var_Estimate(1)); 
%se gregan etiquetas de los ejes
xlabel('Bloques');
ylabel('Acceptance Rate %');
%xlim([0 3])
plot([0.95 1.05], [mean(porce_part_b1) mean(porce_part_b1)],'-r')
plot([1.95 2.05], [mean(porce_part_b2) mean(porce_part_b2)], '-b')


%graficar los standard error
% c tendra las medias y m calculo estandar error
%SEM1=std(porce_part_b1)/sqrt(numel(porce_part_b1));
SEMb1=std(porce_part_b1);
errhigh=SEMb1;
errlow=SEMb1*-1;
x = 1:4;
er = errorbar(1,mean(porce_part_b1),errlow,errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';

% c tendra las medias y m calculo estandar error
%SEM1=std(porce_part_b2)/sqrt(numel(porce_part_b2));
SEMb2=std(porce_part_b2);
errhigh=SEMb2;
errlow=SEMb2*-1;
x = 1:4;
er = errorbar(2,mean(porce_part_b2),errlow,errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';


%ylim([0 110]);
%yticks(0:10:100);


dim=[.15 .9 .2 0];
%annotation('textbox',dim,'String',"Model Equation Volume=" + a_hat_2+" + " + b_hat_2+ " * Height + e(0,"+s_2+")",'FitBoxToText','on','FontSize',8);
annotation('textbox',dim,'String',"Model Equation Volume=" + B0+" + " + B1+ " * Bloque ",'FitBoxToText','on','FontSize',12,'Color','Black');
%dim=[.15 .8 .2 0];
%annotation('textbox',dim,'String',"Model Equation Volume=" + a_hat_2+" + " + b_hat_2+ " * Height + e(0,"+s_2+")",'FitBoxToText','on','FontSize',8);
%annotation('textbox',dim,'String',"Model Equation Volume=" + B0+" + " + B1+ " * Offer + " + B2,'FitBoxToText','on','FontSize',12,'Color','blue');

hold off;

print(f3, 'Modelo Lineal y Bloque Con_Sin Caras', '-dpng', '-r350');


%simulacion de grupo de oferta y bloque REVISAR SI SE ESTA EVALUANDO DE
%MANERA CORRECTA
simu_distrmuestral(LM,tbl_,type_offer_x, B1,1000,'Tipo de Oferta - Categorica','B1','Probability')



%plot(rt_y,choice_y,'ok');
legend('Con Rostros ','Sin Rostros')


%se gregan etiquetas de los ejes
xlabel('Offer');
ylabel('Acceptance Rate %');


%% mostrar porcentaje Persona contra MAquina
f2_2=figure('Name','Barras Rostros no Rostros ');

%hold on;
ax=axes('parent', f2_2, 'tickdir', 'out', 'xtick', offer_type, 'xticklabel', offer_type, 'fontsize', fsize);
hold(ax,'all');

promedio_5=[mean(porce_part_b1(offer_part_b1==0.5),'omitnan') mean(porce_part_b2(offer_part_b2==0.5),'omitnan')]
promedio_7=[mean(porce_part_b1(offer_part_b1==0.7),'omitnan') mean(porce_part_b2(offer_part_b2==0.7),'omitnan')]
promedio_8=[mean(porce_part_b1(offer_part_b1==0.8),'omitnan') mean(porce_part_b2(offer_part_b2==0.8),'omitnan')]
promedio_9=[mean(porce_part_b1(offer_part_b1==0.9),'omitnan') mean(porce_part_b2(offer_part_b2==0.9),'omitnan')]

bar(unique(type_offer_x),vertcat(promedio_5,promedio_7,promedio_8,promedio_9));

xlabel('Offer Types');
ylabel('Acceptance Rate %');

legend('Computer ','Human');
hold off;


%realizar comparative del bloque 2 con los tipos de rostros
%% Modelos con tipos de Cara

disp('Modelo Lineal Simple Rostros')

% se toman los valores unicos 
face_type= unique(face);



id_part_face_b2 = [];
offer_part_face_b2 = [];
porce_part_face_b2 = [];
group_face_b2 = [];
face_part_face_b2 = []; %utilizado para ver si las caras afectan

    
cont_arra=1;
for i= 1:numel(unique(participant_id))
    for j= 1:numel(face_type)

             
        choice_y_block2_parxoffer=choice_y((block==2)&(participant_id==i)&(face==face_type(j)));
        
        cantidad_opciones=numel(choice_y_block2_parxoffer);
        suma_choice=sum(choice_y_block2_parxoffer);
        promedio_choice_partxface_block2=suma_choice/cantidad_opciones;
        
        id_part_face_b2(cont_arra) = i;
        %offer_part_face_b2(cont_arra) = offer_type(j);
        porce_part_face_b2(cont_arra) = promedio_choice_partxface_block2;
        group_face_b2(cont_arra)=2;
        face_part_face_b2(cont_arra) = face_type(j) ; 
        
        cont_arra=cont_arra+1;
    end

end 

% se evalua el % de aceptacion cuando se muestran rostros por grupos
porce_part_face_b2= transpose(porce_part_face_b2);
face_part_face_b2=transpose(face_part_face_b2);

% porcentaje de aceptacion de en el bloque de caras
T_face=table(porce_part_face_b2,face_part_face_b2);
LM_face=fitlm(T_face,'porce_part_face_b2~1+face_part_face_b2','ResponseVar','porce_part_face_b2',...
    'PredictorVars',{'face_part_face_b2'},'CategoricalVar',{'face_part_face_b2'})
tbl_face=anova(LM_face)

var_Estimate_face=LM_face.Coefficients.Estimate;
B0=var_Estimate_face(1);
B1=var_Estimate_face(2);
B2=var_Estimate_face(3);
%B3=var_Estimate_face(4);
%B4=var_Estimate_face(5);
%B5=var_Estimate_face(6);


%face happy
%XG3=[min(face_part_face_b2) max(face_part_face_b2)];
%YG3= B0 + (B1) .* XG3 + B2 + B3 .* (XG3) + B4 + B5 .*(XG3);

% face  neutral 
%XG2=[min(face_part_face_b2) max(face_part_face_b2)];
%YG2=B0 + (B1) .* XG2 + B2 +B3 .* (XG2)  ;

%face angry
XG1=[min(face_part_face_b2) max(face_part_face_b2)];
YG1=B0 + B1.*XG1;


%XG2=[min(face_part_face_b2) max(face_part_face_b2)];
%YG2=var_Estimate(1) + (var_Estimate(2)) .* XG2 + var_Estimate(3);
%XG1=[min(face_part_face_b2) max(face_part_face_b2)];
%YG1=var_Estimate_face(1) + var_Estimate_face(2).*XG1;

f4=figure('Name','Modelo Lineal Simple Caras');
hold on;
scatter(face_part_face_b2(face_part_face_b2==-1),porce_part_face_b2(face_part_face_b2==-1),'or','jitter','on','jitterAmount',0.02);
scatter(face_part_face_b2(face_part_face_b2==0),porce_part_face_b2(face_part_face_b2==0),'ob','jitter','on','jitterAmount',0.02);
scatter(face_part_face_b2(face_part_face_b2==1),porce_part_face_b2(face_part_face_b2==1),'ok','jitter','on','jitterAmount',0.02);
% se grafica la ecuacion de la recta
plot(XG1,YG1,'-b');
%plot(XG2,YG2,'-b');
%plot(XG2,YG2,'-k');

%se gregan etiquetas de los ejes
xlabel('Face');
ylabel('Acceptance Rate %');

dim=[.15 .9 .2 0];
%annotation('textbox',dim,'String',"Model Equation Volume=" + a_hat_2+" + " + b_hat_2+ " * Height + e(0,"+s_2+")",'FitBoxToText','on','FontSize',8);
annotation('textbox',dim,'String',"Model Equation Rate_Acceptance=" + B0+" + " + B1+ " * Faces ",'FitBoxToText','on','FontSize',12,'Color','Black');

hold off;

print(f4, 'Modelo Lineal Simple Caras', '-dpng', '-r350');



%% Modelo de oferta y rostros

disp("Modelo de oferta y rostros")


id_part_face_b2 = [];
offer_part_face_b2 = [];
porce_part_face_b2 = [];
group_face_b2 = [];
face_part_face_b2 = []; %utilizado para ver si las caras afectan


cont_arra=1;
for i= 1:numel(unique(participant_id))
    for j= 1:numel(face_type)
        for x= 1:numel(offer_type)
             
        choice_y_block2_parxoffer=choice_y((block==2)&(participant_id==i)&(face==face_type(j))&(offer_x==offer_type(x)));
        
        cantidad_opciones=numel(choice_y_block2_parxoffer);
        suma_choice=sum(choice_y_block2_parxoffer);
        promedio_choice_partxface_block2=suma_choice/cantidad_opciones;
        
        id_part_face_b2(cont_arra) = i;
        offer_part_face_b2(cont_arra) = offer_type(x);
        porce_part_face_b2(cont_arra) = promedio_choice_partxface_block2;
        group_face_b2(cont_arra)=2;
        face_part_face_b2(cont_arra) = face_type(j) ; 
        
        cont_arra=cont_arra+1;
    end

    end 

end

%resolucion para nan
T_face_2_nan=table(id_part_face_b2,porce_part_face_b2,face_part_face_b2,offer_part_face_b2);

% se evalua el % de aceptacion cuando se muestran rostros por grupos
id_part_face_b2= transpose(id_part_face_b2(~isnan(porce_part_face_b2)));
face_part_face_b2=transpose(face_part_face_b2(~isnan(porce_part_face_b2)));
offer_part_face_b2=transpose(offer_part_face_b2(~isnan(porce_part_face_b2)));
porce_part_face_b2= transpose(porce_part_face_b2(~isnan(porce_part_face_b2)));

% porcentaje de aceptacion de en el bloque de caras
T_face_2=table(id_part_face_b2,porce_part_face_b2,face_part_face_b2,offer_part_face_b2);
% independiente
LM_face_2=fitlm(T_face_2,'porce_part_face_b2~1+offer_part_face_b2+face_part_face_b2','ResponseVar','porce_part_face_b2',...
    'PredictorVars',{'face_part_face_b2','offer_part_face_b2'},'CategoricalVar',{'face_part_face_b2'})
tbl_face_2=anova(LM_face_2)

%interdependiente
LM_face_2=fitlm(T_face_2,'porce_part_face_b2~1+offer_part_face_b2*face_part_face_b2','ResponseVar','porce_part_face_b2',...
    'PredictorVars',{'face_part_face_b2','offer_part_face_b2'},'CategoricalVar',{'face_part_face_b2'})
tbl_face_2=anova(LM_face_2)

var_Estimate_face_2=LM_face_2.Coefficients.Estimate;
B0=var_Estimate_face_2(1);
B1=var_Estimate_face_2(2);
B2=var_Estimate_face_2(3);
B3=var_Estimate_face_2(4);
B4=var_Estimate_face_2(5);
B5=var_Estimate_face_2(6);


%face happy
XG3=[min(offer_part_face_b2) max(offer_part_face_b2)];
YG3= B0 + (B1) .* XG3 + B2 + B3 .* (XG3) + B4 + B5 .*(XG3);

% face  neutral 
XG2=[min(offer_part_face_b2) max(offer_part_face_b2)];
YG2=B0 + (B1) .* XG2 + B2 +B3 .* (XG2)  ;

%face angry
XG1=[min(offer_part_face_b2) max(offer_part_face_b2)];
YG1=B0 + B1.*XG1;



f5=figure('Name','Modelo Lineal valores de caras categorico mas  oferta');
hold on;


face_angry_x_group=offer_part_face_b2(face_part_face_b2==-1);
angry_min=min(face_angry_x_group);
angry_max=max(face_angry_x_group);

face_neutral_x_group=offer_part_face_b2(face_part_face_b2==0);
neutral_min=min(face_neutral_x_group);
neutral_max=max(face_neutral_x_group);

face_happy_x_group=offer_part_face_b2(face_part_face_b2==1);
happy_min=min(face_happy_x_group);
happy_max=max(face_happy_x_group);

porce_angry_y_group=porce_part_face_b2(face_part_face_b2==-1);
porce_neutral_y_group=porce_part_face_b2(face_part_face_b2==0);
porce_happy_y_group=porce_part_face_b2(face_part_face_b2==1);

scatter(face_angry_x_group,porce_angry_y_group,'ob','jitter','on','jitterAmount',0.02);
scatter(face_neutral_x_group,porce_neutral_y_group,'om','jitter','on','jitterAmount',0.02);
scatter(face_happy_x_group,porce_happy_y_group,'og','jitter','on','jitterAmount',0.02);

% se grafica la ecuacion de la recta
plot(XG1,YG1,'-b');
plot(XG2,YG2,'-m');
plot(XG3,YG3,'-g');


%se gregan etiquetas de los ejes
xlabel('Offer');
ylabel('Acceptance Rate %');

%plot means
%plot([angry_min angry_max], [mean(porce_angry_y_group) mean(porce_angry_y_group)],'-b')
%plot([neutral_min neutral_max], [mean(porce_neutral_y_group) mean(porce_neutral_y_group)],'-om' )
%plot([happy_min happy_max], [mean(porce_happy_y_group) mean(porce_happy_y_group)], '-og')

Formula_Angry="";
Formula_Neutral= "";
Formula_Happy = "";

legend('% angry','% neutral','% happy','Angry ','Neutral', 'Happy');

hold off;

print(f5,'Modelo Lineal valores de caras categorico mas  oferta', '-dpng', '-r350');




%% Oferta y tipos de rostos Modelo Simple Happy


% porcentaje de aceptacion de en el bloque de caras
T_face_happy=table(porce_part_face_b2(face_part_face_b2==1),...
    offer_part_face_b2(face_part_face_b2==1),...
    'VariableNames',{'porce_part_face_b2','offer_part_face_b2'});
% independiente
LM_face_happy=fitlm(T_face_happy,'porce_part_face_b2~1+offer_part_face_b2','ResponseVar','porce_part_face_b2',...
    'PredictorVars',{'offer_part_face_b2'})
tbl_face_happy=anova(LM_face_happy)

var_Estimate_face_2=LM_face_happy.Coefficients.Estimate;
B0=var_Estimate_face_2(1);
B1=var_Estimate_face_2(2);

%face angry
XG1=[min(porce_part_face_b2(face_part_face_b2==1)) max(porce_part_face_b2(face_part_face_b2==1))];
YG1=B0 + B1.*XG1;

f10=figure('Name','Modelo Lineal valores de caras categorico mas  oferta');
hold on;
scatter(offer_part_face_b2(face_part_face_b2==1),porce_part_face_b2(face_part_face_b2==1),'og','jitter','on','jitterAmount',0.02);
% se grafica la ecuacion de la recta
plot(XG1,YG1,'-g');
%plot(XG2,YG2,'-m');
%plot(XG3,YG3,'-g');


%se gregan etiquetas de los ejes
xlabel('Offer');
ylabel('Acceptance Rate %');

dim=[.15 .9 .2 0];
%annotation('textbox',dim,'String',"Model Equation Volume=" + a_hat_2+" + " + b_hat_2+ " * Height + e(0,"+s_2+")",'FitBoxToText','on','FontSize',8);
annotation('textbox',dim,'String',"Model Equation Rate_Acceptance=" + B0+" + " + B1+ " * Offer ",'FitBoxToText','on','FontSize',12,'Color','Black');

hold off;

%% Oferta y tipos de rostos Modelo Simple Neutral


% porcentaje de aceptacion de en el bloque de caras
T_face_neutral=table(porce_part_face_b2(face_part_face_b2==0)...
    ,offer_part_face_b2(face_part_face_b2==0),...
    'VariableNames',{'porce_part_face_b2','offer_part_face_b2'});
% independiente
LM_face_neutral=fitlm(T_face_neutral,'porce_part_face_b2~1+offer_part_face_b2','ResponseVar','porce_part_face_b2',...
    'PredictorVars',{'offer_part_face_b2'})
tbl_face_neutral=anova(LM_face_neutral)

var_Estimate_face_2=LM_face_neutral.Coefficients.Estimate;
B0=var_Estimate_face_2(1);
B1=var_Estimate_face_2(2);

%face angry
XG1=[min(porce_part_face_b2(face_part_face_b2==0)) max(porce_part_face_b2(face_part_face_b2==0))];
YG1=B0 + B1.*XG1;

f10=figure('Name','Modelo Lineal valores de caras categorico mas  oferta');
hold on;
scatter(offer_part_face_b2(face_part_face_b2==0),porce_part_face_b2(face_part_face_b2==0),'om','jitter','on','jitterAmount',0.02);
% se grafica la ecuacion de la recta
plot(XG1,YG1,'-m');
%plot(XG2,YG2,'-m');
%plot(XG3,YG3,'-g');


%se gregan etiquetas de los ejes
xlabel('Offer');
ylabel('Acceptance Rate %');

dim=[.15 .9 .2 0];
%annotation('textbox',dim,'String',"Model Equation Volume=" + a_hat_2+" + " + b_hat_2+ " * Height + e(0,"+s_2+")",'FitBoxToText','on','FontSize',8);
annotation('textbox',dim,'String',"Model Equation Rate_Acceptance=" + B0+" + " + B1+ " * Offer ",'FitBoxToText','on','FontSize',12,'Color','Black');

hold off;

%% Oferta y tipos de rostos Modelo Simple Negative


% porcentaje de aceptacion de en el bloque de caras
T_face_negative=table(porce_part_face_b2(face_part_face_b2==-1)...
    ,offer_part_face_b2(face_part_face_b2==-1),...
    'VariableNames',{'porce_part_face_b2','offer_part_face_b2'});
% independiente
LM_face_negative=fitlm(T_face_negative,'porce_part_face_b2~1+offer_part_face_b2','ResponseVar','porce_part_face_b2',...
    'PredictorVars',{'offer_part_face_b2'})
tbl_face_negative=anova(LM_face_negative)

var_Estimate_face_2=LM_face_negative.Coefficients.Estimate;
B0=var_Estimate_face_2(1);
B1=var_Estimate_face_2(2);

%face angry
XG1=[min(porce_part_face_b2(face_part_face_b2==-1)) max(porce_part_face_b2(face_part_face_b2==-1))];
YG1=B0 + B1.*XG1;

f10=figure('Name','Modelo Lineal valores de caras categorico mas  oferta');
hold on;
scatter(offer_part_face_b2(face_part_face_b2==-1),porce_part_face_b2(face_part_face_b2==-1),'ob','jitter','on','jitterAmount',0.02);
% se grafica la ecuacion de la recta
plot(XG1,YG1,'-b');
%plot(XG2,YG2,'-m');
%plot(XG3,YG3,'-g');


%se gregan etiquetas de los ejes
xlabel('Offer');
ylabel('Acceptance Rate %');

dim=[.15 .9 .2 0];
%annotation('textbox',dim,'String',"Model Equation Volume=" + a_hat_2+" + " + b_hat_2+ " * Height + e(0,"+s_2+")",'FitBoxToText','on','FontSize',8);
annotation('textbox',dim,'String',"Model Equation Rate_Acceptance=" + B0+" + " + B1+ " * Offer ",'FitBoxToText','on','FontSize',12,'Color','Black');

hold off;

return;

%% realizar test de permutaciones
disp("realizar test de permutaciones")

% realizar simulaciones 

%realizar test de permutacion
Permuta=test_permuta(porce_part_b1, porce_part_b2,1500);


%valor de media de la muestra original
D=mean(porce_part_b1)-mean(porce_part_b2);

%graficacion de la permutacion
chart_histo(Permuta,'Grafica de Distribucion de Medias de Permutaciones','Diferencia de Medias',D)


%valor de  de permutacion
valor_p_permuta=p_permuta(Permuta,D);

%return;

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

function simuBool=simu_distrmuestral(var_fitML,var_anovatbl,var_x_collection, pendiente ,var_Simu,var_figure_name,var_x_label,var_y_label)
%preparar variables
mdl=var_fitML;
x_var= var_x_collection;

nSims = var_Simu;
tbl=var_anovatbl;
figure_name=var_figure_name;
x_label=var_x_label;
y_label=var_y_label;

% realizar simulaciones 
var_Estimate=mdl.Coefficients.Estimate;

%varianza de SC error
%var_err_2=SS_err_2/df_err_2;
%obtener sigma del error para las simulaciones
%sd_2=sqrt(var_err_2);
varianza_error=tbl.MeanSq(2);
sd=sqrt(varianza_error);
intercept=var_Estimate(1);
predictor=var_Estimate(2);


for i=1:nSims
    % se realiza la simulacion de y con sd de la varianza SC error
    y_simu = intercept+predictor*x_var+randn(size(x_var)).*sd;
    %behaviour_y_simu = a_hat_2+b_hat_2*trial_x+normrnd(0,sd_2,size(trial_x));
    cov_simu=sum((x_var-mean(x_var)).*(y_simu-mean(y_simu)))./(numel(x_var)-1);
    hat_b_simu(i) = cov_simu/var(x_var);
    hat_a_simu(i) = mean(y_simu) - hat_b_simu(i)*mean(x_var);
end



chart_histo(hat_b_simu,figure_name,x_label,pendiente);


%graficar distribucion de b_hat
%figure('Name',figure_name);hold on;
%mean_hat_b_simu=mean(hat_b_simu);
%histogram(hat_b_simu,'Normalization','probability');
%se grafica media de b_hat
%xline(mean_hat_b_simu,'r');
%ylabel('probabilidad');
%xlabel(x_label);
%dim=[.15 .8 .2 0];
%annotation('textbox',dim,'String',"Media =" + mean_hat_b_simu,'FitBoxToText','on','FontSize',8);

simuBool=true;

end 


function testbootstrap_Bool=test_bootstrap(var_fitML,var_anovatbl,var_x_collection,var_Simu)

end 

function testpermu_Arra=test_permuta(group1, group2,var_Perm)
 G=vertcat(group1,group2);
 nPerms=var_Perm;
 Ds=nan(nPerms,1);
 
 for j=1:nPerms
     
     rand_idx=randperm(numel(G));
     
     Gperm=G(rand_idx);
     Gperm1=Gperm(1:numel(group1));
     Gperm2=Gperm(numel(group1)+1:end);
     
     Ds(j) = mean(Gperm2(:,1)) - mean(Gperm1(:,1));
     
     
 end

 testpermu_Arra=Ds;
 
end


function testpermu_Arra=test_permuta_3_anova(group1, group2, group3, var_Perm)
 G=vertcat(group1,group2,group3);
 nPerms=var_Perm;
 Ds=nan(nPerms,1);
 
 for j=1:nPerms
     
     rand_idx=randperm(numel(G));
     
     Gperm=G(rand_idx);
     Gperm1=Gperm(1:numel(group1));
     Gperm2=Gperm(numel(group1)+1:end);
     Gperm3=Gperm(numel(group1)+1:end);
     
     %Ds(j) = mean(Gperm2(:,1)) - mean(Gperm1(:,1));
     % por desarrollar
     Ds(j) = anovan()
     
 end

 testpermu_Arra=Ds;
 
end



function chartBool=chart_histo(x_values,var_figure_name,var_x_label,pendiente)


x_val=x_values;

figure_name=var_figure_name;
x_label = var_x_label;


%graficar distribucion de b_hat
fx=figure('Name',figure_name);hold on;
mean_hat_b_simu=mean(x_val);
histogram(x_val,'Normalization','probability');
%histogram(x_val);
%se grafica media de b_hat
xline(mean_hat_b_simu,'r');
yline(0.05,'--b');
ylabel('Probability');
xlabel(x_label);
ci = [ prctile(x_val,2.5) prctile(x_val,97.5) ];
xline(ci(1,1),'g--');
xline(ci(1,2),'g--');
dim=[.15 .8 .2 0];
annotation('textbox',dim,'String',"Media =" + mean_hat_b_simu,'FitBoxToText','on','FontSize',14);

dim=[.15 .7 .2 0];
annotation('textbox',dim,'String',"Orignal Pendiente Modelo =" + pendiente,'FitBoxToText','on','FontSize',14);



chartBool=true;

hold off;

print(fx,figure_name, '-dpng', '-r350');

end


function value_p_permuta=p_permuta(arraPermuta,valor_ori) % parametros arreglo de valor y el valor original de la muestra para acumular

cont=sum(arraPermuta>valor_ori);
value_p_permuta=cont/numel(arraPermuta);

end
