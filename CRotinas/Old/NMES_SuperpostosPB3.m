function NMES_SuperpostosPB3(Sinal,CR,crg,cond,R,v,vol)
global leg cores marcadores pH
tamFonte=10;
nomFonte='Times New Roman';
indErro=4;
largLin=2;
tamMarcador=5;
indTr=R.Trechos(1):R.Trechos(end); %3 linhas-movimentos e 5 colunas-trechos
tempo=(Sinal.Dado(indTr,8)-Sinal.Dado(indTr(1),8))/1000;

%plot da goniometria
if crg.PB==1
    plot(tempo, Sinal.Dado(indTr,R.indCon),'color','k','LineWidth',largLin);hold on
    pH(v)=plot(tempo(1:200:end), Sinal.Dado(indTr(1:200:end),R.indCon),...
        'MarkerEdgeColor','k','Marker',marcadores{v},...
        'MarkerSize',tamMarcador,'LineWidth',1,'LineStyle','none',...
        'DisplayName',['V' num2str(v)]);
else
    pH(v)=plot(tempo, Sinal.Dado(indTr,R.indCon),'color',cores{v},...
        'LineWidth',largLin,'MarkerSize',tamMarcador,'DisplayName',['V' num2str(v)]);hold on
end

%LEGENDA
if crg.Ingles~=1
    leg(length(leg)+1)={['V' num2str(v)]};
else
    leg(length(leg)+1)={['V' num2str(v)]};
end

%----------------------------------------------
%só roda esta parte na ultima iteração
if v==length(vol);
    if crg.bfk==1
        temp=12; %Referencia Visual
        legref={sprintf(' Referência\n Visual')};
        if crg.Ingles==1
            legref={sprintf('Visual Reference')};
        end
    else
        temp=3; %Angulo Alvo do Controle
        legref={sprintf(' Referência do\n Controle')};
        if crg.Ingles==1
            legref={sprintf('Reference Signal')};
        end
    end
    
    pH(v+1)=plot(tempo, Sinal.Dado(indTr,temp),'color',cores{end},'LineStyle','--');hold on%Plot do Sinal de Referência
    set(pH(v+1),'linewidth',2,'MarkerSize',2)
    
    leg(v+1)=legref;
    legend(pH,leg,'Location','NorthOutside','FontSize',tamFonte,'FontName',nomFonte,'Orientation','horizontal')
    legend('boxoff')
end
%----------------------------------------------

%configura gráfico
set(gca,'FontSize',tamFonte,'FontName',nomFonte)
if crg.Ingles~=1
    ylab=ylabel('Ângulo (º)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
    ylabpos=get(ylab,'pos');
    xlabel('Tempo (s)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold')
else
    ylab=ylabel('Angle (º)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
    ylabpos=get(ylab,'pos');
    xlabel('Time (s)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold')
end






