close all
tamFonte=10;
nomFonte='Times New Roman';
EAM_Ram=[2.4547    2.5013    3.3157    2.8169    2.6756    3.2184    4.2686    2.4629];
EAM_Deg=[5.4295    7.8452    3.8513    3.6005    6.0015    4.4220    8.2858    6.3494];

figure('Color',[1 1 1],'NumberTitle','off','Menubar','none'); hold on
pH(1)=plot(ones(1,length(EAMtodos)),EAMtodos,'k.','MarkerSize',10);
leg(1)={'EAM'};

axis([0.65 1.35 0 8.5])

%PLOT DA MÉDIA
pH(2)=plot([0.85,1.15],mean(EAMtodos)*[1,1],'k');
leg(2)={'Média'};

set(gca,'XTickLabel',[],'XTick',[],'FontSize',tamFonte,'FontName',nomFonte)

%LEGENDA
legend(pH,leg,'Location', 'NorthEast','FontSize',tamFonte,'FontName',nomFonte)
legend('boxoff')

%SALVANDO
diretorio=[cd '\R Saudáveis\' ];
if ~exist(diretorio, 'dir')
    mkdir(diretorio)
end
nomefigura=[diretorio 'EAM_' nmov];
SalvaFigura(nomefigura,15,6)

