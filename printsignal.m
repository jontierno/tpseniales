#Gráfico de la señal en funcion del tiempo, recibe la señal y la frecuencia 
# de muestreo.
#Retorna la linea de tiempo utilizada

function answer = printsignal(signal, samplingFrec)
  duration = (size(signal) / samplingFrec)(2)
  timeline = 0:1/samplingFrec:duration - 1/samplingFrec  ;
  figure
  plot(timeline,signal)
  T= title ("Intensidad vs Tiempo");
  set (T, "fontsize", 12); 
  xlabel ("tiempo [seg]");
  ylabel ("Intensidad");
  L = legend(strcat(["Intensidad \nDuracion ",num2str(duration)," seg"]));
  set (L, "fontsize", 10); 
  answer = timeline;
endfunction