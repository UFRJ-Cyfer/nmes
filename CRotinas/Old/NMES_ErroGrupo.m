function R=NMES_ErroGrupo(Sinal,R,vol,prot)

for v=1:length(vol)
    temp_ucf(v)=R.(vol{v}).unilatcomfes.EAM_SinalCompl; %extraio a medida da estrutura
    temp_usf(v)=R.(vol{v}).unilatsemfes.EAM_SinalCompl;
    temp_bcf(v)=R.(vol{v}).bilatcomfes.EAM_SinalCompl;
    temp_bsf(v)=R.(vol{v}).bilatsemfes.EAM_SinalCompl;
    %if strcmpi(vol{v},{'LCS1510'})% este voluntário foi excluído
    %else
    temp_ram(v)=R.(vol{v}).rampa.EAM_SinalCompl;
    temp_ramEMA(v)=R.(vol{v}).rampa.EMA_SinalCompl;
    %end
end

%somatório dos EAM de todos os voluntários
R.sumEAM.unilatcomfes=sum(temp_ucf); 
R.sumEAM.unilatsemfes=sum(temp_usf);
R.sumEAM.bilatcomfes=sum(temp_bcf);
R.sumEAM.bilatsemfes=sum(temp_bsf);
R.sumEAM.rampa=sum(temp_ram);

R.meanEAM.unilatcomfes=mean(temp_ucf); 
R.meanEAM.unilatsemfes=mean(temp_usf);
R.meanEAM.bilatcomfes=mean(temp_bcf);
R.meanEAM.bilatsemfes=mean(temp_bsf);
R.meanEAM.rampa=mean(temp_ram);

%
R.meanEMA.rampa=mean(temp_ramEMA);
%

%Variação Percentual
%(depois-antes)/antes

R.razEAM.unilat=(mean(temp_ucf)-mean(temp_usf))/mean(temp_usf);
R.razEAM.bilat=(mean(temp_bcf)-mean(temp_bsf))/mean(temp_bsf);

R.razEAM.rmp_unicf=(mean(temp_ram)-mean(temp_ucf))/mean(temp_ram);
R.razEAM.rmp_unisf=(mean(temp_ram)-mean(temp_usf))/mean(temp_ram);

% R.razEAM2.unilat=mean((temp_ucf-temp_usf)./temp_usf);
% R.razEAM2.bilat=mean((temp_bcf-temp_bsf)./temp_bsf);
% 
% R.razEAM2.rmp_unicf=mean((temp_ram-temp_ucf)./temp_ram);
% R.razEAM2.rmp_unisf=mean((temp_ram-temp_usf)./temp_ram);


