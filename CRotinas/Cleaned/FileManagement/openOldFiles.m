function [ timeData ] = openOldFiles ( pathname, filename )
%OPENOLDFILES Summary of this function goes here
%   Detailed explanation goes here

    replaceinfile(',', '.', [pathname,filename]);
    temp = importdata([pathname,filename], '\t', 1);

    timeData.oldParams = temp.data;
    
    % Offset Corrente CH1 e CH2, MaxCH1 e CH2
    for k=1:4
        timeData.pulseParam(k) = temp.data(k+3);
    end
    
    % LadoControlado, Referencia, Frequencia e Duracao
    for k=1:2
        timeData.pulseParam(k+4) = temp.data(k+8);
        timeData.pulseParam(k+4+2) = temp.data(k+11);
    end  
    timeData.oldParamNames = temp.colheaders;
    
    
    temp = importdata([pathname,filename], '\t', 3);
     
    % Finding the right arm
    if mean(temp.data(:,1)) > mean(temp.data(:,2))
        timeData.timeResponse(:,1) = temp.data(:,1);
        i = 1;
    else
        timeData.timeResponse(:,1) = temp.data(:,2);
        i = 2;
    end
    
    % Reference
    timeData.timeResponse(:,2) = temp.data(:,3);
    
    % dtSum and dtAmost
    timeData.timeResponse(:,3) = temp.data(:,8);
    timeData.timeResponse(:,4) = temp.data(:,5);
    
    % Biceps and Triceps (CH1 and CH2)
    timeData.timeResponse(:,5) = temp.data(:,6);
    timeData.timeResponse(:,6) = temp.data(:,7);
    
    
    timeData.timeVariables = temp.colheaders;
    
    timeData.path = pathname;
    timeData.file = filename;

end

