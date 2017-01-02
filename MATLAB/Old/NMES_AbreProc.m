%Rotina principal do Processamento dos Sinais Coletados
%pelo VI FESPID
%chama todas as outras rotinas secundarias:
%PathFileFES
%AbreFES
%ProcessaFES

disp('################')
%################################
%Controle da Rotina
%################################

CR.nCiclos=15;

if strcmpi(CR.modo,'Manual')
    CR.graficos=1;
    CR.grafCiclos=1;
end

%######################################
%Importa e Processa os dados Um a Um
%######################################
clear R RMedT
diretorio=[cd,'\DadosFES2013MAT\'];

if strcmpi(CR.modo,'Auto')
    prot={'rampa','unilatsemfes','unilatcomfes','bilatsemfes','bilatcomfes'};
    %vol={'ACA2811','DCR2909','IBM2509','JAS1610','JFR1610','LCS1510','BRA2611'};
    vol={'ACA2811','JAS1610','JFR1610','LCS1510','BRA2611'}    
    
elseif strcmpi(CR.modo,'Manual')
    [temp, diretorio] = uigetfile('*.mat','Escolha o Arquivo',diretorio);
    vol={temp(1:7)};
    prot={temp(8:end-4)};
end

for v=1:length(vol) % para todos os voluntarios
    for p=1:length(prot) % e para todos os protocolos
        
        disp(['======='])
        disp(['Processando ' [vol{v} prot{p}]])
        
        arquivo=[vol{v} prot{p} '.mat'];
        
        if exist([diretorio arquivo], 'file')
            %ABRE ARQUIVO RECORTADO
            tload=load([diretorio arquivo]);
            tfnames=fieldnames(tload.Sinal);
            for k=1:length(tfnames)
                Sinal.(vol{v}).(prot{p}).(tfnames{k})=tload.Sinal.(tfnames{k});
            end
            
            Sinal.(vol{v}).(prot{p}).File=arquivo;
            
            if isfield(Sinal.(vol{v}),'rampa') %rampa sempre é o primeiro a ser chamado
                Sinal.(vol{v}).(prot{p}).Param(9)=Sinal.(vol{v}).rampa.Param(9); %Uso o lado controlado indicado no protocolo de rampa por ser mais confiável.
            end
            
            %CHAMA ROTINA DE PROCESSAMENTO E SALVA RESULTADOS EM ESTRUTURA
            %################
            [R.(vol{v}).(prot{p}),Sinal.(vol{v}).(prot{p}).Dado]=ProcessaFES10(Sinal.(vol{v}).(prot{p}),CR,prot{p}); %Processa os arquivos extraindo parâmetros
            %################
        else
            disp(['O arquivo ' arquivo ' não foi encontrado'])
        end
    end %encerra FOR dos protocolos
    
end%encerra FOR dos voluntários
disp('concluído!')

