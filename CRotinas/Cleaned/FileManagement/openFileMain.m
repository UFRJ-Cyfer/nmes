function [ timeData, controlData ] = openFileMain( pathname, filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Param=0;Result = 0;
 
if strcmp(pathname,[pathname(1:end-7) 'Antigo\']) &&...
        exist([pathname filename], 'file')
    
    timeData = openOldFiles(pathname,filename);
    controlData = [];
else
    if exist([pathname filename], 'file') == 0
        % File does not exist.  Do stuff....
        set(handles.status,'String','ERROR');
        drawnow;
        errordlg('Could not find Data file.');
        %         uiwait(msgbox('Please Indicate the correct folder'));
        %         pathname = uigetdir();
        %         pathname = [pathname '\'];
    else
        Result=1;
    end
    
    if exist([pathname filename(1:end-4-7) 'Param.txt'],...
            'file') == 0
%         set(handles.status,'String','ERROR');
%         drawnow;
        errordlg('Could not find Parameters file.');
        %         uiwait(msgbox('Please Indicate the correct folder'));
        %         pathname = uigetdir();
        %         pathname = [pathname '\'];
    else
        Param =1;
    end
end


if Param
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
end

if Result
    replaceinfile(',', '.', [pathname,filename]);
    
    temp = importdata([pathname,filename], '\t', 1);
    
    %OffsetCH1 OffsetCH2 MaxCH1 MaxCH2 LadoCotnrolado Referencia Freqeuncia
    %Duracao
    timeData.pulseParam = temp.data;
    if sum(strcmp(fieldnames(temp), 'colheaders')) == 1
    timeData.pulseParamNames = temp.colheaders;
    end
    
    temp = importdata([pathname,filename], '\t', 3);
    
    %   Arm Angle   AngAlvo     dtAmost     dtSum   AmpCH1  AmpCH2
    timeData.timeResponse = temp.data;
    if sum(strcmp(fieldnames(temp), 'colheaders')) == 1
    timeData.timeVariables = temp.colheaders;
    end
    timeData.path = pathname;
    timeData.file = filename;
    
end

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

