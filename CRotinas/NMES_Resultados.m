% depois de rodar o FESMain, basta executar
% protocolo pode ser bilat ou unilat

function R=NMES_Resultados(Sinal,CR,R,vol,protocolo,movCompleto,GeraGraf,SalvaGraf)

nomesTrechos={'Rampa Subida','Platô Flexão','Rampa Descida','Platô Extensão'};
tamFonte=10;
nomFonte='Times New Roman';
sL={'-o','-^','-x','-d','-v','-s','-<','-h','-p','-x','->','-*'};
largLin=1.5;
tamMarcador=8;
plotmedia=0;

if movCompleto==1
    param={'ErroAbsMedio','EM','ErroAngSS','ErroAngSS2',...
        'ErroMaxPos','ErroMaxNeg',...
        'ErroSTD','ErroMax'};
    Nparam={'Erro Absoluto Médio (°)','Erro Médio(°)','Erro Angular ao Final do Platô de Flexão (°)','Erro Angular ao Final do Platô de Extensão (°)',...
        'Erro Máximo Positivo Absoluto (°)','Erro Máximo Negativo Absoluto (°)',...
        'Desvio Padrão do Erro (°)','Erro Máximo (°)'};
    
elseif movCompleto==0
    param={'ErroAbsMedio','EM','ErroMaxPos',...
        'ErroMaxNeg','ErroSTD','ErroMax'};
    Nparam={'Erro Absoluto Médio (°)','Erro Médio(°)','Erro Máximo Positivo Absoluto (°)',...
        'Erro Máximo Negativo Absoluto (°)','Desvio Padrão do Erro (°)','Erro Máximo (°)'};
end

if CR.Ingles==1
    Nparam{1}={'Mean Absolute Error (º)'};
end

for k=1:length(param)
    
    clear meanSemFES meanComFES
    if movCompleto==1
        numtr=1; %SE O MOV É COMPLETO LOGO HA APENAS UM TRECHO
        for v=1:length(vol) % para todos os voluntarios
            if strcmp(param{k},'ErroMaxPos')||strcmp(param{k},'ErroMaxNeg')
                meanSemFES(v)=mean(abs(R.(vol{v}).([protocolo 'semfes']).TT.(param{k})));
                meanComFES(v)=mean(abs(R.(vol{v}).([protocolo 'comfes']).TT.(param{k})));
            else
                meanSemFES(v)=mean(R.(vol{v}).([protocolo 'semfes']).TT.(param{k}));
                meanComFES(v)=mean(R.(vol{v}).([protocolo 'comfes']).TT.(param{k}));
            end
        end
        meanSemFES=meanSemFES';
        meanComFES=meanComFES';
        
    elseif movCompleto==0;
        numtr=4; %PARA VISUALIZAÇAO DOS 4 TRECHOS
        for v=1:length(vol) % para todos os voluntarios
            if strcmp(param{k},'ErroMaxPos')||strcmp(param{k},'ErroMaxNeg')
                meanSemFES(v,:)=mean(abs(R.(vol{v}).([protocolo 'semfes']).(param{k})),1);
                meanComFES(v,:)=mean(abs(R.(vol{v}).([protocolo 'comfes']).(param{k})),1);
            else
                meanSemFES(v,:)=mean(R.(vol{v}).([protocolo 'semfes']).(param{k}),1);
                meanComFES(v,:)=mean(R.(vol{v}).([protocolo 'comfes']).(param{k}),1);
            end
        end
    end
    
    for tr=1:numtr %para todos os trechos
        temp=meanComFES(:,tr)-meanSemFES(:,tr);
        DCSF=(mean(temp));
        
        temp=100*(meanComFES(:,tr)-meanSemFES(:,tr))./meanSemFES(:,tr);
        RCSF=(mean(temp));
        
        if movCompleto==1
            R.RCSF_TT.(param{k}).(protocolo)=RCSF;
            R.DCSF_TT.(param{k}).(protocolo)=DCSF;
        elseif movCompleto==0
            R.RCSF_Trechos.(param{k}).(protocolo)(tr)=RCSF;
            R.DCSF_Trechos.(param{k}).(protocolo)(tr)=DCSF;
        end
        
        %############################
        %GRAFICOS
        
        if GeraGraf==1
            if CR.Ingles~=1
                diretorio=[cd '\GrafResultados\'];
            else
                diretorio=[cd '\GrafResultadosING\'];
            end
            if ~exist(diretorio, 'dir')
                mkdir(diretorio)
            end
            
            if movCompleto==1
                nomefigura=[diretorio protocolo '_' param{k} '_' 'MovCompleto'];
            else
                nomefigura=[diretorio protocolo '_' param{k} '_' num2str(tr) '_' nomesTrechos{tr}];
            end
            
            figure('Color',[1 1 1],'name',nomefigura,'NumberTitle','off','Menubar','none');
            
            if movCompleto==0
                xlabel(nomesTrechos{tr},'FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold')
            end
            
            ylabel([Nparam{k}],'FontSize',tamFonte,'FontName',nomFonte,'FontWeight','bold')
            
            
            %PLOT DOS RESULTADOS
            hold on
            for ii=1:size(meanSemFES(:,tr),1)
                H=plot([1,2],[meanSemFES(ii,tr),meanComFES(ii,tr)],sL{ii});
                set(H,'linewidth',largLin,'MarkerSize',tamMarcador,'color','k')
            end
            
            %PLOT DA MEDIA
            if plotmedia==1
                H=plot([0.85,1.15],mean(meanSemFES(:,tr))*[1,1],[1.85,2.15],mean(meanComFES(:,tr))*[1,1]);
                set(H,'linewidth',largLin+2,'MarkerSize',tamMarcador,'color','k')
            end
            
            
            if CR.Ingles~=1
                set(gca,'XTickLabel',[],'XTick',[],'FontSize',tamFonte,'FontName',nomFonte,...
                    'XColor','k','XTick',[1,2],'XTickLabel',{'Sem NMES','Com NMES'},...
                    'FontWeight','bold','XLim',[0.85 2.15])
            else
                set(gca,'XTickLabel',[],'XTick',[],'FontSize',tamFonte,'FontName',nomFonte,...
                    'XColor','k','XTick',[1,2],'XTickLabel',{'With NMES','Without NMES'},...
                    'FontWeight','bold','XLim',[0.85 2.15])
            end 
            
            
            %LEGENDA COM DIFERENÇA
            if CR.suprimenome==1 %troca os nomes por números
                for v=1:length(vol) % para todos os voluntarios
                    if movCompleto==0;
                        nVol{v}=['\Delta' ' V' num2str(v) ' = ' sprintf('%0.1f', meanComFES(v,tr)-meanSemFES(v,tr)) 'º'];
                    elseif movCompleto==1;
                        nVol{v}=['\Delta' ' V' num2str(v) ' = ' sprintf('%0.1f', meanComFES(v)-meanSemFES(v)) 'º'];
                    end
                end
                
            elseif CR.suprimenome==0
                
                for v=1:length(vol) % para todos os voluntarios
                    if movCompleto==0;
                        nVol{v}=sprintf([vol{v}(1:3) '\nVariação Sem/Com ' sprintf('%0.1f', meanComFES(v,tr)-meanSemFES(v,tr)) 'º']);
                    elseif movCompleto==1;
                        nVol{v}=sprintf([vol{v}(1:3) '\nVariação Sem/Com ' sprintf('%0.1f', meanComFES(v)-meanSemFES(v)) 'º']);
                    end
                end
            end
            
            if plotmedia==1
                nVol{length(nVol)+1}=['\Delta ' 'Media = ' sprintf('%0.1f', mean(meanComFES(:,tr))-mean(meanSemFES(:,tr))) 'º'];
            end
            
            legend(nVol,'Location','NorthEastOutside','FontSize',tamFonte,'FontName',nomFonte); clear  nVol
            legend('boxoff')
        end
        SalvaFigura(nomefigura,CR.X,CR.Y)
    end
end