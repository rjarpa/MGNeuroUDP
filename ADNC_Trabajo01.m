% Trabajo 01


clear all;
load('WP_Pupil_Data')

%% 1 

% participantes n= 27  PIPILDATA.info.particip_initials
% 

% Descripcion de Normalizaciones e variables 
% PUPILDATA.info.Norm1 'subtract first epoch value'
% PUPILDATA.info.Norm2 'z-score epoch'
% PUPILDATA.info.Norm3 'divide by first epoch value'

info=getfield(PUPILDATA,'info');



% filtro para el minimo numero de trials
% PUPILDATA.info.filter_min_n_trials

filter_min_n_trials=PUPILDATA.info.filter_min_n_trials;

% limite minomo de de n trials
% PUPILDATA.info.min_n_trials


min_n_trials = PUPILDATA.info.min_n_trials;


% 3251 samples
% 291  epocas, trials
% total trials examples 300
% epocas son filas in pupilEpochs_raw
% trials no misses son coloumas 

%% 1

DATA=PUPILDATA


data2=getfield(DATA,'data')
dtnames=fieldnames(data2)
participant_number=length(dtnames)

% tiempos de las epocas en segundos
epoch_before_after_s=DATA.info.epoch_before_after_s

subjects=[]

participant_n=1 %  participant possible values

if ~(participant_n>0 && participant_n<participant_number)
    display("Error Participant Number must be between 1 and " + participant_number) 
   return;
end

    total_s=abs(epoch_before_after_s);
    total_s=sum(total_s);

%% 2

    Norm2Use='Norm1'
     temp=getfield(data2,   dtnames{participant_n});
     epochs_raw=temp.pupilEpochs_raw;
     epochs_Norm=getfield(temp, "pupilEpochs_blinkinterp_" + Norm2Use);
     Fs=temp.Fs;

      epochs_Norm_mean=mean(epochs_Norm','omitnan');  % 3XXX samples por evento
    

    n_samples=total_s*Fs;
    
    t=0:n_samples; % ccrear arreglo para todos las muestras i.e t=0:300
    t=(t)/Fs;
    t=t-abs(epoch_before_after_s(1));


    figure('Name',"Figure 2 - Part : " + dtnames{participant_n});
    plot(t,epochs_Norm_mean')
    legend ("Mean Normalization - " + getfield(info,Norm2Use));
    xlabel('Time (s)');
    ylabel('Pupil Diameter ');



%% 3


     temp=getfield(data2,   dtnames{participant_n});
     epochs_raw=temp.pupilEpochs_raw;
     
     epochs_Norm1=getfield(temp, 'pupilEpochs_blinkinterp_Norm1')
     epochs_Norm2=getfield(temp, 'pupilEpochs_blinkinterp_Norm2')
     epochs_Norm3=getfield(temp, 'pupilEpochs_blinkinterp_Norm3')
     Fs=temp.Fs;

    epochs_Norm1_mean=mean(epochs_Norm1','omitnan');  % 3XXX samples por evento
    epochs_Norm2_mean=mean(epochs_Norm2','omitnan');  % 3XXX samples por evento
    epochs_Norm3_mean=mean(epochs_Norm3','omitnan');  % 3XXX samples por evento
    
    %total_s=abs(epoch_before_after_s);
    %total_s=sum(total_s);
    n_samples=total_s*Fs;
    
    t=0:n_samples; % ccrear arreglo para todos las muestras i.e t=0:300
    t=(t)/Fs;
    t=t-abs(epoch_before_after_s(1));

   
    M=[epochs_Norm1_mean 
        epochs_Norm2_mean 
        epochs_Norm3_mean]

 figure('Name',"Figure 2 - Part : " + dtnames{participant_n});
    
for i=1:3
    
    subplot(3,1,i)
    plot(t,M(i,:)')
    legend ("Mean Normalization - " + getfield(info,"Norm" + i))
    xlabel('Time (s)');
    ylabel('Pupil Diameter ');
end





%% 4

    Norm2Use='Norm1'
     temp=getfield(data2,   dtnames{participant_n});
     epochs_raw=temp.pupilEpochs_raw;
     epochs_Norm=getfield(temp, "pupilEpochs_blinkinterp_" + Norm2Use);
     Fs=temp.Fs;

    epochs_Norm_std=std(epochs_Norm','omitnan');  % 3XXX samples por evento
    
    %total_s=abs(epoch_before_after_s);
    %total_s=sum(total_s);
    n_samples=total_s*Fs;
    
    t=0:n_samples; % ccrear arreglo para todos las muestras i.e t=0:300
    t=(t)/Fs;
    t=t-abs(epoch_before_after_s(1));



    figure('Name',"Figure 4 Participant : " + dtnames{participant_n});
    hold on;
    plot(t,epochs_Norm_mean')
    plot(t,(epochs_Norm_mean')+(epochs_Norm_std'),'_r')
    plot(t,(epochs_Norm_mean')-(epochs_Norm_std'),'_b')
    legend ("Mean Normalization - " + getfield(info,Norm2Use),...
        "+sd Normalization - " + getfield(info,Norm2Use),...
        "-sd Normalization - " + getfield(info,Norm2Use))
    xlabel('Time (s)');
    ylabel('Pupil Diameter ');









    %% 5

    performance=(temp.performance_nomisses');
    
    logic_perf_1 = epochs_Norm(:,performance==1);
    logic_perf_0 = epochs_Norm(:,performance==0);

   % t_p_1 = t(performance==1);
   % t_p_0 = t(performance==0);

    logic_perf_1_mean = mean(logic_perf_1',"omitnan");
    logic_perf_0_mean = mean(logic_perf_0','omitnan');

   figure('Name','Figure 5');
    hold on;
    
    plot(t,logic_perf_1_mean')
    plot(t,logic_perf_0_mean')
    xlabel('Time (s)');
    ylabel('Pupil Diameter ');
    legend('Perfomance OK', 'Perfomance NoK')

    %% 6



    M_mean=[];
    M_std=[];
    Norm2Use='Norm1';


for i=1:2
       
     temp=getfield(data2,dtnames{i});
     epochs_raw=temp.pupilEpochs_raw;
     epochs_Norm=getfield(temp, "pupilEpochs_blinkinterp_" + Norm2Use);
     Fs=temp.Fs;

    epochs_Norm_mean=mean(epochs_Norm','omitnan');
    epochs_Norm_std=std(epochs_Norm','omitnan');  % 3XXX samples por evento
    
    %total_s=abs(epoch_before_after_s);
    %total_s=sum(total_s);
    n_samples=total_s*Fs;
    
    t=0:n_samples; % ccrear arreglo para todos las muestras i.e t=0:300
    t=(t)/Fs;
    t=t-abs(epoch_before_after_s(1));
    

    M_mean(i,:)=[(epochs_Norm_mean)];
    M_std(i,:)=[(epochs_Norm_std)];

end



figure('Name','Figure 6');

    for (i=1:2)
    subplot(2,1,i)
    hold on; 
    plot(t,M_mean(i,:)')
    plot(t,M_mean(i,:)'+M_std(i,:)','_r')
    plot(t,M_mean(i,:)'-M_std(i,:)','_b')
    xlabel('Time (s)');
    ylabel('Pupil Diameter ');
    legend('mean','+sd','-sd');
    hold off;

    end
  

    

 


%% 7 


M_mean=[]
base_Fs_sample=500;
  Norm2Use='Norm2';
for i=1:numel(dtnames)
     temp=getfield(data2,   dtnames{i});
     epochs_raw=temp.pupilEpochs_raw;
     epochs_Norm=getfield(temp, "pupilEpochs_blinkinterp_" + Norm2Use);
     Fs=temp.Fs;

     downsample_rate=Fs/base_Fs_sample; % si la precuencia de sampleo es disntianta
     if downsample_rate>0
     epochs_Norm=downsample(epochs_Norm,downsample_rate);
     else
         downsample_rate=base_Fs_sample/Fs;
         epochs_Norm=upsample(epochs_Norm,downsample_rate);
     end

     %solo si la base es 

    epochs_Norm_mean=mean(epochs_Norm','omitnan');  % 3XXX samples por evento
    
    %total_s=abs(epoch_before_after_s);
    %total_s=sum(total_s);
    n_samples=total_s*base_Fs_sample;
    
    t=0:n_samples; % ccrear arreglo para todos las muestras i.e t=0:300
    t=(t)/Fs;
    t=t-abs(epoch_before_after_s(1));


 M_mean(i,:)=[(epochs_Norm_mean)];

     
end

participant_list=1:length(dtnames);
figure('Name','Figure 7');
hold on;
imagesc(t,participant_list,M_mean);
xlabel('Time (s)');
ylabel('Participants ID');
vticks=1:14;
yticks(vticks)
yticklabels(dtnames);



% 8

M_mean_total=mean(M_mean,'omitnan');
M_std_total=std(M_mean,'omitnan');

figure('Name','Figure 8');
    hold on;

    p1=plot(t,M_mean,'.','Color',  [0.5 0.5 0.5]); % promedios de cada participante
    p2=plot(t,M_mean_total,'ok'); % Promedios de promedios

    pos_sd=(M_mean_total')+(M_std_total');
   neg_sd =(M_mean_total')-(M_std_total');
    p3=plot(t,pos_sd,'or','LineWidth', 2)
    p4=plot(t,neg_sd,'ob','LineWidth', 2)
    patch([t(:); flipud(t(:))], [neg_sd;  flipud(pos_sd)], 'r', 'FaceAlpha',0.2, 'EdgeColor','none')

    xlabel('Time (s)');
    ylabel('Pupil Diameter ');

   % labels=[dtnames;'mean';'+sd';'-sd'];
    %labels=['individuals means';'mean';'+sd';'-sd'];
    %legend(labels);



    lgd = legend([p1(1) p2(1) p3(1) p4(1)], 'individuals','mean','+sd','-sd');

    title(lgd,'legend')
