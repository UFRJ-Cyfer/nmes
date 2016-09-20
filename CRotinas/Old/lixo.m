limpa
[filename,pathname] = uigetfile('*.txt','Escolha o Arquivo');
[Sinal]=NMESAbreTXT(filename,pathname);


%1403-1481 2600-2678
temp=setdiff(1:length(Sinal.Dado),1403:2600);
Sinal.DadoN=Sinal.Dado(temp,:);
Sinal.DadoN(1403:end,8)=Sinal.DadoN(1403:end,8)- (Sinal.DadoN(1403,8)-Sinal.DadoN(1402,8));

figure; plot(Sinal.DadoN(:,[1,2,3]));

dlmwrite('LCS1510rampaNNN.txt',Sinal.DadoN, 'delimiter','\t','precision','%.6f')