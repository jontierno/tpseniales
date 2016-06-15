% FILTRADO AUTOMATICO DE LA SEÑAL

%% FILTRADO
% PARA BUSCAR LOS FILTROS

% me quedo solo con la mitad del espectro
espectro =  ESPECTRO_SENIAL_SIN_CONTINUA(1:round(length(ESPECTRO_SENIAL_SIN_CONTINUA)/2));

% paso el umbral para obtener los picos, la frecuencia de muestreo, y con
% cuantos puntos se hace la fft
frecuencias = detectarPicos(espectro, UMBRAL_FILTRO_AUTOMATICO, ...
    FRECUENCIA_MUESTREO, LONGITUD_SENIAL);


 filtrada_automatica = SENIAL_SIN_CONTINUA;
 
 desplazamiento = ORDEN_FILTRO/2;
 for k = 1:2:length(frecuencias)
     frecs = [frecuencias(k) frecuencias(k+1)] /FREC_NYQUIST ;
     
     b = fir1(ORDEN_FILTRO,frecs,'stop');
     % filtro notch
     filtrada_automatica= filter(b,1,filtrada_automatica);
     
     % como el fir1 es un filtro de retardo de grupo constante, puedo
     % acomodar el delay de la senial filtrada (retardo= orden /2)
      filtrada_automatica = filtrada_automatica(desplazamiento:end);

      
 end;




