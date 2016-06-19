%% GRAFICOS DEL FILTRADO AUTOMATICO

filtradoautomatico;

%% GRAFICO DE ESPECTRO

% Dibujo el espectro con los filtros y marco los filtros.
maximo = max(abs(ESPECTRO_SENIAL_SIN_CONTINUA));
figure
subplot(2,1,1), imprimirTransformada(SENIAL_SIN_CONTINUA,...
    FRECUENCIA_MUESTREO,1); 
title('Espectro Original');

hold on;
yaxis = [1e-30, 1e-10];
for k = 1:2:length(frecuencias)

    subplot(2,1,1)
    colorgr  = rand(1,3);
    plot([frecuencias(k) frecuencias(k)],yaxis,'--','color',colorgr,'LineWidth',1);
    plot([frecuencias(k+1) frecuencias(k+1)],yaxis,'--', 'color',colorgr,'LineWidth',1);
end;

hold off;
axis([-100,2100, 1e-22, 1e-13]);
subplot(2,1,2), imprimirTransformada(filtrada_automatica, ...
    FRECUENCIA_MUESTREO,1); 
title('Espectro Filtrado');
axis([-100 2100 1e-19 inf])
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
axis ([TIEMPO_INICIAL_SENIAL-5 TIEMPO_FINAL_SENIAL+5 ...
     0 FREC_FINAL_SENIAL/1000 + 0.4]);
caxis([-75 -65]);
colormap(ESPECTRO_COLORMAP);
title('Espectrograma Señal filtrada');
xlabel('Tiempo [seg]');
ylabel('Frecuencia [KHz]');

%% SUPERZOOM.
figure, spectrogram(filtrada_automatica/max(abs(filtrada_automatica)), ... 
    ESPECTRO_WINDOW, ESPECTRO_OVERLAP,ESPECTRO_NFFT, ...
        FRECUENCIA_MUESTREO, 'yaxis');
axis ([16.35 16.45...
     0 FREC_FINAL_SENIAL/1000]);
caxis([-75 -65]);
colormap(ESPECTRO_COLORMAP);
title('Espectrograma Señal filtrada');
xlabel('Tiempo [seg]');
ylabel('Frecuencia [KHz]');
hold on;
yaxis = [0, 1];
plot([16.40 16.40],yaxis,'--','color', [0 1 0],'LineWidth',1);
plot([16.42 16.42],yaxis,'--','color', [0 1 0],'LineWidth',1);
text(16.40,0.2,'\leftarrow 16.40','color', [0 1 0]);
text(16.42,0.2,'\leftarrow 16.42','color', [0 1 0]);
title('Espectrograma Señal filtrada');
ylabel('Frecuencia [KHz]');
xlabel('Tiempo [seg]');
hold off;
