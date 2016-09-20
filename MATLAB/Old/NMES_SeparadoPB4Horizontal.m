function NMES_SeparadoPB4(Sinal,R,CR,crg,cond)   
tamFonte=10;
nomFonte='Times New Roman';
largLin=1.5;
tamMarcador=10;
leg={};
pH=[];
%indErro=4;
indTr=R.Trechos(1):R.Trechos(end);
tempo=(Sinal.Dado(indTr,8)-Sinal.Dado(indTr(1),8))/1000;

figure('Color',[1 1 1],'name',[Sinal.File],...  %abre figura
    'NumberTitle','off','Menubar','none');

if crg.corrente==1 % se tiver que fazer o plot da corrente, muda os subplots
    subplot(4,1,1:2);
end

if crg.bfk==1 %plot do feedback visual
     %legenda do feedback visual
    if crg.Ingles~=1
        temp={sprintf(' Referência\nVisual')};
    else
        temp={sprintf(' Visual\nReference')};
    end
    
    pH(length(pH)+1)=plot(tempo, Sinal.Dado(indTr,12),'k-.',...
        'linewidth',largLin,'MarkerSize',tamMarcador,'DisplayName',temp); hold on %3 coluna é AngFBK   
end

if crg.ref==1 %plot da referencia    
        %legenda do sinal de referência
    if crg.gonioref==1
        if crg.Ingles~=1
            temp={sprintf(' Membro\n Oposto')};
        else
            temp={sprintf(' Contra-lateral\n Limb')};
        end
    else
        if crg.Ingles~=1
            temp={sprintf(' Sinal de\n Controle')};
        else
            temp={sprintf('Reference Signal')};
        end
    end
    
    pH(length(pH)+1)=plot(tempo, Sinal.Dado(indTr,3),'k--',...
        'linewidth',largLin,'linewidth',largLin,...
        'MarkerSize',tamMarcador-5,'DisplayName',temp); hold on %3 coluna é AngAlvo
end

%##### Plot da Goniometria
Goni=Sinal.Dado(indTr,R.indCon); %Trecho da Goniometria
cor6=Sinal.Dado(indTr,6); %valor de saturação da corrente
cor7=Sinal.Dado(indTr,7); %valor de saturação da corrente
if crg.Ingles~=1
   temp={sprintf('Membro\n Controlado')};
else
    temp={sprintf('Controlled\n Limb')};
end

pH(length(pH)+1)=plot(tempo, Goni,'k',...
    'linewidth',largLin,'DisplayName',temp); hold on %Plot do Ângulo do Braço Controlado

if crg.correntesat==1 %marcação de corrente saturada
    indsat6=find(cor6==Sinal.Param(6)); %índices dos locais saturados
    indsat7=find(cor7==Sinal.Param(7));
   
    if crg.Ingles~=1
        if~isempty(indsat6)
            LB={sprintf('Zona Saturada\nBiceps')};
        end
        if~isempty(indsat7)
            LT={sprintf('Zona Saturada\nTriceps')};
        end
    else
        if~isempty(indsat6)
           LB={sprintf('Saturated current\nat Biceps')};
        end
        if~isempty(indsat7)
            LT={sprintf('Saturated current\nat Triceps')};
        end
    end
    
    
    if crg.PB==1  %caso os gráficos sejam em PB
        Cor=[0.7 0.7 0.7];
    else
        Cor=[1 0 0];
    end;
    
    if~isempty(indsat6)
        ii=[0; find(diff(indsat6)>1); length(indsat6)];
        TpH=length(pH)+1;
        for p=1:length(ii)-1
            temp=[ii(p)+1:ii(p+1)];
            plot(tempo(indsat6(temp)),Goni(indsat6(temp)),'Color',[1 1 1],'linewidth',largLin+1,'LineStyle','-')
            pH(TpH)=plot(tempo(indsat6(temp)),Goni(indsat6(temp)),...
                'Color',Cor,'linewidth',largLin+1,'LineStyle','-','DisplayName',LB);
        end
    end
    
    if crg.PB==1
        Cor=[0.7 0.7 0.7];
    else
        Cor=[0 0 1];
    end;
    
    if~isempty(indsat7)
        ii=[0; find(diff(indsat7)>1); length(indsat7)];
        TpH=length(pH)+1;
        for p=1:length(ii)-1
            temp=[ii(p)+1:ii(p+1)];
            plot(tempo(indsat7(temp)),Goni(indsat7(temp)),'Color',[1 1 1],'linewidth',largLin+1,'LineStyle','-')
            pH(TpH)=plot(tempo(indsat7(temp)),Goni(indsat7(temp)),...
                'Color',Cor,'linewidth',largLin+1,'LineStyle','-','DisplayName',LT);
        end
    end
end
%----------------------------------


hl1=gca;

temp=max([50,ceil(max(max(Sinal.Dado(indTr,[1,3,12]) )))+5]);
%ajuste da escala vertical para no mínimo 50º e no máximo a amplitude da
%referencia ou movimento +5º

axis([0,tempo(end), 0,temp])
set(gca,'FontSize',tamFonte,'FontName',nomFonte)%,'FontWeight','bold')
legend(pH,leg,'Location','NorthOutside','FontSize',tamFonte,'FontName',nomFonte,'Orientation','horizontal')
legend('boxoff')

if crg.Ingles~=1
    ylab=ylabel('Ângulo (º)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
else
    ylab=ylabel('Angle (º)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
end
ylabpos=get(ylab,'pos');


%########################################
%########################################
%########################################
%Plot da Corrente
H=[];
leg={};
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
    
    legend({'Bíceps','Tríceps'},'Location','NorthOutside','FontSize',tamFonte,'FontName',nomFonte,'Orientation','horizontal')
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
        legend({'Proporcional','Integrativo'},'Location','NorthOutside','FontSize',tamFonte,'FontName',nomFonte,'Orientation','horizontal')
    else
        legend({'Proportional','Integrative'},'Location','NorthOutside','FontSize',tamFonte,'FontName',nomFonte,'Orientation','horizontal')
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