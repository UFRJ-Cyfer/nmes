function saveTimeResponse(handles)


user = handles.timeData.timeResponse(:,1);
ref = handles.timeData.timeResponse(:,2);

idx = find(abs(ref)>150);
ref(idx)= ref(idx-1);

tempo = (handles.timeData.timeResponse(:,4) - ...
        handles.timeData.timeResponse(1,4))/1000;
initial = handles.initial;
final = handles.final;

control(:,1) = handles.timeData.timeResponse(:,5);
control(:,2) = handles.timeData.timeResponse(:,6);


    
diretorio = handles.diretorio;
file = handles.file;

timeResponse = figure(3);


subplot(3,1,[1 2]);
plot(tempo(initial:final)-tempo(initial), ...
	user(initial:final),'b','LineWidth', 2);hold on
plot(tempo(initial:final)-tempo(initial),...
	ref(initial:final),'r--','LineWidth', 2);hold off;

if max(ref(initial:final)) > 70
   axis([0,inf,-inf, max(ref)+10]); 
else
    axis([0, inf, -inf,70])
end
%     plot(tempo(R.Trechos(:,1)),Sinal.Dado(R.Trechos(:,1),indRef),...
%         'r*','MarkerSize',10,'LineWidth',2);
%     plot(tempo(R.Trechos(:,2)),Sinal.Dado(R.Trechos(:,2),indRef),...
%         'ro','MarkerSize',10,'LineWidth',2);
%     plot(tempo(R.Trechos(:,3)),Sinal.Dado(R.Trechos(:,3),indRef),...
%         'm*','MarkerSize',10,'LineWidth',2);
%     plot(tempo(R.Trechos(:,4)),Sinal.Dado(R.Trechos(:,4),indRef),...
%         'mo','MarkerSize',10,'LineWidth',2);
%     plot(tempo(R.Trechos(:,5)),Sinal.Dado(R.Trechos(:,5),indRef),...
%         'k+','MarkerSize',10,'LineWidth',2);
%     legend(Sinal.Nome{R.indCon},Sinal.Nome{3},'1','2','3','4','5')
% 		xlabel('Time (s)')
ylabel('Angle (º)')
h = legend('Elbow Angle y(t) ','Reference r(t) ','Location',...
	'northoutside','Orientation','horizontal');
legend('boxoff');
set(h,'FontSize',18);

set(gca, 'FontSize', 18)
xlabel('Time (s)')

str = inputdlg('Input Image Title','ImageTitle');

if isempty(str) == 0
	title(str)
end

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
        tempo(initial:final)-tempo(initial),control(initial:final,2),'g','LineWidth', 2);
%         tempo,ones(length(tempo),1)*control(1,3),'r',...
%         tempo,ones(length(tempo),1)*control(1,4),'g');
   h1 =  legend('Biceps','Triceps','Location',...
			'northoutside','Orientation','horizontal');
		legend('boxoff');
		set(h1,'FontSize',18);
	axis([0, tempo(final)-tempo(initial), min1,inf])
    xlabel('Time (s)')
    ylabel('Current (mA)')
	set(gca, 'FontSize', 18)


    exist_folder = exist([diretorio 'Images\'],'dir');
    if exist_folder == 0
        mkdir([diretorio 'Images\']);
    end
% out = msgbox('Starting to Save Time Response');
    screen_size = get(0, 'ScreenSize');
	set(gcf,'color','w');
    origSize = get(gcf, 'Position'); % grab original on screen size
    set(gcf, 'Position', [0 0 screen_size(3) screen_size(4) ] ); %set to scren size
    set(gcf,'PaperPositionMode','auto') %set paper pos for printing
	export_fig([diretorio 'Images\' file(1:end-4-7) 'timeResponse'],'-eps','-png')
    set(gcf,'Position', origSize) %set back to original dimensions
% set(findobj(out,'Tag','MessageBox'),'String','Finished Saving Time Response')

% delete(out)
close(timeResponse)

end