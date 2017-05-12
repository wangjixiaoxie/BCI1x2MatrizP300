%% Informacion del experimento y datos de interfaz con usuario

%Cada Estudio se compone de la siguiente manera 
%
% -----------------------------------------------------------
% |         ESTUDIO                                         |
% -----------------------------------------------------------
% | EleccionSI      | EleccionNO        | EleccionLibre     |
% -----------------------------------------------------------
%
% Dentro de cada Elección, existen Secuencias:
% -----------------------------------------------------------
% |         ESTUDIO                                         |   Estudio
% -----------------------------------------------------------
% | EleccionSI      | EleccionNO        | EleccionLibre     |   Elecciones
% -----------------------------------------------------------
% |si|no|si|no|si|no| si|no|si|no|si|no |si|no|si|no|si|no  |   Secuencias
% -----------------------------------------------------------

% Caracteres utilizados
% 
% @ comienza experimento
% $ finaliza el experimento
% % comienza estimulo 1
% & finaliza estimulo 1
% # comienza estimulo 2
% ! finaliza estimulo 2

clc; clear; close all;

INICIO_ELECCION = uint8('@');
FIN_ELECCION    = uint8('$');
MARCA_SI        = uint8('%');
MARCA_NO        = uint8('#');
CANT_MUESTRAS   = 64;
fs              = 128;

%% Carga de datos del estudio EEG

path = './estudios/fer1.CSV';

nEleccion = 1;

[CH_AF3,CH_F7,CH_F3,CH_FC5,CH_T7,CH_P7,CH_01,CH_02,CH_P8,CH_T8,CH_FC6,CH_F4,CH_F8,CH_AF4,CH_CMS,CH_DRL,MARKER]  = CargarWorkspace(path);

% Armo un cellarray con los buffers que van a ser analizados luego. 
% La idea es que, puede que se use solo el Oz, o varios, pero que la
% funcion solo corte por MARKER

temp = {CH_01,MARKER};

%% Segmentado de EEG

%Obtengo elecciones
eleccion = CortarEleccion(temp,INICIO_ELECCION,FIN_ELECCION);

disp('Cantidad de Elecciones');
disp(length(eleccion));

siCortados = {zeros(length(eleccion))};
noCortados = {zeros(length(eleccion))};
siPromedio = {zeros(CANT_MUESTRAS)};
noPromedio = {zeros(CANT_MUESTRAS)};
siNormalizado = {zeros(CANT_MUESTRAS)};
noNormalizado = {zeros(CANT_MUESTRAS)};
siEnergiaPost={};
noEnergiaPost={};

for elec = 1 : length(eleccion)
    
    %Como no están divididos, corto todos los SI y los NO
    siCortados{elec} = CortarNMuestras(eleccion{elec},MARCA_SI,CANT_MUESTRAS);
    noCortados{elec} = CortarNMuestras(eleccion{elec},MARCA_NO,CANT_MUESTRAS);

    %Ahora tengo que promediarlas!!
    % http://stackoverflow.com/questions/5197597/how-to-average-over-a-cell-array-of-arrays

    siPromedio{elec}= Promediar(siCortados{elec},1);
    noPromedio{elec}= Promediar(noCortados{elec},1);
    
    siNormalizado{elec}=Normalizar(siPromedio{elec},1);
    noNormalizado{elec}=Normalizar(noPromedio{elec},1);

 
 %% Procesamiento (wavelet) y informacion de energia
    
    fprintf('\n\n Eleccion numero: %d',nEleccion); nEleccion = nEleccion + 1;
    verificacionEnergia(siNormalizado{elec},noNormalizado{elec},0);
    resultado = Procesar(siNormalizado{elec},noNormalizado{elec},5,'noplot');
    energiaTemp=verificacionEnergia(resultado{1},resultado{2},1);

%% Ploteo de resultados obtenidos en tiempo

    ejeX        = 'Tiempo[seg]';
    ejeY        = 'Amplitud[V]';
    gridEstado  = 0;
    nMuestras = length(siNormalizado{elec}); xTemp = 0:1/fs:(nMuestras-1)*1/fs;
    titulo     = 'Resultados superpuestos';
    plotTiempo(resultado{1},resultado{2},elec,xTemp,titulo,ejeX,ejeY,gridEstado);
    
%% Evaluacion de eleccion por energias (250mS a 350mSeg estandar)

    inicioP300=round(fs*0.250);
    finP300=round(fs*0.350);
    EvaluarEleccion(resultado{1},resultado{2},elec, inicioP300,finP300,path);
end

