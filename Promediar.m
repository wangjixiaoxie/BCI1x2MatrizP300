function [elementos] = Promediar(senales, canal,cantidad)

    Temp = cellfun( @(x) x(canal) , senales, 'uni',0);
    if ~exist('cantidad','var')
        cantidad = length(Temp);
    end
    if( cantidad > length(Temp))
        cantidad = length(Temp);
    end

    Temp2 = Temp(1:cantidad);
    Dim = ndims(Temp2{1});
    M = cat(Dim+1,Temp2{:});
    elementos= mean( [M{:}] , Dim);

end