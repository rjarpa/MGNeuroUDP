% carga (importación) de un conjunto de archivos .mat

% definir directorio o ruta donde están los archivos
my_path='G:\My Drive\2020\UDP\Docencia_Tecnicas_Analisis_Cuantitativo\DataSets_Behavior_CognitiveTasks\HUMAN_POSNER';

% usar comando 'dir' para obtener la información (nombres) de los archivos
% (añadir que solo extraiga la info de los archivos .mat)
D=dir([my_path filesep '*.mat']);

%prealocar para guardar los datos
RT=nan(300,numel(D));

for thisFile = 1: numel(D)  %loop por los archivos (i.e., por los participantes)
    
    load(D(thisFile).name)  %carga del archivo
    
    rt=BehavData.vars.RT_seq;  %extracción de la variable
    
    RT(1:numel(rt),thisFile)=rt;   %guardado de la variable en una matriz
    
end

