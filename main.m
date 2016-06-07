close all,clear all;
FRECUENCIA_MUESTREO  = 4096;       % frec de muestreo
ARCHIVO_MUESTRAS =  'L-L1_LOSC_4_V1-1126259446-32.txt';

%#CARGO LA SEÑAL DESDE EL ARCHIVO
senial = load (ARCHIVO_MUESTRAS);
%senial = transpose(senial);
N = length(senial);

%quito la continua
senial = senial - mean(senial);

%DIBUJO LA SEÑAL EN FUNCION DEL TIEMPO
%timeline = printsignal(senial, FRECUENCIA_MUESTREO);



%Hpn2 = notch1000();
%filtered = filter(Hpn2,senial);
%filtered1 = filter(notch,filtered);
%filtered2 = filter(notch2,filtered1);
%filtered3 = filter(notch3,filtered2);
%filtered4 = filter(notch4,filtered3);
b = fir1(5000,[35/FRECUENCIA_MUESTREO 350/FRECUENCIA_MUESTREO]);
filtered = filter(b,1,senial);
figure, printspect(filtered, FRECUENCIA_MUESTREO);      
      
%subplot(3,2,2), printspect(filtered, FRECUENCIA_MUESTREO);       
%subplot(3,2,3), printspect(filtered1, FRECUENCIA_MUESTREO);       
%subplot(3,2,4), printspect(filtered2, FRECUENCIA_MUESTREO); 
%subplot(3,2,5), printspect(filtered3, FRECUENCIA_MUESTREO); 
%subplot(3,2,6), printspect(filtered4, FRECUENCIA_MUESTREO); 


%%
%figure, 
w = 1000;
ov = 800;
nfft = FRECUENCIA_MUESTREO;
y = filtered(10*FRECUENCIA_MUESTREO:20*FRECUENCIA_MUESTREO)

%ventana = [zeros(FRECUENCIA_MUESTREO*10) ones(FRECUENCIA_MUESTREO*10) zeros(FRECUENCIA_MUESTREO*12)];
%figure;
%spectrogram(y/max(abs(y)),blackman(256), 128,[], nfft, 'yaxis')
figure, printspect(y, FRECUENCIA_MUESTREO); 
%axis ([10 20 0.03 0.35]);
%subplot (3,2,2), spectrogram(filtered*1e30,w, ov,[], nfft, 'yaxis')
%axis ([10 20 0.03 0.35]);
%subplot (3,2,3), spectrogram(filtered1*1e30,w, ov,[], nfft, 'yaxis')
%axis ([10 20 0.03 0.35]);
%subplot (3,2,4), spectrogram(filtered2*1e30,w, ov,[], nfft, 'yaxis')
%axis ([10 20 0.03 0.35]);
%subplot (3,2,5), spectrogram(filtered3*1e30,w, ov,[], nfft, 'yaxis')
%axis ([10 20 0.03 0.35]);
%subplot (3,2,6), spectrogram(filtered4*1e30,w, ov,[], nfft, 'yaxis')
%axis ([10 20 0.03 0.35]);