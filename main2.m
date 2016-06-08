
%% Inicializacion de la señal
close all,clear all;
FRECUENCIA_MUESTREO  = 4096;       % frec de muestreo
ARCHIVO_MUESTRAS =  'L-L1_LOSC_4_V1-1126259446-32.txt';
senial = load (ARCHIVO_MUESTRAS);
N = length(senial);
nyquist = FRECUENCIA_MUESTREO/2;

%% Filtrado

%quito la continua
senial = senial - mean(senial);

%paso un pasabanda 35-350
b = fir1(5000,[35/nyquist 350/nyquist]);
filtrada1 = filter(b,1,senial);

%la ventaneo
recortada = filtrada1;
for K = 1:10*FRECUENCIA_MUESTREO
    recortada(K) =0;
end
for K = 22*FRECUENCIA_MUESTREO:length(senial)
    recortada(K)=0;
end

filtrada2 = recortada;




%% Señal en el tiempo%% Señal original
figure
subplot(3,1,1), printsignal(senial, FRECUENCIA_MUESTREO);
title('Intensidad vs Tiempo(original)');
subplot(3,1,2), printsignal(filtrada1, FRECUENCIA_MUESTREO);
title('Intensidad vs Tiempo(pasabanda)');
subplot(3,1,3), printsignal(recortada, FRECUENCIA_MUESTREO);
title('Intensidad vs Tiempo(ventaneada)');

%% Espectros

%close all;
figure
subplot(3,1,1), printspect(senial, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(original)');


%dibujo el espectro de la filtrada1
subplot(3,1,2), printspect(filtrada1, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(pasabanda)');

%dibujo el espectro de la recortada
subplot(3,1,3), printspect(recortada, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(ventaneada)');




%% Espectrograma
%close all;

w = 100;
ov = round(w*0.80);
nfft = FRECUENCIA_MUESTREO;
%figure, spectrogram(filtrada1/max(abs(filtrada1)),w, ov,[], nfft, 'yaxis')
%no se ve bien la que no es ni recortada ni filtrada
figure, spectrogram(recortada/max(abs(recortada)),w, ov,FRECUENCIA_MUESTREO, nfft, 'yaxis')
axis ([15 20 0.03 0.35]);
caxis([-40 -30]);





