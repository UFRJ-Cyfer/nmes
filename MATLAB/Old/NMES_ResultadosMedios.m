function RMed=NMES_ResultadosMedios(R,vol,prot)
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
disp('NMES_ResultadosMedios... OK')