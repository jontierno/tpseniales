%Gráfico de la señal en funcion del tiempo, recibe la señal y la frecuencia 
% de muestreo.

function imprimirSenial(signal, samplingFrec)
  duration = (length(signal) / samplingFrec);
  timeline = 0:1/samplingFrec:duration - 1/samplingFrec  ;
  plot(timeline,signal)
  T= title ('Intensidad vs Tiempo');
  set (T, 'fontsize', 12); 
  xlabel ('Tiempo [seg]');
  ylabel ('Intensidad (módulo)');
  L = legend(strcat(['Duracion ',num2str(duration),' seg']));
  set (L, 'fontsize', 10); 
 
end