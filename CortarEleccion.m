function [elementos] = CortarEleccion(senales,delimitador_inicio,delimitador_fin)
% function [SenalElec] = CortarEleccion(senales,delimitador_inicio,delimitador_fin)
% parámetro: senal              - Señal a dividir: { ... MARKER} al final
% parámetro: delimitador_inicio - Cte con el valor de inicio a buscar
% parámetro: delimitador_fin    - Cte con el valor de final a buscar
% retorna  : SenalElec           - Retorna un cellArray donde cada columna
% es el subarray resultante entre los delimitadores.
% Ej: { Elemento1   Elemento 2 ... }

%Es necesario encontrar dónde empieza cada elemento, propiamente dicho:
muestraInicio = find( senales{end} ==  delimitador_inicio );
muestraFin = find( senales{end} ==  delimitador_fin );
elementos = {zeros(length(muestraInicio))};

if( ~muestraInicio)
    elementos={}; %No hay nada que hacer, no había nada!!
    return;
end

% Hubo una sola, y el final no está
if( length(muestraInicio) ~= length(muestraFin))
    muestraFin= length(senales{end}); 
end

for n = 1:length(muestraInicio)
    elementos{n} = cellfun( @(x) x(muestraInicio(n):muestraFin(n)) , senales , 'UniformOutput', false);
end

end
