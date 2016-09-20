function RMed=NMES_ResultadosMedios2(R,vol,prot)
param={'ErroAbsMedio','EM','ErroMaxPos',...
    'ErroMaxNeg','ErroSTD','ErroMax'};
clear tempV RMT
tempV=[];
for pr=1:length(prot) % para todos os protocolos
    for pa=1:size(param,2) % para todos os parametros
        for v=1:length(vol) % para todos os voluntarios
            %tempV= [tempV; R.(vol{v}).(prot{pr}).(param{pa})]; %concatena valores obtidos em todos os voluntarios em determinado par e prot
            tempV= mean(R.(vol{v}).(prot{pr}).(param{pa}),1);
        end
        RMed.Trechos.(prot{pr}).(param{pa})=mean(tempV,1); %resultado medio por trecho
        RMed.Completos.(prot{pr}).(param{pa})=mean(mean(tempV,1)); % %resultado medio por protocolo e parametro
    end
end

%------------------------------------------------
%------------------------------------------------
for v=1:length(vol)
    temp_ucf(v)=R.(vol{v}).unilatcomfes.EAM_SinalCompl; %extraio a medida da estrutura
    temp_usf(v)=R.(vol{v}).unilatsemfes.EAM_SinalCompl;
    temp_bcf(v)=R.(vol{v}).bilatcomfes.EAM_SinalCompl;
    temp_bsf(v)=R.(vol{v}).bilatsemfes.EAM_SinalCompl;
    temp_ram(v)=R.(vol{v}).rampa.EAM_SinalCompl;
    temp_ramEMA(v)=R.(vol{v}).rampa.EMA_SinalCompl;    
end

%somatório dos EAM de todos os voluntários
RMed.CompletosOrig.sumEAM.unilatcomfes=sum(temp_ucf); 
RMed.CompletosOrig.sumEAM.unilatsemfes=sum(temp_usf);
RMed.CompletosOrig.sumEAM.bilatcomfes=sum(temp_bcf);
RMed.CompletosOrig.sumEAM.bilatsemfes=sum(temp_bsf);
RMed.CompletosOrig.sumEAM.rampa=sum(temp_ram);

RMed.CompletosOrig.meanEAM.unilatcomfes=mean(temp_ucf); 
RMed.CompletosOrig.meanEAM.unilatsemfes=mean(temp_usf);
RMed.CompletosOrig.meanEAM.bilatcomfes=mean(temp_bcf);
RMed.CompletosOrig.meanEAM.bilatsemfes=mean(temp_bsf);
RMed.CompletosOrig.meanEAM.rampa=mean(temp_ram);

%
RMed.CompletosOrig.meanEMA.rampa=mean(temp_ramEMA);
%

%Variação Percentual
%(depois-antes)/antes
RMed.CompletosOrig.razEAM.unilat=(mean(temp_ucf)-mean(temp_usf))/mean(temp_usf);
RMed.CompletosOrig.razEAM.bilat=(mean(temp_bcf)-mean(temp_bsf))/mean(temp_bsf);

RMed.CompletosOrig.razEAM.rmp_unicf=(mean(temp_ram)-mean(temp_ucf))/mean(temp_ram);
RMed.CompletosOrig.razEAM.rmp_unisf=(mean(temp_ram)-mean(temp_usf))/mean(temp_ram);
disp('NMES_ResultadosMedios... OK')