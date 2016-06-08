close all,clear all;
FRECUENCIA_MUESTREO  = 4096;       % frec de muestreo
nyquist = FRECUENCIA_MUESTREO/2;
ARCHIVO_MUESTRAS =  'L-L1_LOSC_4_V1-1126259446-32.txt';
senial = load (ARCHIVO_MUESTRAS);
senial = senial - mean (senial);
NFFT = length(senial);



spect = fft(senial);
absspect = abs(spect);
eje_frec = linspace(-FRECUENCIA_MUESTREO/2, FRECUENCIA_MUESTREO/2, NFFT);


%% Detecto los tonos
close all;
%Parametros iniciales
UMBRAL = 1e-17;
%UMBRAL = max(absspect)*0.2;
ANCHO_FILTRO = 250;
ORDEN_FILTRO = 5000;
%ME QUEDO SOLO CON LA MITAD DEL ESPECTRO, EL RESTO SE REPITE
absspect =  absspect(1:NFFT/2);


picos = absspect > UMBRAL;
filtro = ones(1, ANCHO_FILTRO);
picos = filter(filtro, 1, picos);
picos = picos >= 1;

indicadores = diff(picos);

frecuencias = [];
for k = 1:length(indicadores)
    if indicadores(k) == 1
        start = k;
    end
    if indicadores(k) == -1
        start = start - 1 *NFFT/FRECUENCIA_MUESTREO;
        if start < 0
            start = 0.01 *NFFT/FRECUENCIA_MUESTREO;
        end
        frecuencias = [frecuencias; [start k]* FRECUENCIA_MUESTREO/NFFT];
    end
end;


filtrada = senial;
for k = 1:length(frecuencias)
    b = fir1(ORDEN_FILTRO,[frecuencias(k,1)/nyquist frecuencias(k,2)/nyquist],'stop');
    filtrada= filter(b,1,filtrada);
    filtrada = filtrada(round((ORDEN_FILTRO-1)/2): length(filtrada));
%     figure
%     printspect(filtrada, FRECUENCIA_MUESTREO); 
end;

%% espectros
figure
maximo = max(absspect);
subplot(2,1,1), printspect(senial, FRECUENCIA_MUESTREO); 
title('Espectro Original');
hold on;
for k = 1:length(frecuencias)
    yaxis = [0, maximo];
    subplot(2,1,1)
    colorgr  = rand(1,3);
    plot([frecuencias(k,1) frecuencias(k,1)],yaxis,'color',colorgr);
    plot([frecuencias(k,2) frecuencias(k,2)],yaxis,'color',colorgr);
end;

hold off;
subplot(2,1,2), printspect(filtrada, FRECUENCIA_MUESTREO); 
title('Espectro Filtrado');

%% Espectrograma

w = 100;
ov = round(w*0.80);
figure, spectrogram(filtrada/max(abs(filtrada)),w, ov,[], FRECUENCIA_MUESTREO, 'yaxis')
axis ([15 20 0.03 0.35]);
%caxis([-60 -10]);





