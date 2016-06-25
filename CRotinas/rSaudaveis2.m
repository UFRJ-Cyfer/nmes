limpa
tamFonte=10;
nomFonte='Times New Roman';
EAM_Ram=[2.4547    2.5013    3.3157    2.8169    2.6756    3.2184    4.2686    2.4629];
EAM_Deg=[5.4295    7.8452    3.8513    3.6005    6.0015    4.4220    8.2858    6.3494];


% ii=1:size(meanSemFES(:,tr),1)
% H=plot([1,2],[meanSemFES(ii,tr),meanComFES(ii,tr)],sL{ii});
% set(H,'linewidth',largLin,'MarkerSize',tamMarcador,'color','k')
% %PLOT DA MEDIANA
% H=plot([0.85,1.15],median(meanSemFES(:,tr))*[1,1],[1.85,2.15],median(meanComFES(:,tr))*[1,1]);
% set(H,'linewidth',largLin+2,'MarkerSize',tamMarcador,'color','k')
% set(gca,'XTickLabel',[],'XTick',[],'FontSize',tamFonte-2,'FontName',nomFonte,...
%     'XColor','k','XTick',[1,2],'XTickLabel',{'Sem NMES','Com NMES'},'FontWeight','bold')

figure('Color',[1 1 1],'NumberTitle','off','Menubar','none'); 
pH(1)=plot(ones(1,length(EAM_Ram)),EAM_Ram,'k.','MarkerSize',10);hold on
plot(ones(1,length(EAM_Deg))*1.5,EAM_Deg,'k.','MarkerSize',10);hold on
leg(1)={'EAM'};

axis([0 3 0 8.5])

%PLOT DA MÉDIA
pH(2)=plot([0.85,1.15],mean(EAM_Ram)*[1,1],'k');
plot([1.35,1.65],mean(EAM_Deg)*[1,1],'k');
leg(2)={'Média'};

set(gca,'XTickLabel',[],'XTick',[],'FontSize',tamFonte,'FontName',nomFonte,...
     'XColor','k','XTick',[1,1.5],'XTickLabel',{'Rampa','Degrau'},'FontWeight','bold')
 ylabel('Erro Absoluto Médio (°)','FontSize',tamFonte,'FontName',nomFonte,...
     'FontWeight','bold') 
 
%LEGENDA
legend(pH,leg,'Location', 'NorthEast','FontSize',tamFonte,'FontName',nomFonte)
legend('boxoff')

%SALVANDO
diretorio=[cd '\R Saudáveis\' ];
if ~exist(diretorio, 'dir')
    mkdir(diretorio)
end
nomefigura=[diretorio 'EAM_RamDeg'];

set(gca,'XLim',[0.75 2],'LooseInset',get(gca,'TightInset')+0.01)

SalvaFigura(nomefigura,12,6)


