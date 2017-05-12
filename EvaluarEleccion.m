function [ output_args ] = EvaluarEleccion(EleccionSi ,EleccionNo,elec,varargin )
%function [ output_args ] = EvaluarEleccion(EleccionSi ,EleccionNo,eleccion,varargin )
%   Recibe EleccionSi y EleccionNo, y los compara bajo los criterios 
%   a futuro. Por ahora, solo energia. Y en la ventana definida en varargin
%   Requiere SI o SI el num de eleccion, para imprimir correctamente.
%   Puede recibir en varargin el nombre de archivo.

%% Procesamiento de los argumentos
if( nargin >= 5 )
    inicioP300=varargin{1};
    finP300=varargin{2};
    if( nargin == 6 )
        path=varargin{3};
    else
        path='Nombre no provisto, completar en "path" al invocar la funcion';
    end
else
    inicioP300=0; %por default evalua de inicio a fin
    finP300=length(EleccionSi);
    path='Nombre no provisto, completar en "path" al invocar la funcion';
end
%% Toma de decisiones

    siEnergiaPost=CalculoEnergia(EleccionSi(inicioP300:finP300));
    noEnergiaPost=CalculoEnergia(EleccionNo(inicioP300:finP300));
    fprintf('\n Archivo: %s ',path);
    if( siEnergiaPost > noEnergiaPost)
        textoEleccion=fprintf('\n\tEleccion#%d, fue elegido SI, con %f vs %f \r',elec,siEnergiaPost,noEnergiaPost);
        resultado=1;
    else
        textoEleccion=fprintf('\n\tEleccion#%d, fue elegido NO, con %f vs %f \r',elec,noEnergiaPost,siEnergiaPost);
        resultado=0;
    end
    
    output_args={textoEleccion resultado siEnergiaPost noEnergiaPost};
    return 

end

