%#############################
function [Param]=NMESAbreParam(filename,pathname)

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

replaceinfile(',', '.', [pathname,filename]); %substitui virgula por pontos
temp = importdata([pathname,filename], '\t', 1);

Param.ESParamValues = temp.data;
Param.ESParam =temp.colheaders;

temp = importdata([pathname,filename], '\t', 3);

Param.PIDValue = temp.data;
Param.PID = temp.colheaders;

Param.PIDValue = unique(Param.PIDValue,'rows','stable');

Param.Path=pathname;
Param.File=filename;
end
