function printspect(senial, samplingFrec)
    N = length(senial);
    spect = fft(senial); % hago la DFT
    Y_eje = samplingFrec * [0:N-1]/N;
    figure
    subplot (2, 1, 1)
    plot(Y_eje,abs(spect));
    T= title ("Espectro vs Frecuencia");
    set (T, "fontsize", 12); 
    xlabel ("frecuencia [Hz]");
    ylabel ("espectro (módulo)");
    #L = legend(strcat(["Intensidad \nDuracion ",num2str(duration)," seg"]));
    #set (L, "fontsize", 10);   

    spect(1) = 0; %filtro la continua;
    subplot (2, 1, 2)
    plot(Y_eje,abs(spect))   
    T= title ("Espectro vs Frecuencia (sin continua)");
    set (T, "fontsize", 12); 
    xlabel ("frecuencia [Hz]");
    ylabel ("espectro (módulo)");
endfunction