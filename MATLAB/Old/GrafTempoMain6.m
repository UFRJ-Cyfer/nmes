function GrafTempoMain6(Sinal,R,CR,crg,vol,prot)
global leg cores marcadores

tamFonte=10;
nomFonte='Times New Roman';
indErro=4;
cores=coresdif(length(vol)+1);
marcadores=[{'o'} {'x'} {'+'} {'s'} {'v'} {'^'} {'<'} {'>'}];


for p=1:length(prot) %para todos os protocolos
    leg={};
    if crg.Superpostos==1 % controle de 1 grafico para todos os sinais
        figure('Color',[1 1 1],'Name',prot{p});hold on %abre figura que receberá todos os graficos no tempo
    end
    
    for v=[1 2 3 4 5]%1:length(vol) % para todos os voluntarios
        crg.ref=0;
        crg.bfk=0;
        crg.goniocontr=0;
        crg.gonioref=0;
        crg.corrente=0;
        crg.correntesat=1;
        
        if strcmpi(prot{p},{'rampa'}) %testa nome do protocolo
            crg.ref=1;
            crg.corrente=1;
            
        elseif strcmpi(prot{p},{'unilatsemfes'}) %testa nome do protocolo
            crg.bfk=1;
            
        elseif strcmpi(prot{p},{'unilatcomfes'}) %testa nome do protocolo
            crg.ref=1;
            crg.corrente=1;
            
        elseif strcmpi(prot{p},{'bilatsemfes'}) %testa nome do protocolo
            crg.ref=1;
            crg.bfk=1;
            
        elseif strcmpi(prot{p},{'bilatcomfes'}) %testa nome do protocolo
            crg.ref=1;
            crg.bfk=1;
            crg.corrente=1;
        end
        
        %#####(Sinal,R,CR,crg,cond)
        if crg.Separados==1
            NMES_SeparadoPB4(Sinal.(vol{v}).(prot{p}),R.(vol{v}).(prot{p}),CR,crg,prot{p});
            %---
            axis tight
            if crg.SalvaGraf==1
                if crg.Ingles~=1
                    diretorio=[cd '\GrafSeparados\' ];
                else
                    diretorio=[cd '\GrafSeparadosING\' ];
                end
                if ~exist(diretorio, 'dir')
                    mkdir(diretorio)
                end
                nomefigura=[diretorio prot{p} '_Superpostos'];
                SalvaFigura(nomefigura,CR.X,CR.Y)
            end
            %---
        end
        %#####
        if crg.Superpostos==1
            NMES_SuperpostosPB3(Sinal.(vol{v}).(prot{p}),CR,crg,prot{p},R.(vol{v}).(prot{p}),v,vol)
            %---
            axis tight
            if crg.SalvaGraf==1
                if crg.Ingles~=1
                    diretorio=[cd '\GrafSuperpostos\' ];
                else
                    diretorio=[cd '\GrafSuperpostosING\' ];
                end
                if ~exist(diretorio, 'dir')
                    mkdir(diretorio)
                end
                nomefigura=[diretorio prot{p} '_Superpostos'];
                SalvaFigura(nomefigura,CR.X,CR.Y)
            end
            %---
        end
    end
end


