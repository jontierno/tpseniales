
clear all, close all;
detecciones = [0 0 1 0 0 0 1 0 0 1 1 0 0 0 1 0 1 0 0 ];
filtro = [1 1 1];
secciones = conv(filtro, detecciones);
filtros = secciones >= 1;

subplot(3,1,1); stem(detecciones);
title('Picos detectados');
subplot(3,1,2); stem(secciones);
title('Ensanchamiento');
subplot(3,1,3); stem(filtros);
title('Bandas detectadas');