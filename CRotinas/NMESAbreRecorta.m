clc;

%modo='auto';
modo='manual';
diretorio=[cd];
diretoriodestino=[cd '\'];

refaz=1; if strcmpi(modo,'Manual') refaz=1; end

if strcmpi(modo,'Auto')
    [lista]=geralistas2; %gera listas de nomes de pacientes e protocolos
    vol=lista.voluntarios;
    prot=lista.protocolos;
    clear Sinal
elseif strcmpi(modo,'Manual')
    [temp, diretorio] = uigetfile('*.txt','Escolha o Arquivo',diretorio);
    vol={temp(1:7)};
    prot={temp(8:end-4)};
end

for v=1:length(vol) % para todos os voluntarios
    for p=1:length(prot) % e para todos os protocolos
        arquivo=[vol{v} prot{p} '.txt'];
        
        if exist([diretorio arquivo], 'file') %verifica existência do arquivo original txt
            
            if refaz==0 && exist([diretoriodestino [arquivo(1:end-4) '.mat']], 'file') %se quiser refazer todas as marcações refaz ~=0
                disp(['Arquivo ' arquivo ' já recortado, e opção refaz=0']);
            else
                %Abre para Recortar
% 				inp = input('Which Pacient? \n', 's')
                [Sinal]=NMESAbreTXT(arquivo, diretorio); %Abre os arquivos e determina o formato
                
				
                %Faz Graficos
                figure('Color',[1 1 1],'name',[Sinal.File],'NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
                ax(1)=subplot(4,1,1);
                plot(Sinal.Dado(:,1),'r'); hold on
                plot(Sinal.Dado(:,2),'g');
                grid on; axis ([0 inf -5 55])
                legend('GONID','GONIE')
                ax(2)=subplot(4,1,2);
                plot(abs(Sinal.Dado(:,4)),'r');
                legend('Erro')
                ax(3)=subplot(4,1,3);
                plot(Sinal.Dado(:,3),'b'); grid on; axis ([0 inf -5 55])
                legend('AngAlvo')
                ax(4)=subplot(4,1,4);
                plot(Sinal.Dado(:,12),'k');grid on; axis ([0 inf -5 55])
                legend('AngFBK')
                linkaxes(ax,'x')
                
%                 Pega Pontos e Recorta
                [X,Y] = ginput(2);
                if X(1)<0;
                    X(1)=1;
                end
                if X(2)>length(Sinal.Dado)
                    X(2)=length(Sinal.Dado);
				end

                Sinal.Dado=Sinal.Dado( ceil(X(1)): ceil(X(2)),:);


%  				ggg = waitforbuttonpress ;
% % 
% 				X1 = find(Sinal.Dado(:,3) > 0 , 1);
% 				X1_0 = find(Sinal.Dado(X1:end,3) == 0 , 1);
% 				X1_0 = X1_0 + X1;
% 				X2 = find(Sinal.Dado(X1_0:end,3) > 0 , 1);
% % 				
% 				X2 = X1_0 + X2;
% 				X2_0 = find(Sinal.Dado(X2:end,3) == 0 , 1);
% 				X2_0 = X2_0 + X2;
% 				X3 = find(Sinal.Dado(X2_0:end,3) > 0 , 1);
% % 								
% 				X3 = X2_0 + X3;
% 				X3_0 = find(Sinal.Dado(X3:end,3) == 0 , 1);
% 				X3_0 = X3_0 + X3;
% 				X4 = find(Sinal.Dado(X3_0:end,3) > 0 , 1);
% % 								
%  				X4 = X3_0 + X4;
%  				X4_0 = find(Sinal.Dado(X4:end,3) == 0 , 1);
%  				X4_0 = X4_0 + X4;
%  				X5 = find(Sinal.Dado(X4_0:end,3) > 0 , 1);
% 				X5 = X4_0 + X5;
% % 				
% 				Sinal.Dado=Sinal.Dado(X1:X4,:);


				
				
                %Mostra Sinal Recortado
                figure('Color',[1 1 1],'name',[Sinal.File],'NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
                ax(1)=subplot(4,1,1);
                plot(Sinal.Dado(:,1),'r'); hold on
                plot(Sinal.Dado(:,2),'g');
                grid on; axis ([0 inf -5 55])
                legend('GONID','GONIE')
                ax(2)=subplot(4,1,2);
                plot(abs(Sinal.Dado(:,4)),'r');
                legend('Erro')
                ax(3)=subplot(4,1,3);
                plot(Sinal.Dado(:,3),'b'); grid on; axis ([0 inf -5 55])
                legend('AngAlvo')
                ax(4)=subplot(4,1,4);
                plot(Sinal.Dado(:,12),'k');grid on; axis ([0 inf -5 55])
                legend('AngFBK')
                linkaxes(ax,'x')
                pause(1);close all
                
                nome=arquivo(1:end-4);
                save([diretoriodestino nome '.mat'],'Sinal')
% 				eval([inp,'=Sinal;']);
            end
        end
    end
end
