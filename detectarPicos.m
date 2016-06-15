function [ frecuencias] = detectarPicos(espectro, umbral, fs, nfft )

%DETECTARPICOS detecta frecuencias donde estan los picos de espectro


absespect = abs(espectro);
ANCHO_FILTRO = 450;
filtro = ones(1, ANCHO_FILTRO);


% obtengo los picos principales
picos = absespect > umbral;

% Esto es para darle algo mas de tolerancia para que los picos muy cercanos
% se unan en un solo pico mas ancho
picos = filter(filtro, 1, picos);
picos = picos >= 1;

% donde tome 1 empieza un pico, y donde tenga -1 termina un pico.
indicadores = diff(picos);
startk =0;
frecuencias = [];
for k = 1:length(indicadores)
    if indicadores(k) == 1
        startk = k;
    end
    if indicadores(k) == -1
        % el inicio esta justo donde arranca el pico, tengo que empezar un
        % poco antes, 1 hertz
        startk = startk - 10 * nfft/fs;
        % pero si me fui a negativo, esto falla, voy a 1/100 hertz
        if startk <= 0
            startk = 0.01 *nfft/fs;
        end
        if isempty(frecuencias) == false  && frecuencias(end) > startk * fs/nfft
            frecuencias(end) = k* fs/nfft;
        else    
            frecuencias = [frecuencias; [startk k]* fs/nfft];
    end
end;




end

