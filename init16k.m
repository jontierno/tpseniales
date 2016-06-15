%Este script levanta la señal de 16k;
ARCHIVO_MUESTRAS_16 =  'L-L1_LOSC_16_V1-1126259446-32.txt';
SENIAL_ORIGINAL_16 = load (ARCHIVO_MUESTRAS_16);
senial_16 = SENIAL_ORIGINAL_16 - mean(SENIAL_ORIGINAL_16);
FRECUENCIA_MUESTREO_16 = 4096 *4;
FREC_NYQUIST_16 = FRECUENCIA_MUESTREO_16/2;


b = fir1(ORDEN_FILTRO, 1/4);
senial_conpadding = padarray(senial_16,ORDEN_FILTRO/2,'post');
filtrada = filter(b,1,senial_conpadding);
filtrada = filtrada(ORDEN_FILTRO/2 + 1:end);
SENIAL_SIN_CONTINUA = filtrada(1:4:end);
%SENIAL_SIN_CONTINUA = SENIAL_SIN_CONTINUA();

%UMBRAL_FILTRO_AUTOMATICO = 1e-18;
 ORDEN_FILTRO = 5000;
% % esto es lo mismo que tirar 1 de cuatro muestras.
%  SENIAL_SIN_CONTINUA = downsample(filtrada, 4);
 ESPECTRO_SENIAL_SIN_CONTINUA = fft(SENIAL_SIN_CONTINUA);
 LONGITUD_SENIAL = length(SENIAL_SIN_CONTINUA);