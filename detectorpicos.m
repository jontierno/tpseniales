close all,clear all;
FRECUENCIA_MUESTREO  = 4096;       % frec de muestreo
ARCHIVO_MUESTRAS =  'L-L1_LOSC_4_V1-1126259446-32.txt';
senial = load (ARCHIVO_MUESTRAS);
senial = senial - mean (senial);
N = length(senial);

nyquist = FRECUENCIA_MUESTREO/2;


spect = fftshift(fft(senial));
absspect = abs(spect);
%absspect = sgolayfilt(absspect,3,301); esto suabiza la señal
eje_frec = linspace(-FRECUENCIA_MUESTREO/2, FRECUENCIA_MUESTREO/2, N);


nyquist = FRECUENCIA_MUESTREO/2;
spect = fftshift(fft(senial));
absspect = abs(spect);
eje_frec = linspace(-FRECUENCIA_MUESTREO/2, FRECUENCIA_MUESTREO/2, N);
hold on;
for k = 0:300 
    [pks,locs] = findpeaks(absspect,'MinPeakProminence',max(absspect)*0.99);
    absspect(locs)= 0;
    spect(locs) = 0;
    plot(eje_frec(locs),pks,'or')
    k= k+1;
    
end
plot(eje_frec,absspect);



%% Espectrograma
%close all;

senial = ifft(fftshift(spect));
w = 100;
ov = round(w*0.80);
nfft = FRECUENCIA_MUESTREO;
%figure, spectrogram(filtrada1/max(abs(filtrada1)),w, ov,[], nfft, 'yaxis')
%no se ve bien la que no es ni recortada ni filtrada
figure, spectrogram(senial/max(abs(senial)),w, ov,[], nfft, 'yaxis')
axis ([15 20 0.03 0.35]);
caxis([-70 -30]);

%% Grafico lo original
absspect = abs(spect);
[pks,locs] = findpeaks(absspect,'MinPeakProminence',max(absspect)*0.99);
plot(eje_frec,absspect,eje_frec(locs),pks,'or')

