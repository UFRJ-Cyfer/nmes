function NMES_GrafTempoSeparado2(Sinal,R,CR,crg,cond)
tamFonte=10;
nomFonte='Times New Roman';
largLin=1.5;
tamMarcador=8;
leg={};
%indErro=4;
indTr=R.Trechos(1):R.Trechos(end);
tempo=(Sinal.Dado(indTr,8)-Sinal.Dado(indTr(1),8))/1000;


%%
figure('Color',[1 1 1],'name',[Sinal.File],...
    'NumberTitle','off','Menubar','none');

if crg.corrente==1
    subplot(4,1,1:2);
end

if crg.bfk==1
    H=plot(tempo(1:5:end), Sinal.Dado(indTr(1:5:end),12),'k.'); hold on %3 coluna é AngFBK
    set(H,'linewidth',largLin,'MarkerSize',tamMarcador-1)
    if crg.Ingles~=1
        leg(length(leg)+1)={sprintf(' Referência\n Visual')};
    else
        leg(length(leg)+1)={sprintf(' Visual\n Reference')};
    end
end

if crg.ref==1
    H=plot(tempo, Sinal.Dado(indTr,3),'k--'); hold on %3 coluna é AngAlvo
    set(H,'linewidth',largLin,'MarkerSize',tamMarcador)
    if crg.gonioref==1
        if crg.Ingles~=1
            leg(length(leg)+1)={sprintf(' Membro\n Oposto')};
        else
            leg(length(leg)+1)={sprintf(' Contra-lateral\n Limb')};
        end
    else
        if crg.Ingles~=1
            leg(length(leg)+1)={sprintf(' Sinal de\n Controle')};
        else
            leg(length(leg)+1)={sprintf('Reference Signal')};
        end
    end
end

%#####
Goni=Sinal.Dado(indTr,R.indCon);
H=plot(tempo, Goni,'k'); hold on %Plot do Ângulo do Braço Controlado

cor6=Sinal.Dado(indTr,6);
cor7=Sinal.Dado(indTr,7);
if crg.correntesat==1 %marcação de corrente saturada
    indsat6=find(cor6==Sinal.Param(6));
    indsat7=find(cor7==Sinal.Param(7));
    plot(tempo(indsat6),Goni(indsat6),'r.',tempo(indsat7),Goni(indsat7),'b.')
end

set(H,'linewidth',largLin+1,'MarkerSize',tamMarcador)

if crg.Ingles~=1
    leg(length(leg)+1)={sprintf(' Membro\n Controlado')};
else
    leg(length(leg)+1)={sprintf(' Controlled\n Limb')};
end

hl1=gca;

temp=max([50,ceil(max(max(Sinal.Dado(indTr,[1,3,12]) )))+5]);
%ajuste da escala vertical para no mínimo 50º e no máximo a amplitude da
%referencia ou movimento +5º
axis([0,tempo(end), 0,temp])
set(gca,'FontSize',tamFonte,'FontName',nomFonte)%,'FontWeight','bold')
legend(leg,'Location','NorthEastOutside','FontSize',tamFonte,'FontName',nomFonte)
legend('boxoff')
if crg.Ingles~=1
    ylab=ylabel('Ângulo (º)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
else
    ylab=ylabel('Angle (º)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
end
ylabpos=get(ylab,'pos');


%%
%########################################
%########################################
%########################################
%Plot da Corrente
if crg.corrente==1
    hl2=subplot(4,1,3); %CH1 e CH2
    
    H=plot(tempo,cor6,'k',tempo,cor7,'k:');hold on
    
    set(H,'linewidth',largLin,'MarkerSize',tamMarcador)
    set(gca,'FontSize',tamFonte,'FontName',nomFonte)
    axis([0,tempo(end), 0,ceil(max(max(Sinal.Dado(indTr,6:7))))+2])
    if crg.Ingles~=1
        ylab=ylabel('Corrente (mA)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
    else
        ylab=ylabel('Current (mA)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
    end
    
    temp=get(ylab,'Pos');
    set(ylab,'Pos',[ylabpos(1) temp(2) temp(3)]);
    
    legend({'Bíceps','Tríceps'},'Location','NorthEastOutside','FontSize',tamFonte,'FontName',nomFonte)
    legend('boxoff')
    
    hl3=subplot(4,1,4); %P e I
    H=plot(tempo,Sinal.Dado(indTr,11),'k',tempo,Sinal.Dado(indTr,10),'k:');hold on
    set(H,'linewidth',largLin,'MarkerSize',tamMarcador)
    set(gca,'FontSize',tamFonte,'FontName',nomFonte)
    tempmax=ceil(max(max(Sinal.Dado(indTr,10:11))))+2;
    tempmin=floor(min(min(Sinal.Dado(indTr,10:11))))-2;
    axis([0,tempo(end), tempmin,tempmax])
    
    if crg.Ingles~=1
        ylab=ylabel('Corrente (mA)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
    else
        ylab=ylabel('Current (mA)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
    end
    
    temp=get(ylab,'Pos');
    set(ylab,'Pos',[ylabpos(1) temp(2) temp(3)]);
    
    if crg.Ingles~=1
        legend({'Proporcional','Integrativo'},'Location','NorthEastOutside','FontSize',tamFonte,'FontName',nomFonte)
    else
        legend({'Proportional','Integrative'},'Location','NorthEastOutside','FontSize',tamFonte,'FontName',nomFonte)
    end
    legend('boxoff')
    
    pl1=get(hl1,'Position');
    pl2=get(hl2,'Position');
    pl3=get(hl3,'Position');
    set(hl2,'Position',[pl1(1) pl2(2) pl1(3) pl2(4)])
    set(hl3,'Position',[pl1(1) pl3(2) pl1(3) pl3(4)])
end

if crg.Ingles~=1
    xlabel('Tempo (s)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold')
else
    xlabel('Time (s)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold')
end


if crg.SalvaGraf==1
    if crg.Ingles~=1
        diretorio=[cd '\GrafTempo\' cond '\'];
    else
        diretorio=[cd '\GrafTempoING\' cond '\'];
    end
    if ~exist(diretorio, 'dir')
        mkdir(diretorio)
    end
    nomefigura=[diretorio Sinal.File(1:end-4)];
    
    if crg.corrente==1
        SalvaFigura(nomefigura,CR.X,2*CR.Y)
    else
        SalvaFigura(nomefigura,CR.X,CR.Y)
    end
end


%%
%#########################################
%PREPARANDO FIGURA DA CORRENTE PARA SALVAR
% hFig=gcf;
% % centimeters units
% X=16;
% if crg.corrente~=1
%     Y=5;
% else
%     Y=10;
% end
%
% %# figure size displayed on screen
% set(hFig, 'Units','centimeters', 'Position',[0 0 X Y])
% movegui(hFig, 'center')
%
% %# figure size printed on paper
% set(hFig, 'PaperUnits','centimeters')
% set(hFig, 'PaperSize',[X Y])
% set(hFig, 'PaperPosition',[0 0 X Y])
% set(hFig, 'PaperOrientation','portrait')
%
% if crg.SalvaGraf==1
%     temp=[cd '\GrafTempo\' cond '\'];
%     if ~exist(temp, 'dir')
%         mkdir(temp)
%     end
%     print('-dtiff','-r300',[temp Sinal.File(1:end-4) ])
%end








