% Habilita el uso de pausas de ejecucion en matlab
pause('on')

% Fijar numero de trials
NTrials = 30;

% Umbral de trials GO
umbType = 0.5;

% Numero aleatorio para definir el tipo de trial
TypeTrial = rand(NTrials,1);

% Numero aleatorio para definir cuanto tiempo espera antes de mostrar el
% estimulo. Entre 1 y 5 segundos
TmPause = 4*rand(NTrials,1)+1;

% Guarda los datos de cada trial
TmData = zeros(NTrials,2); % Time elapsed to RT and type of trials

% Pantalla para iniciar el experimento
Bienve = 'Para comenzar aprete cualquier boton.';

% Escribe en pantalla el mensaje de bienvenida
figure('color','w')
annotation('textbox',[0.12 0.56 0.8 0.1],...
    'String',Bienve,'LineStyle','none','FontSize',24,...
    'FitBoxToText','on');

% Hace una pausa que se rompe cuando apreto cualquier tecla, si no puede durar para siempre
pause

% Pune un rectangulo blanco sobre el texto
annotation('rectangle',[0.08 0.50 0.81 0.20],'Color',[1 1 1],'FaceColor',[1 1 1]);


% Presenta todos los trials
for kk=1:1:NTrials
    
    % Cruz en el medio de la pantalla
    annotation('textbox',[0.45 0.51 0.08 0.08],...
    'String','+','LineStyle','none','FontSize',24,'FitBoxToText','on');
    
    
    % Mantiene la pantalla actual por un tiempo aleatorio
    pause(TmPause(kk))
    
    % Pune un rectangulo blanco sobre el texto
    annotation('rectangle',[0.08 0.50 0.81 0.20],'Color',[1 1 1],'FaceColor',[1 1 1]);
    
    tic, % Esto inicia el cronometro
    % Tipo de trial
    if TypeTrial(kk)>umbType
        annotation('textbox',[0.36 0.49 0.34 0.14],...
            'Color',[0.85 0.33 0.098],'String',{'No Go'},...
            'LineStyle','none','FontSize',48,...
            'FitBoxToText','on','BackgroundColor','w');
        pause
    else
        annotation('textbox',[0.43 0.5 0.21 0.14],...
            'Color',[0 0.5 0],'String',{'Go'},...
            'LineStyle','none','FontSize',48,...
            'FitBoxToText','on','BackgroundColor','w');
        pause
    end
    
    % Pune un rectangulo sobre el texto
    annotation('rectangle',[0.08 0.50 0.81 0.20],'Color',[1 1 1],'FaceColor',[1 1 1]);
    pause(1)
    
    % Guarda las respuestas y el tipo de trial
    TmData(kk,:) = [toc TypeTrial(kk)>umbType];
    
end
close,
