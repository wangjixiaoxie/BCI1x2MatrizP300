function [] = plotTiempo(siProm,noProm,elec,xTemp,titulo,ejeX,ejeY,gridEstado,varargin)

    figure('NumberTitle','off','name',['Experimento N°: ' num2str(elec)]); 

    plot(xTemp,siProm,'LineWidth',4); hold on;
    title(titulo,'FontSize',20); ylabel(ejeY);
    plot(xTemp,noProm,'--','LineWidth',4);
    xlabel(ejeX); ylabel(ejeY);
    legend('con ERP','sin ERP');
    if gridEstado == 1
        grid;
    end  
    hold off;
end
