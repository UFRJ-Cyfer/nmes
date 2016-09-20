function RProt=NMES_ErroGrupo2(Sinal,R,vol,prot)

for v=1:length(vol)
    temp_ucf(v)=R.(vol{v}).unilatcomfes.EAM_SinalCompl; %extraio a medida da estrutura
    temp_usf(v)=R.(vol{v}).unilatsemfes.EAM_SinalCompl;
    temp_bcf(v)=R.(vol{v}).bilatcomfes.EAM_SinalCompl;
    temp_bsf(v)=R.(vol{v}).bilatsemfes.EAM_SinalCompl;
    temp_ram(v)=R.(vol{v}).rampa.EAM_SinalCompl;
    temp_ramEMA(v)=R.(vol{v}).rampa.EMA_SinalCompl;    
end

%somatório dos EAM de todos os voluntários
RProt.sumEAM.unilatcomfes=sum(temp_ucf); 
RProt.sumEAM.unilatsemfes=sum(temp_usf);
RProt.sumEAM.bilatcomfes=sum(temp_bcf);
RProt.sumEAM.bilatsemfes=sum(temp_bsf);
RProt.sumEAM.rampa=sum(temp_ram);

RProt.meanEAM.unilatcomfes=mean(temp_ucf); 
RProt.meanEAM.unilatsemfes=mean(temp_usf);
RProt.meanEAM.bilatcomfes=mean(temp_bcf);
RProt.meanEAM.bilatsemfes=mean(temp_bsf);
RProt.meanEAM.rampa=mean(temp_ram);

%
RProt.meanEMA.rampa=mean(temp_ramEMA);
%

%Variação Percentual
%(depois-antes)/antes
RProt.razEAM.unilat=(mean(temp_ucf)-mean(temp_usf))/mean(temp_usf);
RProt.razEAM.bilat=(mean(temp_bcf)-mean(temp_bsf))/mean(temp_bsf);

RProt.razEAM.rmp_unicf=(mean(temp_ram)-mean(temp_ucf))/mean(temp_ram);
RProt.razEAM.rmp_unisf=(mean(temp_ram)-mean(temp_usf))/mean(temp_ram);

disp('NMES_ErroGrupo... OK')
