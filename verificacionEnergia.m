function  [ output_args ] = verificacionEnergia(siProm,noProm,momento)

% siProm   - Promediado de si    
% noProm   - Promediado de no
% momento  - flag para indicar si fue pre o post procesamiento
%
% Funcionamiento:
%       La funci�n imprime la energ�a de las se�ales como argumentos.
%       Si momento = 1, se imprime luego de procesar (leyenda).
%       Si momento = 0, se imprime antes de procesar (leyenda).

    EnergiaSiProm = CalculoEnergia(siProm);
    EnergiaNoProm = CalculoEnergia(noProm);
    
    if momento == 1
        fprintf('\n La energia luego de procesar:');
        fprintf('\n\t siProm: %f J',EnergiaSiProm);
        fprintf('\n\t noProm: %f J',EnergiaNoProm);
    end
    if momento == 0
        fprintf('\n La energia antes de procesar:');
        fprintf('\n\t siProm: %f J',EnergiaSiProm);
        fprintf('\n\t noProm: %f J',EnergiaNoProm);
    end
    output_args={EnergiaSiProm EnergiaNoProm};
    return 
end
