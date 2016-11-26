function [handles] = plotintoGUI_ES( handles )
%PLOTALLES Summary of this function goes here
%   Detailed explanation goes here

if exist([handles.diretorio handles.file], 'file') == 0
    % File does not exist.  Do stuff....
    set(handles.status,'String','ERROR');
    drawnow;
%     uiwait(msgbox('Please Indicate the correct folder'));
%     pathname = uigetdir();
%     handles.diretorio = [pathname '\'];
end

if exist([handles.diretorio handles.file(1:end-4-7) 'Param.txt'], 'file') == 0
    data = get(handles.paramTable,'data');
    M = cell2mat(data(1:3,:));
    handles.M = M;
    found = 0;
else
%     [timeData, controlData] = ...
%         openFileMain(handles.diretorio,[handles.file(1:end-4-7) 'Param.txt']);
    
    handles.controlData.PID = unique(handles.controlData.Values(:,5:end),'rows','stable');
    
    % Retrieves ES parameter data
    data = reshape(handles.controlData.ParamValues(1:9),[3 3]);
    data = cat(2,(handles.controlData.PID(1,:))',data);


    % Fills all data
    set(handles.esH,'String',num2str(handles.controlData.ParamValues(10)));
    set(handles.esTo,'String',num2str(handles.controlData.ParamValues(11)));
    set(handles.paramTable,'data',data);

    found = 1;
    handles.M = data;
    drawnow;
end

if found == 0
    handles = reconstructCost(handles);
else
    handles = extractESData(handles);
end

X = 0:1:length(handles.J);

axes(handles.kttConstants);
plot(handles.kttConstants,X,handles.theta)
grid on;
legend(handles.legendS);

axes(handles.kkkConstants);
plot(handles.kkkConstants,X,handles.thetaP)
grid on;
legend(handles.legendP);

axes(handles.costEvolution);
plot(handles.costEvolution, X(1:end-1),handles.J)
grid on;
legend('J(k)');


axes(handles.bestTimeResponse);
plot(handles.bestTimeResponse,handles.timeBestResponse,...
    handles.bestResponse(:,1),'b'); hold on

plot(handles.bestTimeResponse,handles.timeBestResponse,...
handles.bestResponse(:,2),'r-.');hold off

legend('Arm Angle','Reference')

axis([0 inf 0 70]);
grid on;

end

