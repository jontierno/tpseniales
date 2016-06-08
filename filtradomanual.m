% FILTRADO MANUAL DE LA SEÑAL

%% FILTRO
%paso un pasabanda donde esta la señal
b = fir1(ORDEN_FILTRO,[35/FREC_NYQUIST 350/FREC_NYQUIST]);
senial_con_pasabanda = filter(b,1,SENIAL_SIN_CONTINUA);
senial_con_pasabanda = senial_con_pasabanda(round((ORDEN_FILTRO-1)/2):...
    length(senial_con_pasabanda));
%la ventaneo
senial_manual = senial_con_pasabanda;
for K = 1:10*FRECUENCIA_MUESTREO
    senial_manual(K) =0;
end
for K = 22*FRECUENCIA_MUESTREO:LONGITUD_SENIAL
    senial_manual(K)=0;
end

%% GRAFICO DE ESPECTRO

figure
subplot(2,2,1), printspect(SENIAL_SIN_CONTINUA, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(original)');

%dibujo el espectro de la filtrada1
subplot(2,2,2), printspect(senial_con_pasabanda, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(Con Pasabanda)');

%dibujo el espectro de la recortada
subplot(2,2,[3,4]), printspect(senial_manual, FRECUENCIA_MUESTREO); 
title('Espectro vs Frecuencia(Pasabanda y Recortada en tiempo)');

%% ESPECTROGRAMA

window_size = 100;
overlap = round(window_size*0.80);
nfft = FRECUENCIA_MUESTREO;
figure, spectrogram(senial_manual/max(abs(senial_manual)), window_size,...
    overlap, nfft, FRECUENCIA_MUESTREO, 'yaxis')
axis ([TIEMPO_INICIAL_SENIAL TIEMPO_FINAL_SENIAL ...
    FREC_INICIAL_SENIAL/1000 FREC_FINAL_SENIAL/1000]);
caxis([-40 -30]);
colormap('bone');
title('Espectrograma senial filtrada.');

%% GRAFICO DE LA SENIAL;
figure;
subplot(2,1,1), imprimirSenial(SENIAL_SIN_CONTINUA, FRECUENCIA_MUESTREO);
title('Señal original');
subplot(2,1,2), imprimirSenial(senial_manual, FRECUENCIA_MUESTREO);
title('Señal retocada');