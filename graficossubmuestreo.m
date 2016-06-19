%GRAFICOS DEL SUBMUESTREO

subplot(2,1,1), imprimirTransformada(senial_16,FRECUENCIA_MUESTREO_16,1); 
title('Espectro Señal 16k');
axis([-inf inf 10e-21 inf])
subplot(2,1,2), imprimirTransformada(SENIAL_SIN_CONTINUA,FRECUENCIA_MUESTREO,1); 
title('Espectro Señal Submuestreada');
axis([-inf inf 10e-21 inf])