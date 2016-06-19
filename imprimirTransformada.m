% Imprime la transformada de fourier.

function imprimirTransformada(senial, samplingFrec, logaritmica)
    N = length(senial); 
    spect = fft(senial); % hago la DFT
    spect = fftshift(spect);
    eje_frec = linspace(-samplingFrec/2, samplingFrec/2, N);
    %figure
    if logaritmica
        semilogy(eje_frec, abs(spect))
        ylabel ('Espectro [log(módulo)]')
    else
        plot(eje_frec,abs(spect));
        ylabel ('Espectro [módulo]')
    end;
        
   
    T= title ('Transformada vs Frecuencia');
    set (T, 'fontsize', 12); 
    xlabel ('Frecuencia [Hz]');
    
   
end