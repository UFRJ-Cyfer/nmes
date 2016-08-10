function [ timeData, controlData ] = openFileMain( pathname, filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
replaceinfile(',', '.', [pathname,filename]);

replaceinfile(',', '.', [pathname [filename(1:end-4-7) 'Param.txt']]);

file = fopen([pathname,[filename(1:end-4-7) 'Param.txt']]);
controlType = fgetl(file);
fclose(file);


if strcmp(controlType,'PID')    
    [controlData] = openFilePID(pathname, [filename(1:end-4-7) 'Param.txt']);
end

if strcmp(controlType,'PIDRelay')
    [controlData] = openFileRelay(pathname, [filename(1:end-4-7) 'Param.txt']);
end

if strcmp(controlType,'PIDES')
    [controlData] = openFileES(pathname, [filename(1:end-4-7) 'Param.txt']);
end

temp = importdata([pathname,filename], '\t', 1);

%OffsetCH1 OffsetCH2 MaxCH1 MaxCH2 LadoCotnrolado Referencia Freqeuncia
%Duracao
timeData.pulseParam = temp.data;
timeData.pulseParamNames = temp.colheaders;

temp = importdata([pathname,filename], '\t', 3);

%   Arm Angle   AngAlvo     dtAmost     dtSum   AmpCH1  AmpCH2
timeData.timeResponse = temp.data;
timeData.timeVariables = temp.colheaders;
timeData.path = pathname;
timeData.file = filename;




% Corrections due to weird bug with the saved file
% aux = timeData.timeResponse(:,3);
% timeData.timeResponse(:,3) = timeData.timeResponse(:,4);
% timeData.timeResponse(:,4) = aux;
% 
% 
% aux = timeData.timeResponse(:,5);
% timeData.timeResponse(:,5) = timeData.timeResponse(:,6);
% timeData.timeResponse(:,6) = aux;



end

