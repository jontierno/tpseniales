
%% INICIALIZACIÓN
close all,clear all;
FRECUENCIA_MUESTREO  = 4096;       % frec de muestreo
ARCHIVO_MUESTRAS =  'L-L1_LOSC_4_V1-1126259446-32.txt';
SENIAL_ORIGINAL = load (ARCHIVO_MUESTRAS);
LONGITUD_SENIAL = length(SENIAL_ORIGINAL);
FREC_NYQUIST = FRECUENCIA_MUESTREO/2;
FREC_INICIAL_SENIAL = 35;
FREC_FINAL_SENIAL = 350;
TIEMPO_INICIAL_SENIAL= 15;
TIEMPO_FINAL_SENIAL = 17;

UMBRAL_FILTRO_AUTOMATICO = 1e-17;
ORDEN_FILTRO = 5000;

%quito la continua
SENIAL_SIN_CONTINUA = SENIAL_ORIGINAL - mean(SENIAL_ORIGINAL);
ESPECTRO_SENIAL_SIN_CONTINUA = fft(SENIAL_SIN_CONTINUA);



%% FILTRADO MANUL

%paso un pasabanda donde esta la señal
b = fir1(ORDEN_FILTRO,[35/FREC_NYQUIST 350/FREC_NYQUIST]);
senial_con_pasabanda = filter(b,1,SENIAL_SIN_CONTINUA);
senial_con_pasabanda = senial_con_pasabanda(round((ORDEN_FILTRO-1)/2):...
    length(senial_con_pasabanda));
%la ventaneo
senial_manual = senial_con_pasabanda;
for K = 1:10*FRECUENCIA_MUESTREO
    senial_manual(K) =0;
end
for K = 22*FRECUENCIA_MUESTREO:LONGITUD_SENIAL
    senial_manual(K)=0;
end

%% Espectros

figure
subplot(2,2,1), printspect(SENIAL_SIN_CONTINUA, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(original)');

%dibujo el espectro de la filtrada1
subplot(2,2,2), printspect(senial_con_pasabanda, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(Con Pasabanda)');

%dibujo el espectro de la recortada
subplot(2,2,[3,4]), printspect(senial_manual, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(Pasabanda y Recortada en tiempo)');

%% Espectrograma

window_size = 100;
overlap = round(window_size*0.80);
nfft = FRECUENCIA_MUESTREO;
figure, spectrogram(senial_manual/max(abs(senial_manual)), window_size,...
    overlap, nfft, FRECUENCIA_MUESTREO, 'yaxis')
axis ([TIEMPO_INICIAL_SENIAL TIEMPO_FINAL_SENIAL ...
    FREC_INICIAL_SENIAL/1000 FREC_FINAL_SENIAL/1000]);
caxis([-40 -30]);
colormap('bone');

%% FILTRADO AUTOMATICO.

% PARA BUSCAR LOS FILTROS

% me quedo solo con la mitad del espectro
espectro =  ESPECTRO_SENIAL_SIN_CONTINUA(1:...
    length(ESPECTRO_SENIAL_SIN_CONTINUA)/2);

% paso el umbral para obtener los picos, la frecuencia de muestreo, y con
% cuantos puntos se hace la fft
frecuencias = detectarPicos(espectro, UMBRAL_FILTRO_AUTOMATICO, ...
    FRECUENCIA_MUESTREO, LONGITUD_SENIAL);


 filtrada_automatica = SENIAL_SIN_CONTINUA;
 for k = 1:length(frecuencias)
     b = fir1(ORDEN_FILTRO,[frecuencias(k,1)/FREC_NYQUIST ...
         frecuencias(k,2)/FREC_NYQUIST],'stop');
     % filtro notch
     filtrada_automatica= filter(b,1,filtrada_automatica);
     
     % como el fir1 es un filtro de retardo de grupo constante, puedo
     % acomodar el delay de la senial filtrada (retardo= (orden -1) /2
     filtrada_automatica = filtrada_automatica(round((ORDEN_FILTRO-1)/2):...
         length(filtrada_automatica));
 end;

%% Espectro de filtrado automatico
% Dibujo el espectro con los filtros y marco los filtros.
maximo = max(abs(ESPECTRO_SENIAL_SIN_CONTINUA));
figure
subplot(2,1,1), printspect(SENIAL_SIN_CONTINUA, FRECUENCIA_MUESTREO); 
title('Espectro Original');

hold on;
for k = 1:length(frecuencias)
    yaxis = [0, 1];
    subplot(2,1,1)
    colorgr  = rand(1,3);
    plot([frecuencias(k,1) frecuencias(k,1)],yaxis,'--','color',colorgr);
    plot([frecuencias(k,2) frecuencias(k,2)],yaxis,'--', 'color',colorgr);
end;

hold off;
axis([-inf,inf,-inf,maximo*1.1]);
subplot(2,1,2), printspect(filtrada_automatica, FRECUENCIA_MUESTREO); 
title('Espectro Filtrado');


%% Espectrograma del filtrado automatico.

window_size = 100;
overlap = round(window_size*0.80);
figure, spectrogram(filtrada_automatica/max(abs(filtrada_automatica)), ... 
    window_size, overlap,[], FRECUENCIA_MUESTREO, 'yaxis');
axis ([15 20 0.03 0.35]);
caxis([-70 -60]);
colormap('bone');

