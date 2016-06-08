% SCRIPT PRINCIPAL


%% FILTRADO MANUL
clear all, close all;
init4k;
filtradomanual;

%% FILTRADO AUTOMATICO.
clear all, close all;
init4k;
filtradoautomatico;

%% A PARTIR DE LA SEÑAL DE 16K HAGO EL FILTRADO AUTOMATICO.
clear all, close all;
init4k;
init16k;
filtradoautomatico;
