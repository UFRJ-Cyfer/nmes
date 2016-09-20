function SalvaFigura(nome,X,Y)
%Preparando Figura pra Salvar
hFig=gcf;

%# figure size displayed on screen
set(hFig, 'Units','centimeters', 'Position',[0 0 X Y])
movegui(hFig, 'center')

%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[0 0 X Y])
set(hFig, 'PaperOrientation','portrait')

print('-dtiff','-r300',[nome])
