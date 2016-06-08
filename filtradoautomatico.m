% FILTRADO AUTOMATICO DE LA SEÑAL

%% FILTRADO
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

%% GRAFICO DE ESPECTRO

% Dibujo el espectro con los filtros y marco los filtros.
maximo = max(abs(ESPECTRO_SENIAL_SIN_CONTINUA));
figure
subplot(2,1,1), imprimirTransformada(SENIAL_SIN_CONTINUA,...
    FRECUENCIA_MUESTREO); 
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
subplot(2,1,2), imprimirTransformada(filtrada_automatica, ...
    FRECUENCIA_MUESTREO); 
title('Espectro Filtrado');


%% ESPECTROGRAMA

window_size = 100;
overlap = round(window_size*0.80);
% TOMO UN VALOR ALTO PARA QUE NO PIXELE
nfft = 4000;
figure, spectrogram(filtrada_automatica/max(abs(filtrada_automatica)), ... 
    window_size, overlap,nfft, FRECUENCIA_MUESTREO, 'yaxis');
axis ([TIEMPO_INICIAL_SENIAL TIEMPO_FINAL_SENIAL ...
    FREC_INICIAL_SENIAL/1000 FREC_FINAL_SENIAL/1000]);
caxis([-70 -60]);
colormap('bone');
title('Espectrograma senial filtrada');


%% GRAFICO DE LA SENIAL;
figure;
subplot(2,1,1), imprimirSenial(SENIAL_SIN_CONTINUA, FRECUENCIA_MUESTREO);
subplot(2,1,2), imprimirSenial(filtrada_automatica, FRECUENCIA_MUESTREO);
