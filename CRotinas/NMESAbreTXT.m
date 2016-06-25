%#############################
function [Sinal]=NMESAbreTXT(filename,pathname)

% Abrindo Dados
% try
%     temp = importdata([pathname,filename], '\t', 1);
%     Sinal.Dado=temp.data;
%     Sinal.Nome=temp.colheaders;
% catch
%     [s, msg] = replaceinfile(',', '.', [pathname,filename], '-nobak'); %substitui virgula por pontos
%     temp = importdata([pathname,filename], '\t', 1);
%     Sinal.Dado=temp.data;
%     Sinal.Nome=temp.colheaders;
% end

% [s, msg] = replaceinfile(',', '.', [pathname,filename], '-nobak'); %substitui virgula por pontos

[s, msg] = replaceinfile(',', '.', [pathname,filename]); %substitui virgula por pontos
temp = importdata([pathname,filename], '\t', 1);
Sinal.Dado=temp.data;
Sinal.Nome=temp.colheaders;

% Verificando formato de arquivo
nomes1={'GonioD' 'GonioE' 'AngAlvo' 'ErroAng' 'dtAmost'...
    'AmpCH1' 'AmpCH2' 'dtSum' 'SaidaD' 'SaidaI' 'SaidaP'};
nomes2={'GonioD' 'GonioE' 'AngAlvo' 'ErroAng' 'dtAmost'...
    'AmpCH1' 'AmpCH2' 'dtSum' 'SaidaD' 'SaidaI' 'SaidaP' 'AngFBK'};

while 1
    %TESTANDO PARA FORMATO NOMES1
    temp = importdata([pathname,filename], '\t', 1);
    Sinal.Dado=temp.data;
    Sinal.Nome=temp.colheaders;
    if length(Sinal.Nome)==length(nomes1)
        if sum(strcmp(nomes1,Sinal.Nome))==11
            break
        end
    end

    %TESTANDO PARA FORMATO NOMES2
    temp = importdata([pathname,filename], '\t', 3);
    Sinal.Dado=temp.data;
    Sinal.Nome=temp.colheaders;
    if length(Sinal.Nome)==length(nomes2)
        if sum(strcmp(nomes2,Sinal.Nome))==12
            %agora que verifiquei o formato, 
            %pego o resto das informações de cabeçalho
            temp = importdata([pathname,filename], '\t', 1);
            Sinal.Param=temp.data;
            Sinal.NParam=temp.colheaders;
            
            %Corrigindo Sinal do AmpCH1 e AmpCH2
            Sinal.Dado(:,[6,7])=Sinal.Dado(:,[6,7])/2.5151;
            Sinal.Dado=Sinal.Dado(:,[1:5,7,6,8:end]); %inverti o CH1 com CH2...
            break
        end
    end
    %se nenhum dos formatos anteriores for verdadeiro...
    disp('ERRO NO FORMATO DO ARQUIVO'); break
end
Sinal.Path=pathname;
Sinal.File=filename;
end
