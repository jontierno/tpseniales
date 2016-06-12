% SCRIPT PRINCIPAL


%% IMPRESION DE LA SEÑAL
clear all, close all;
init4k; 
figure, imprimirSenial(SENIAL_SIN_CONTINUA, FRECUENCIA_MUESTREO)
title('Señal original');

figure, imprimirTransformada(SENIAL_SIN_CONTINUA, FRECUENCIA_MUESTREO)
title('Espectro de la Señal original');

figure, figure, spectrogram(SENIAL_SIN_CONTINUA/max(abs(SENIAL_SIN_CONTINUA)), ... 
    ESPECTRO_WINDOW, ESPECTRO_OVERLAP,ESPECTRO_NFFT, FRECUENCIA_MUESTREO, 'yaxis');
%% FILTRADO MANUL
clear all, close all;
init4k;
filtradomanual;

%% FILTRADO AUTOMATICO.
clear all, close all;
init4k;
graficarfiltradoaut;

%% A PARTIR DE LA SEÑAL DE 16K HAGO EL FILTRADO AUTOMATICO.
clear all, close all;
init4k;
init16k;
graficarfiltradoaut;
caxis([-82 -40]);
%% CORRELACIONAR AMBAS
clear all, close all;
init4k;
correlacionar;

%% Prueba
t = 0:1/1e3:2;
y = chirp(t,0,1,250);
y = y-mean(y);
figure, plot(t,y);
figure, imprimirTransformada(y, 1e3);
title('Espectro de Chirp Ejemplo');
