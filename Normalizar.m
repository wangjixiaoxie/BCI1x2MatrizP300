function [ output_args ] = Normalizar( varProm ,varargin )
%function [ output_args ] = Normalizar( varProm ,varargin )
%   Recibe los arrays de promedios, y devuelve un array
%   Lo que hace es Xi = (Xi - media) / std para siProm y noProm
%   Se usó varargin para que se puedan pasar los parámetros que se
%   necesiten, sin modificar el prototipo!!

    varNorm = zeros(length(varProm),1);
    mean_value = mean(varProm);
    std_value = std(varProm);
    for i=1:length(varProm)
        varNorm(i)= (varProm(i)-mean_value)/std_value;
    end
    
    output_args=varNorm;
    return