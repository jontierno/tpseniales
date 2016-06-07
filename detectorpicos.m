close all,clear all;
FRECUENCIA_MUESTREO  = 4096;       % frec de muestreo
ARCHIVO_MUESTRAS =  'L-L1_LOSC_4_V1-1126259446-32.txt';
senial = load (ARCHIVO_MUESTRAS);
N = length(senial);
nyquist = FRECUENCIA_MUESTREO/2;

