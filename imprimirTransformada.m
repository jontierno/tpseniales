% Imprime la transformada de fourier.

function imprimirTransformada(senial, samplingFrec)
    N = length(senial); 
    spect = fft(senial); % hago la DFT
    spect = fftshift(spect);
    eje_frec = linspace(-samplingFrec/2, samplingFrec/2, N);
    %figure
   plot(eje_frec,abs(spect));
    T= title ('Transformada vs Frecuencia');
    set (T, 'fontsize', 12); 
    xlabel ('Frecuencia [Hz]');
    ylabel ('Espectro (módulo)');
   
end