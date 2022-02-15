%%TRACK3

%limpiar variables
clear all;

% arreglo para los colores
greycolor = [155 155 155];
bluecolor = [0 0 255];

% arreglo para el tamaño de pantalla
rect = [10 10 200 200];

%se define el tiempo de espera en segundos
WaitingTimeSeconds=5;

%Cantidad de circulos
AmountCircles=5;

%se define el tamaño del circulo en pixeles
CircleSize=10;

%se realiza la apertura de la ventana
window = Screen('OpenWindow', 0, greycolor, rect);

%se obtiene las dimenciones de la pantalla obtenida
[screenXpixels,screenYpixels] = Screen('WindowSize',window);

%se reduce el tamaño del area para evitar que los puntos salgan del
%espacio
screenXpixels = screenXpixels * 0.9;
screenYpixels = screenYpixels * 0.9;

%ciclo for para crear los circulos
for i = 1:AmountCircles
    %randomizar los ejes X e Y
    dotXpos = round(rand * screenXpixels,0);
    dotYpos = round(rand * screenYpixels,0);
    %se dibuja un circulo a la vez
    Screen('DrawDots',window,[dotXpos dotYpos], CircleSize, bluecolor,[],2);
end
%Se despliega la informacion dibujada
Screen('Flip',window,0,0);

%se espera los segundos de espera
WaitSecs(WaitingTimeSeconds);

%se agrega un cuadro gris para cubrir los puntos y "limpiar" la
%pantalla
Screen('FillRect',window,greycolor,rect);

%Se despliega la informacion dibujada
Screen('Flip',window,0,0);

%se espera los segundos de espera
WaitSecs(WaitingTimeSeconds);

%Se asume que el archivo de imagen se encuentra en el mismo
theImageLocation = ['meme.jpeg'];

%Se realiza lectura de la imagen
theImage = imread(theImageLocation);

% Obtener el tamaño de la imagen
[s1, s2, s3] = size(theImage);

%division para manter la proporcionalidad de la dimension de la imagen al
%ajustar el tamaño
aspectRatio = s2 / s1;

%calculo el tamaño de la imagen dentro de la pantalla al 80% del tamaño
imageHeight = screenYpixels * 0.8;
imageWidth = imageHeight * aspectRatio;

% Se  busca el punto central de la pantalla (Screen)
theRect = [0 0 imageWidth imageHeight];
dstRect= CenterRectOnPointd(theRect, screenXpixels / 2,...
    screenYpixels / 2);

% Convierte la imagen en una textura
imageTexture = Screen('MakeTexture', window, theImage);

%Dibuja la imagen proveniente de la textura
Screen('DrawTexture', window, imageTexture, [], dstRect,0);

%despliegue de la imagen dibujada en la linea anterior.
Screen('Flip',window,0,0);

% Espera para cierre de pantalla
WaitSecs(WaitingTimeSeconds);

%cierre de pantallas
Screen('CloseAll')



