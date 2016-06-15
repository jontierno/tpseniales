%% GRAFICOS DEL FILTRADO AUTOMATICO

filtradoautomatico;

%% GRAFICO DE ESPECTRO

% Dibujo el espectro con los filtros y marco los filtros.
maximo = max(abs(ESPECTRO_SENIAL_SIN_CONTINUA));
figure
subplot(2,1,1), imprimirTransformada(SENIAL_SIN_CONTINUA,...
    FRECUENCIA_MUESTREO); 
title('Espectro Original');

hold on;
yaxis = [0, 1];
for k = 1:2:length(frecuencias)

    subplot(2,1,1)
    colorgr  = rand(1,3);
    plot([frecuencias(k) frecuencias(k)],yaxis,'--','color',colorgr);
    plot([frecuencias(k+1) frecuencias(k+1)],yaxis,'--', 'color',colorgr);
end;

hold off;
axis([-inf,inf,-inf,maximo*1.1]);
subplot(2,1,2), imprimirTransformada(filtrada_automatica, ...
    FRECUENCIA_MUESTREO); 
title('Espectro Filtrado');

%% GRAFICO DE LA SENIAL;
figure;
subplot(2,1,1), imprimirSenial(SENIAL_SIN_CONTINUA, FRECUENCIA_MUESTREO);
title('Señal Original');
subplot(2,1,2), imprimirSenial(filtrada_automatica, FRECUENCIA_MUESTREO);
title('Señal Filtrada');
%% ESPECTROGRAMA

figure, spectrogram(filtrada_automatica/max(abs(filtrada_automatica)), ... 
    ESPECTRO_WINDOW, ESPECTRO_OVERLAP,ESPECTRO_NFFT, ...
        FRECUENCIA_MUESTREO, 'yaxis');
% axis ([TIEMPO_INICIAL_SENIAL TIEMPO_FINAL_SENIAL ...
%     FREC_INICIAL_SENIAL/1000 FREC_FINAL_SENIAL/1000]);
caxis([-70 -60]);
colormap(ESPECTRO_COLORMAP);
title('Espectrograma Señal filtrada');
xlabel('Tiempo [seg]');
ylabel('Frecuencia [KHz]');

