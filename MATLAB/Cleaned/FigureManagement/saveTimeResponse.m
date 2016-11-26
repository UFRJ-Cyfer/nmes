function saveTimeResponse(handles)

FONTSIZE = 16;
xAxisLabel = 'Tempo (s)';
controlLabel = 'Corrente (mA)';
angleLabel = 'Ângulo (\circ)';


controlLegend = {'Bíceps' ; 'Tríceps'};
angleLegend = {'Voluntário';'Referência'};

user = handles.timeData.timeResponse(:,1);
ref = handles.timeData.timeResponse(:,2);

idx = find(abs(ref)>150);
ref(idx)= ref(idx-1);

i = find(handles.timeData.timeResponse(1,:) > 10000);

tempo = (handles.timeData.timeResponse(:,i) - ...
    handles.timeData.timeResponse(1,i))/1000;

initial = handles.initial;
final = handles.final;

control(:,1) = handles.timeData.timeResponse(:,5);
control(:,2) = handles.timeData.timeResponse(:,6);



diretorio = handles.diretorio;
file = handles.file;

timeResponse = figure(3);

% str = inputdlg('Plot Control ?','Yes');
% if strcmp(str,'Yes') || strcmp(str,'y') || strcmp(str,'yes') 
%     controlPlot = 1;
% else
%     controlPlot = 0;
% end

controlPlot = 1
if controlPlot
    subplot(3,1,[1 2]);
end
assignin('base','tempoSave',tempo(initial:final));
assignin('base','refSave',ref(initial:final));
assignin('base','userSave',user(initial:final));


plot(tempo(initial:final)-tempo(initial), ...
    user(initial:final),'b','LineWidth', 2);hold on
plot(tempo(initial:final)-tempo(initial),...
    ref(initial:final),'r--','LineWidth', 2);hold off;

if max(ref(initial:final)) > 70
    axis([0,inf,-inf, max(ref)+10]);
else
    axis([0, inf, -inf,70])
end

ylabel(angleLabel)
h = legend(angleLegend,'Location',...
    'northoutside','Orientation','horizontal');
legend('boxoff');
set(h,'FontSize',FONTSIZE);

set(gca, 'FontSize', FONTSIZE)
% xlabel('Time (s)')

str = inputdlg('Input Image Title','ImageTitle');

if isempty(str) == 0
    title(str)
end

if controlPlot
    
    subplot(3,1,3);
    
    biceps = control(:,1);
    triceps = control(:,2);
    minB = min(biceps(biceps>0));
    minT = min(triceps(triceps>0));
    
    if isempty(minB)
        minB = 0;
    end
    
    if isempty(minT)
        minT = 0;
    end
    
    min1 = min(minB,minT);
    plot(tempo(initial:final)-tempo(initial),control(initial:final,1),'r',...
        tempo(initial:final)-tempo(initial),control(initial:final,2),'g','LineWidth', 1.5);
    hold on
%     plot(tempo(initial:final)-tempo(initial), ones(size(control(initial:final,1)))*handles.timeData.oldParams(4),'r--')
%     plot(tempo(initial:final)-tempo(initial), ones(size(control(initial:final,2)))*handles.timeData.oldParams(5),'g-.')
    
    %         tempo,ones(length(tempo),1)*control(1,3),'r',...
    %         tempo,ones(length(tempo),1)*control(1,4),'g');
    h1 =  legend(controlLegend,'Location',...
        'northoutside','Orientation','horizontal');
    legend('boxoff');
    set(h1,'FontSize',FONTSIZE);
    axis([0, tempo(final)-tempo(initial), min1,inf])
    xlabel(xAxisLabel)
    ylabel(controlLabel)
    set(gca, 'FontSize', FONTSIZE)
end

exist_folder = exist([handles.diretorio 'Images\'],'dir');
if exist_folder == 0
    mkdir([handles.diretorio 'Images\']);
end
% out = msgbox('Starting to Save Time Response');
screen_size = get(0, 'ScreenSize');
set(gcf,'color','w');
origSize = get(gcf, 'Position'); % grab original on screen size
set(gcf,'units','centimeters')
set(gcf, 'Position', [0 0 15 15] ); %set to scren size
set(gcf,'PaperPositionMode','auto') %set paper pos for printing
export_fig([handles.diretorio '\Images\'  'timeResponse'],'-eps','-png', '-r600','-m2.5')
%     set(gcf,'Position', origSize) %set back to original dimensions
% set(findobj(out,'Tag','MessageBox'),'String','Finished Saving Time Response')

% delete(out)
% close(timeResponse)

end