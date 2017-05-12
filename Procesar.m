function [ output_args ] = Procesar( siProm , noProm,varargin )
%function [ output_args ] = Procesar( siProm , noProm,varargin )
%   Recibe los arrays de promedios, y devuelve un cellArray:
%   {siProcesado noProcesado}
%   Es en esta función que se aplica todo el procesamiento. 
%   Se usa varargin para que se puedan pasar los parámetros que se
%   necesiten, sin modificar el prototipo!!
%   En este caso, el canal que se devolverá del wavelet, y 
%   'noplot' en caso que se desee que no haya ploteo DENTRO
%   de la función.


%% Aplicación de la Transformada Wavelet

if( nargin >= 1 )
    returnIndex=varargin{1};
    if( nargin == 4 )
        plotSignals=~strcmp(varargin{2},'noplot');
    else
        plotSignals=1;
    end
else
    returnIndex=1; %por default devuelve la misma
    plotSignals=1;
end

tipo='coif4';
nivel=6;
di=[];
di2=[];

siProm = siProm/max(siProm);

[cSi, lSi] = wavedec(siProm, nivel,'coif4');

for i=1:nivel
cd=wrcoef('d',cSi,lSi,tipo,i);
di=[di;cd'];
end
k=0;
for i=nivel:-1:1
    k=k+1;
    d(k,:)=di(i,:);
end    
a=wrcoef('a',cSi,lSi,tipo,nivel);
figura=[siProm';a';d];


if( plotSignals )
    for i=1:nivel+2
        subplot(nivel+2,2,(i*2)-1)
        plot(figura(i,:))
        axis([0,length(figura(1,:)),-1,1]);
        zoom
    end
end

% Para el NO
noProm= noProm/max(noProm);

[cNo, lNo] = wavedec(noProm, nivel,'coif4');

for i=1:nivel
    cd2=wrcoef('d',cNo,lNo,tipo,i);
    di2=[di2;cd2'];
end
k=0;
for i=nivel:-1:1
    k=k+1;
    d2(k,:)=di2(i,:);
end    
a2=wrcoef('a',cNo,lNo,tipo,nivel);
figura2=[noProm';a2';d2];

if( plotSignals )
    for i=1:nivel+2
        subplot(nivel+2,2,i*2)
        plot(figura2(i,:))
        axis([0,length(figura2(1,:)),-1,1]);
        zoom
    end
end
    output_args={figura(returnIndex,:) figura2(returnIndex,:)};
    return    
end
