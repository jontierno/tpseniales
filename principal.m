
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
%quito la continua
senial = SENIAL_ORIGINAL - mean(SENIAL_ORIGINAL);

%% FILTRADO
ORDEN_FILTRO = 5000;
%paso un pasabanda donde esta la señal
b = fir1(ORDEN_FILTRO,[35/FREC_NYQUIST 350/FREC_NYQUIST]);
senial_con_pasabanda = filter(b,1,senial);
senial_con_pasabanda = senial_con_pasabanda(round((ORDEN_FILTRO-1)/2): length(senial_con_pasabanda));
%la ventaneo
senial_recortada = senial_con_pasabanda;
for K = 1:10*FRECUENCIA_MUESTREO
    senial_recortada(K) =0;
end
for K = 22*FRECUENCIA_MUESTREO:LONGITUD_SENIAL
    senial_recortada(K)=0;
end

%% Espectros

figure
subplot(2,2,1), printspect(senial, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(original)');

%dibujo el espectro de la filtrada1
subplot(2,2,2), printspect(senial_con_pasabanda, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(Con Pasabanda)');

%dibujo el espectro de la recortada
subplot(2,2,[3,4]), printspect(senial_recortada, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(Pasabanda y Recortada en tiempo)');

%% Espectrograma

window_size = 100;
overlap = round(window_size*0.80);
nfft = FRECUENCIA_MUESTREO;
%figure, spectrogram(filtrada1/max(abs(filtrada1)),w, ov,[], nfft, 'yaxis')
%no se ve bien la que no es ni recortada ni filtrada
figure, spectrogram(senial_recortada/max(abs(senial_recortada)), window_size, overlap, FRECUENCIA_MUESTREO, nfft, 'yaxis')
axis ([TIEMPO_INICIAL_SENIAL TIEMPO_FINAL_SENIAL FREC_INICIAL_SENIAL/1000 FREC_FINAL_SENIAL/1000]);
caxis([-40 -30]);

