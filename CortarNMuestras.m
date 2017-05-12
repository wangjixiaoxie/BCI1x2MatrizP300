function [elementos] = CortarNMuestras(senales,delimitador_inicio,muestras)
% function [SenalElec] = CortarEleccion(senales,delimitador_inicio,delimitador_fin)
% parámetro: senal              - Señal a dividir: { ... MARKER} al final
% parámetro: delimitador_inicio - Cte con el valor de inicio a buscar
% parámetro: muestras           - Cuántas muestras por delimitador
% retorna  : SenalElec          - Retorna un cellArray donde cada columna
% es el subarray resultante de cada delimitador más "muestras" cantidad.
% Ej: { Elemento1   Elemento2 ... }


%Es necesario encontrar dónde empieza cada elemento, propiamente dicho:
muestraInicio = find( senales{end} ==  delimitador_inicio );
muestraFin = muestraInicio+muestras;
elementos = {zeros(length(muestraInicio))};

if( ~muestraInicio)
    elementos={}; %No hay nada que hacer, no había nada!!
    return;
end

for n = 1:length(muestraInicio)
    elementos{n} = cellfun( @(x) x(muestraInicio(n):muestraFin(n)) , senales , 'UniformOutput', false);
end

end