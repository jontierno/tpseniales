close all,clear all;
FRECUENCIA_MUESTREO  = 4096;       % frec de muestreo
ARCHIVO_MUESTRAS =  'L-L1_LOSC_4_V1-1126259446-32.txt';
senial = load (ARCHIVO_MUESTRAS);
N = length(senial);
nyquist = FRECUENCIA_MUESTREO/2;

spect = fft(senial);

k=0;
tolerancia= 1; % en %
detectada = spect;
picos = sparse(N,1);
continuar = true;
while continuar
    continuar=false;
    picomaximo = max(abs(detectada)) * 0.95; % 90% del máximo
    puntos = abs(detectada) > picomaximo;
    cantidad = sum(puntos);
    porcentaje = cantidad/N;
    if porcentaje*100 < tolerancia       
        continuar = true;
        picos = picos + puntos;
        for n = 1:N 
           if puntos(n) > 0
               picos(n) = detectada(n);
               detectada(n) = 0;
           end
        end
    end;
    k = k+1;
end

   
  duration = (N / FRECUENCIA_MUESTREO);
  timeline = 0:1/FRECUENCIA_MUESTREO:duration - 1/FRECUENCIA_MUESTREO;
  eje_frec = linspace(-FRECUENCIA_MUESTREO/2, FRECUENCIA_MUESTREO/2, N);
  
  figure,plot(timeline,abs(spect));
  hold on
  stem(timeline,abs(picos));
  
  %plot(timeline,abs 
  
  
  %% Espectrograma
%close all;
w = 256;
ov = 200;
nfft = FRECUENCIA_MUESTREO;
%figure, spectrogram(filtrada1/max(abs(filtrada1)),w, ov,[], nfft, 'yaxis')
%no se ve bien la que no es ni recortada ni filtrada
figure, spectrogram(detectada/max(abs(detectada)),w, ov,[], nfft, 'yaxis')
axis ([15 20 0.03 0.35]);