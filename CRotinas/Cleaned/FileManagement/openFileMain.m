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

timeData.pulseParam = temp.data;
timeData.pulseParamNames = temp.colheaders;

temp = importdata([pathname,filename], '\t', 3);

timeData.timeResponse = temp.data;
timeData.timeVariables = temp.colheaders;
timeData.path = pathname;
timeData.file = filename;
%   Arm Angle   AngAlvo     dtAmost     dtSum   AmpCH1  AmpCH2




end

