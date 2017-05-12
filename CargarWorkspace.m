function [CH_AF3,CH_F7,CH_F3,CH_FC5,CH_T7,CH_P7,CH_01,CH_02,CH_P8,CH_T8,CH_FC6,CH_F4,CH_F8,CH_AF4,CH_CMS,CH_DRL,MARKET ] = CargarWorkspace(route)
% parametro route     - Numero de figura para ventana de ploteo
%
% retorna   canales: AF3 F7 F3 FC5 T7 P7 01 02 P8 T8 FC6 F4 F8 AF4 CMS DRL
% retorna   market

path = route;
formats = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
headerLines = 1;
delimiter = ',';
[M{1:36}] = textread(path, formats,'headerlines', headerLines, 'delimiter', delimiter);

CH_AF3  = M{3};
CH_F7   = M{4};
CH_F3   = M{5};
CH_FC5  = M{6};
CH_T7   = M{7};
CH_P7   = M{8};
CH_01   = M{9};
CH_02   = M{10};
CH_P8   = M{11};
CH_T8   = M{12};
CH_FC6  = M{13};
CH_F4   = M{14};
CH_F8   = M{15};
CH_AF4  = M{16};
CH_CMS  = M{32};
CH_DRL  = M{33};
MARKET  = M{36};

end