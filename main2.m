
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

%filtrada2=filtrada1
%la ventaneo
recortada = filtrada1;
for K = 1:10*FRECUENCIA_MUESTREO
    recortada(K) =0;
end
for K = 22*FRECUENCIA_MUESTREO:length(senial)-1
    recortada(K)=0;
end


%saco unos picos que molestan (esto no mejora en nada
filtrada2 = recortada;
b = fir1(5000,[300/nyquist 360/nyquist],'stop');
%filtrada2 = filter(b,1,filtrada2);
b = fir1(5000,[10/nyquist 100/nyquist],'stop');
%filtrada2 = filter(b,1,filtrada2);
b = fir1(5000,[175/nyquist 200/nyquist],'stop');
%filtrada2 = filter(b,1,filtrada2);
b = fir1(5000,[330/nyquist 335/nyquist],'stop');
%filtrada2 = filter(b,1,filtrada2);
b = fir1(5000,[304/nyquist 319/nyquist],'stop');
%filtrada2 = filter(b,1,filtrada2);
b = fir1(5000,[58/nyquist 62/nyquist],'stop');
%filtrada2 = filter(b,1,filtrada2);
b = fir1(5000,[178/nyquist 182/nyquist],'stop');
%filtrada2 = filter(b,1,filtrada2);





%% Espectros


close all;
subplot(2,2,1), printspect(senial, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(original)');


%dibujo el espectro de la filtrada1
subplot(2,2,2), printspect(filtrada1, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(pasabanda)');

%dibujo el espectro de la recortada
subplot(2,2,3), printspect(recortada, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(ventaneada)');

%dibujo el espectro de la filtrada2
subplot(2,2,4), printspect(filtrada2, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(notchs)');




%% Espectrograma
close all;
w = 256;
ov = 200;
nfft = FRECUENCIA_MUESTREO;
%figure, spectrogram(filtrada1/max(abs(filtrada1)),w, ov,[], nfft, 'yaxis')
%no se ve bien la que no es ni recortada ni filtrada
figure, spectrogram(recortada/max(abs(filtrada2)),w, ov,[], nfft, 'yaxis')
axis ([15 20 0.03 0.35]);





