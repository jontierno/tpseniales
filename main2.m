
%% Inicializacion de la señal
close all,clear all;
FRECUENCIA_MUESTREO  = 4096;       % frec de muestreo
ARCHIVO_MUESTRAS =  'L-L1_LOSC_4_V1-1126259446-32.txt';
senial = load (ARCHIVO_MUESTRAS);
N = length(senial);


%% Filtrado

%quito la continua
senial = senial - mean(senial);

%paso un pasabanda 35-350
b = fir1(5000,[35/FRECUENCIA_MUESTREO 350/FRECUENCIA_MUESTREO]);
filtered = filter(b,1,senial);

%la ventaneo
recortada = filtered;
for K = 1:10*FRECUENCIA_MUESTREO
    recortada(K) =0;
end
for K = 22*FRECUENCIA_MUESTREO:length(senial)-1
    recortada(K)=0;
end

%% Espectros
subplot(3,1,1), printspect(senial, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(original)');

%dibujo el espectro de la filtrada
subplot(3,1,2), printspect(filtered, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(filtrada)');


%dibujo el espectro de la recortada
subplot(3,1,3), printspect(recortada, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(ventaneada)');

%% Espectrograma

w = 256;
ov = 128;
nfft = FRECUENCIA_MUESTREO;
figure, spectrogram(recortada/max(abs(recortada)),w, ov,[], nfft, 'yaxis')
axis ([15 20 0.03 0.35]);