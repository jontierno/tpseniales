  
init4k;
%% FILTRO AUTOMATICO
filtradoautomatico;
%% FILTRO pasabanda
b = fir1(ORDEN_FILTRO,FREC_INICIAL_SENIAL/FREC_NYQUIST,'high');
filtrada= filter(b,1,filtrada_automatica);
filtrada = filtrada((ORDEN_FILTRO /2):...
          length(filtrada));
      
b = fir1(ORDEN_FILTRO,[35/FREC_NYQUIST 350/FREC_NYQUIST]);
filtrada = filter(b,1,filtrada);
filtrada = filtrada(ORDEN_FILTRO /2:end);

      
%% ESPECTROGRAMA

figure, spectrogram(filtrada/max(abs(filtrada)), ... 
    ESPECTRO_WINDOW, ESPECTRO_OVERLAP,ESPECTRO_NFFT, FRECUENCIA_MUESTREO, 'yaxis');
 axis ([TIEMPO_INICIAL_SENIAL*0.8 TIEMPO_FINAL_SENIAL*1.2 ...
     FREC_INICIAL_SENIAL*0.8/1000 FREC_FINAL_SENIAL*1.2/1000]);
% caxis([-70 -60]);

title('Espectrograma Señal filtrada');
caxis([-75 -65]);
colormap(ESPECTRO_COLORMAP);

%% CORRELACIONO
close all;

SEG_INICIO=0.5;
SEG_FIN = 25;

FREC_INI = 35;
FREC_FIN = 350;
pendpos=0.02;
LONGI_SENIAL= 0.02;


INICIO_CORR = SEG_INICIO * FRECUENCIA_MUESTREO;
xm = filtrada(INICIO_CORR:end);


t = 0:1/FRECUENCIA_MUESTREO:LONGI_SENIAL;
y = chirp(t,FREC_INI, pendpos,FREC_FIN, 'linear');

figure;
subplot(2,1,1), imprimirSenial(y,FRECUENCIA_MUESTREO);
title('Chirp');

subplot(2,1,2), imprimirTransformada(y, ...
     FRECUENCIA_MUESTREO); 
 title('Espectro de la Chirp');
[xCorr, lags] = xcorr(xm,y);




figure, plot(lags/FRECUENCIA_MUESTREO + SEG_INICIO,xCorr);
 grid
axis([1 inf -inf inf]);
 
xlabel('Tiempo [seg]');
ylabel('Intensidad');
title('Correlación');
 
 %% Imprimir chirp sobre la señal.
 
    [~,I] = max(abs(xCorr));
    maxt = lags(I);
    
    %me armo una señal de la longitud de la señal original
    Trial = NaN(size(xm));
    %le seteo el fragmento de la señal donde esta la chirp
    Trial(maxt+1:maxt+length(y)) = xm(maxt+1:maxt+length(y));
   
    %ajusto la linea de tiempo
   duracion = (length(xm) / FRECUENCIA_MUESTREO);
   timeline = 0:1/FRECUENCIA_MUESTREO:duracion - 1/FRECUENCIA_MUESTREO; 
   
   figure, plot(timeline + SEG_INICIO, xm, timeline+SEG_INICIO,Trial);
   %hago zoom donde la espero.
   axis([16.4 16.5 -inf inf]);
   title('Señal y Chirp');
   ylabel('Intensidad');
   xlabel('Tiempo [seg]');
   legend('Señal filtrada', 'Chirp');