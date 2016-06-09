  
init4k;
%% FILTRO PASAALTOS
b = fir1(ORDEN_FILTRO,FREC_INICIAL_SENIAL/FREC_NYQUIST,'high');
filtrada= filter(b,1,SENIAL_SIN_CONTINUA);
filtrada = filtrada(round((ORDEN_FILTRO-1) /2):...
          length(filtrada));
      
      
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
SEG_INICIO=10;
SEG_FIN = 17;
INICIO_CORR = SEG_INICIO * FRECUENCIA_MUESTREO;
FIN_CORR= SEG_FIN * FRECUENCIA_MUESTREO;
%LONG_CORR = FIN_CORR -INICIO_CORR;

VENTANA = 100;

xm = filtrada(INICIO_CORR:FIN_CORR);
LONGI=0.1;
t = 0:1/FRECUENCIA_MUESTREO:LONGI;
y = chirp(t,100, LONGI,250);
% figure, imprimirSenial(y,FRECUENCIA_MUESTREO);

figure,  spectrogram(y,VENTANA, VENTANA*0.9,1000, FRECUENCIA_MUESTREO, 'yaxis');
%  axis ([TIEMPO_INICIAL_SENIAL*0.8 TIEMPO_FINAL_SENIAL*1.2 ...
%      FREC_INICIAL_SENIAL*0.8/1000 FREC_FINAL_SENIAL*1.2/1000]);
% colormap(ESPECTRO_COLORMAP);
[C1, L1] = xcorr(xm,y);
figure, plot(L1/FRECUENCIA_MUESTREO + SEG_INICIO,abs(C1).^2,'r');
 
%  correlacion = abs(C1).^2;
%  figure, plot(correlacion);
%  

%% PRUEBA
t = 0:1/FRECUENCIA_MUESTREO:0.1;
y = chirp(t,0, 0.1,350);
%figure, imprimirSenial(y,FRECUENCIA_MUESTREO);
figure,  spectrogram(y,50, 50*0.9,1000, FRECUENCIA_MUESTREO, 'yaxis');