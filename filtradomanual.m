% FILTRADO MANUAL DE LA SEÑAL

%% FILTRO
%paso un pasabanda donde esta la señal
b = fir1(ORDEN_FILTRO,[35/FREC_NYQUIST 350/FREC_NYQUIST]);
senial_con_pasabanda = filter(b,1,SENIAL_SIN_CONTINUA);
senial_con_pasabanda = senial_con_pasabanda(round((ORDEN_FILTRO-1) /2):...
    length(senial_con_pasabanda));
%la ventaneo
senial_manual = senial_con_pasabanda;
senial_manual(1:TIEMPO_INICIAL_SENIAL*FRECUENCIA_MUESTREO) = 0;
senial_manual(TIEMPO_FINAL_SENIAL*FRECUENCIA_MUESTREO:LONGITUD_SENIAL) = 0;

%% GRAFICO DE ESPECTRO

figure
subplot(2,2,1), imprimirTransformada(SENIAL_SIN_CONTINUA,...
    FRECUENCIA_MUESTREO,1); 
axis([-inf inf 10e-21 inf]);
title('Espectro vs Frecuencia(original)');

%dibujo el espectro de la filtrada1
subplot(2,2,2), imprimirTransformada(senial_con_pasabanda,...
    FRECUENCIA_MUESTREO,1); 
title('Espectro vs Frecuencia(Con Pasabanda)');
axis([-400 400 10e-20 inf]);
%dibujo el espectro de la recortada
subplot(2,2,[3,4]), imprimirTransformada(senial_manual,...
    FRECUENCIA_MUESTREO,1); 
title('Espectro vs Frecuencia(Pasabanda y Recortada en tiempo)');
axis([-400 400 10e-22 inf]);
%% ESPECTROGRAMA
figure, spectrogram(senial_con_pasabanda/max(abs(senial_con_pasabanda)), ... 
    ESPECTRO_WINDOW, ESPECTRO_OVERLAP,ESPECTRO_NFFT, ...
        FRECUENCIA_MUESTREO, 'yaxis');
axis ([TIEMPO_INICIAL_SENIAL-4 TIEMPO_FINAL_SENIAL+4 ...
    0 FREC_FINAL_SENIAL/1000 + 0.3]);
caxis([-75 -62]);
colormap(ESPECTRO_COLORMAP);
title('Espectrograma Señal filtrada');
ylabel('Frecuencia [KHz]');
xlabel('Tiempo [seg]');


figure, spectrogram(senial_manual/max(abs(senial_manual)), ... 
    ESPECTRO_WINDOW, ESPECTRO_OVERLAP,ESPECTRO_NFFT, ...
        FRECUENCIA_MUESTREO, 'yaxis');
axis ([TIEMPO_INICIAL_SENIAL TIEMPO_FINAL_SENIAL ...
    FREC_INICIAL_SENIAL/1000 FREC_FINAL_SENIAL/1000]);
caxis([-40 -30]);
colormap(ESPECTRO_COLORMAP);
title('Espectrograma Señal filtrada');
ylabel('Frecuencia [KHz]');
xlabel('Tiempo [seg]');


%% ESPECTROGRAMA SUPER ZOOM
figure, spectrogram(senial_manual/max(abs(senial_manual)), ... 
    ESPECTRO_WINDOW, ESPECTRO_OVERLAP,ESPECTRO_NFFT, ...
        FRECUENCIA_MUESTREO, 'yaxis');
axis ([16.35 16.48...
    FREC_INICIAL_SENIAL/1000 FREC_FINAL_SENIAL/1000]);
caxis([-40 -30]);
colormap(ESPECTRO_COLORMAP);
hold on;
yaxis = [0, 1];
plot([16.4 16.4],yaxis,'--','color', [0 1 0],'LineWidth',1);
plot([16.425 16.425],yaxis,'--','color', [0 1 0],'LineWidth',1);
text(16.4,0.2,'\leftarrow 16.400','color', [0 1 0]);
text(16.425,0.2,'\leftarrow 16.425','color', [0 1 0]);
title('Espectrograma Señal filtrada');
ylabel('Frecuencia [KHz]');
xlabel('Tiempo [seg]');
hold off;
%% GRAFICO DE LA SENIAL;
figure;
subplot(2,1,1), imprimirSenial(SENIAL_SIN_CONTINUA, FRECUENCIA_MUESTREO);
title('Señal original');
subplot(2,1,2), imprimirSenial(senial_manual, FRECUENCIA_MUESTREO);
title('Señal retocada');
axis([TIEMPO_INICIAL_SENIAL TIEMPO_FINAL_SENIAL -inf inf ]);