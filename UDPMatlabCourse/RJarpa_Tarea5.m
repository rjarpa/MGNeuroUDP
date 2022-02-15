%%Tarea 5

%A Crear una estructura con el identificador, nombre y edad de las madres 
%de la tabla usada  la clase 6, incluir en la estructura 5 pacientes

patient(1).number=47;
patient(1).name='Ana';
patient(1).age=nan;

patient(2).number=33;
patient(2).name='Maria';
patient(2).age=27.26;

patient(3).number=34;
patient(3).name='Rosa';
patient(3).age=22.12;


patient(4).number=43;
patient(4).name='Juana';
patient(4).age=27.51;

patient(5).number=23;
patient(5).name='Petronila';
patient(5).age=36.58;


%B Agregar un campo con la edad gestacional, el valor debe ser del tipo de 
% dato int8

patient(1).gest_age=nan;
patient(2).gest_age=int8(41);
patient(3).gest_age=int8(39);
patient(4).gest_age=int8(41);
patient(5).gest_age=nan;

%C Para la última paciente ingresada corregir la edad a 33 años y para la
% primera paciente ingresada la edad gestacional a 37 semanas

patient(5).age=33;
patient(1).gest_age=37;


%D Acceder a los datos de la estructura y calcular el promedio de la edad 
% de las madres

media_patient_age=mean([patient.age],'omitnan');
disp("edad promedio madres : " +  num2str(media_patient_age));

%E Acceder a los datos de la estructura y calcular el promedio de la edad
% gestacional

media_patient_gest_age=mean([patient.gest_age],'omitnan');
disp("edad gestacional promedio : " +  num2str(media_patient_gest_age));