%Gráfico de la señal en funcion del tiempo, recibe la señal y la frecuencia 
% de muestreo.
%Retorna la linea de tiempo utilizada

function answer = printsignal(signal, samplingFrec)
  duration = (length(signal) / samplingFrec);
  timeline = 0:1/samplingFrec:duration - 1/samplingFrec  ;
  figure
  plot(timeline,abs(signal))
  T= title ('Intensidad vs Tiempo');
  set (T, 'fontsize', 12); 
  xlabel ('tiempo [seg]');
  ylabel ('Intensidad (módulo)');
  L = legend(strcat(['Intensidad Duracion ',num2str(duration),' seg']));
  set (L, 'fontsize', 10); 
  answer = timeline;
end