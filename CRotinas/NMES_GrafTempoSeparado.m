function NMES_GrafTempoSeparado(Sinal,crg,cond,R)
tamFonte=10;
nomFonte='Times New Roman';
largLin=1.5;
tamMarcador=8;
leg={};
indErro=4;
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
    leg(length(leg)+1)={sprintf(' Referência\n Visual')};
end

if crg.ref==1
    H=plot(tempo, Sinal.Dado(indTr,3),'k--'); hold on %3 coluna é AngAlvo
    set(H,'linewidth',largLin,'MarkerSize',tamMarcador)
    if crg.gonioref==1
        leg(length(leg)+1)={sprintf(' Membro\n Oposto')};
    else
        leg(length(leg)+1)={sprintf(' Referência do\n Controle')};
    end
end

H=plot(tempo, Sinal.Dado(indTr,R.indCon),'k'); hold on
set(H,'linewidth',largLin+1,'MarkerSize',tamMarcador)
leg(length(leg)+1)={sprintf(' Membro\n Controlado')};
hl1=gca;

temp=max([50,ceil(max(max(Sinal.Dado(indTr,[1,3,12]) )))+5]);
%ajuste da escala vertical para no mínimo 50º e no máximo a amplitude da
%referencia ou movimento +5º
axis([0,tempo(end), 0,temp])
set(gca,'FontSize',tamFonte,'FontName',nomFonte)%,'FontWeight','bold')
legend(leg,'Location','NorthEastOutside','FontSize',tamFonte,'FontName',nomFonte)
legend('boxoff')
ylab=ylabel('Ângulo (º)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
ylabpos=get(ylab,'pos');


%%
%########################################
%########################################
%########################################
%Plot da Corrente
if crg.corrente==1
    hl2=subplot(4,1,3); %CH1 e CH2
    Sinal.Dado(Sinal.Dado(:,6)~=0,6)=Sinal.Dado(Sinal.Dado(:,6)~=0,6)+Sinal.Param(4);
    Sinal.Dado(Sinal.Dado(:,7)~=0,7)=Sinal.Dado(Sinal.Dado(:,7)~=0,7)+Sinal.Param(5);
    H=plot(tempo,Sinal.Dado(indTr,6),'k',tempo,Sinal.Dado(indTr,7),'k:');hold on
    set(H,'linewidth',largLin,'MarkerSize',tamMarcador)
    set(gca,'FontSize',tamFonte,'FontName',nomFonte)
    axis([0,tempo(end), 0,ceil(max(max(Sinal.Dado(indTr,6:7))))+2])
    ylab=ylabel('Corrente (mA)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
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
    ylab=ylabel('Corrente (mA)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
    temp=get(ylab,'Pos');
    set(ylab,'Pos',[ylabpos(1) temp(2) temp(3)]);

    legend({'Proporcional','Integrativo'},'Location','NorthEastOutside','FontSize',tamFonte,'FontName',nomFonte)
    legend('boxoff')
    
    pl1=get(hl1,'Position');
    pl2=get(hl2,'Position');
    pl3=get(hl3,'Position');
    set(hl2,'Position',[pl1(1) pl2(2) pl1(3) pl2(4)])
    set(hl3,'Position',[pl1(1) pl3(2) pl1(3) pl3(4)])    
end
xlabel('Tempo (s)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold')

%%
%#########################################
%PREPARANDO FIGURA DA CORRENTE PARA SALVAR
hFig=gcf;
% centimeters units
X=14;
if crg.corrente~=1
    Y=7;
else
    Y=14;
end

%# figure size displayed on screen
set(hFig, 'Units','centimeters', 'Position',[0 0 X Y])
movegui(hFig, 'center')

%# figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[0 0 X Y])
set(hFig, 'PaperOrientation','portrait')

if crg.SalvaGraf==1
    temp=[cd '\GrafTempo\' cond '\'];
    if ~exist(temp, 'dir')
        mkdir(temp)
    end    
    print('-dtiff','-r300',[temp Sinal.File(1:end-4) ])
end