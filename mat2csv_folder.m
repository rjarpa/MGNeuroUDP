%% Change Mat File 2 CSV

%FileData = load('FileName.mat');
%csvwrite('FileName.csv', FileData.M);

disp("Cargar Datos")
%path='D:\OneDrive\Magister - Neurociencias\TACA-TECNICAS DE ANALISIS CUANTITATIVO AVAN\DataSets_Behavior_CognitiveTasks\HUMAN_ULTIMATUM';

path='/Users/rjarpa/OneDrive/Magister - Neurociencias/TACA-TECNICAS DE ANALISIS CUANTITATIVO AVAN/DataSets_Behavior_CognitiveTasks/HUMAN_ULTIMATUM';

load_file(path)


%createCSVFile('')



%% funcion para cargar codigo

function arraVar=load_file(path)
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
    
    FileData=load(filename)  %carga del archivo
    
    %rt=BehavData.vars({'RT_seq'});  %extracción de la variable
    %vr=getfield(BehavData,'vars',var_rescue);  %extracción de la variable
    %VR(1:numel(vr),thisFile)=vr;   %guardado de la variable en una matriz
    
    
    filename_noext= filenamenoext(D(thisFile).name) ;
    
    filenameoutput= horzcat(D(thisFile).folder,filesep,filename_noext,'.csv');
    %return;
    
    %sacar este codigo
    
    Offer=FileData.BehavData.vars.Offer_seq;
    Face=FileData.BehavData.vars.Face_seq;
    Block=FileData.BehavData.vars.Block_dumm;
    Choice=FileData.BehavData.vars.Choice_seq;
    RT=FileData.BehavData.vars.RT_seq;
    
    T=table(Offer,Face,Block,Choice,RT);
    
    writetable(T,filenameoutput);
    %csvwrite(filenameoutput, );
    
end

arraVar=VR;

end



function bool_output=createCSVFile(outfilename,path)


csvwrite('FileName.csv', FileData.M);



end


function name_file = filenamenoext(filename)

% So what is the option to specify when to stop reading if a period (.) is encountered? name=textscan(filename,???)
%fileName = 'abc.567.90xyz.txt'

fileName=filename;
dotLocations = find(fileName == '.')
if isempty(dotLocations)
	% No dots at all found so just take entire name.
	nameBeforeFirstDot = fileName
else
	% Take up to , but not including, the first dot.
	nameBeforeFirstDot = fileName(1:dotLocations(1)-1)
end

name_file= nameBeforeFirstDot;



end


