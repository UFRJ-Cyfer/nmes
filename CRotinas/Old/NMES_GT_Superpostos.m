function NMES_GT_Superpostos(Sinal,CR,crg,cond,R,v,vol)
global leg cores linhas
tamFonte=10;
nomFonte='Times New Roman';
indErro=4;

if v==1 %só roda esta parte na primeira iteração
    indTr=R.Trechos(1):R.Trechos(end); %3 linhas-movimentos e 5 colunas-trechos
    tempo=(Sinal.Dado(indTr,8)-Sinal.Dado(indTr(1),8))/1000;
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
    
    H=plot(tempo, Sinal.Dado(indTr,temp),'color',cores{end},'LineStyle','--');hold on%Plot do Sinal de Referência
    set(H,'linewidth',2,'MarkerSize',2)
    
    leg(length(leg)+1)=legref;
end

indTr=R.Trechos(1):R.Trechos(end); %3 linhas-movimentos e 5 colunas-trechos
largLin=1;
tamMarcador=1;
tempo=(Sinal.Dado(indTr,8)-Sinal.Dado(indTr(1),8))/1000;

%plot da goniometria
if crg.PB==1
    H=plot(tempo, Sinal.Dado(indTr,R.indCon),linhas{v}); hold on
else
    H=plot(tempo, Sinal.Dado(indTr,R.indCon),'color',cores{v}); hold on
end
set(H,'linewidth',largLin,'MarkerSize',tamMarcador)
%hl1=gca;

if crg.Ingles~=1
    %leg(length(leg)+1)={['V' num2str(v)  sprintf(['\n' 'EAM ']) sprintf('%0.1f',[R.EAM_SinalCompl]) '°' ]};
    leg(length(leg)+1)={['V' num2str(v)  ' EAM=' sprintf('%0.1f',[R.EAM_SinalCompl]) '°' ]};
else
    leg(length(leg)+1)={['V' num2str(v)  ' MAE=' sprintf('%0.1f',[R.EAM_SinalCompl]) '°' ]};
end
%###############

set(gca,'FontSize',tamFonte,'FontName',nomFonte)
legend(leg,'Location','NorthEastOutside','FontSize',tamFonte,'FontName',nomFonte)
legend('boxoff')

if crg.Ingles~=1
    ylab=ylabel('Ângulo (º)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
    ylabpos=get(ylab,'pos');
    xlabel('Tempo (s)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold')
else
    ylab=ylabel('Angle (º)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold');
    ylabpos=get(ylab,'pos');
    xlabel('Time (s)','FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold')
end

% if crg.SalvaGraf==1
%     temp=[cd '\GrafSuperpostos\' ];
%     if ~exist(temp, 'dir')
%         mkdir(temp)
%     end
%     if crg.Ingles~=1
%         nome=[temp prot{p} '_Superpostos'];
%     else
%         nome=[temp prot{p} '_Superpostos_Ing'];
%     end
%     SalvaFigura(nome,16,5)
% end




