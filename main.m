close all,clear all;
pkg load signal;
FRECUENCIA_MUESTREO  = 4096;       % frec de muestreo
ARCHIVO_MUESTRAS =  'L-L1_LOSC_4_V1-1126259446-32.txt';

%CARGO LA SEÑAL DESDE EL ARCHIVO
senial = load (ARCHIVO_MUESTRAS);
senial = transpose(senial);
N = length(senial);
senial = senial - mean(senial);
%DIBUJO LA SEÑAL EN FUNCION DEL TIEMPO
timeline = printsignal(senial, FRECUENCIA_MUESTREO);

   
printspect(senial, FRECUENCIA_MUESTREO);       

#w1 = hamming(400);  % ventana hamming
#Y = fft(senial);
#figure, specgram(senial, 1000) 
#[b,a] = butter(1, [30/(2*pi * FRECUENCIA_MUESTREO), 400/(2*pi * FRECUENCIA_MUESTREO)]);
#filtered = filter(b,a,senial);
#printsignal(filtered, FRECUENCIA_MUESTREO);
#printspect(filtered, FRECUENCIA_MUESTREO); 
#plot(timeline, filtered);