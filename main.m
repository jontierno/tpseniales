close all,clear all;
FRECUENCIA_MUESTREO  = 4096;       % frec de muestreo
ARCHIVO_MUESTRAS =  'L-L1_LOSC_4_V1-1126259446-32.txt';

%CARGO LA SEÑAL DESDE EL ARCHIVO
senial = load (ARCHIVO_MUESTRAS);
senial = transpose(senial);
%DIBUJO LA SEÑAL EN FUNCION DEL TIEMPO
timeline = printsignal(senial, FRECUENCIA_MUESTREO);

   
 printspect(senial, FRECUENCIA_MUESTREO);       
          