function timeResponseFig(tempo,user,ref,control,initial,final,file,diretorio)

timeResponse = figure;
subplot(3,1,[1 2]);
plot(tempo(initial:final)-tempo(initial), ...
	user(initial:final),'b','LineWidth', 2);hold on
plot(tempo(initial:final)-tempo(initial),...
	ref(initial:final),'r--','LineWidth', 2);hold off;

axis([0, inf, -inf,70])
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

subplot(3,1,3);

biceps = control(:,1);
triceps = control(:,2);
		minB = min(biceps(biceps>0));
		minT = min(triceps(triceps>0));
		
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


str = inputdlg('Input Image Title','ImageTitle');

if isempty(str) == 0
	title(str)
end


% out = msgbox('Starting to Save Time Response');
    screen_size = get(0, 'ScreenSize');
	set(gcf,'color','w');
    origSize = get(gcf, 'Position'); % grab original on screen size
    set(gcf, 'Position', [0 0 screen_size(3) screen_size(4) ] ); %set to scren size
    set(gcf,'PaperPositionMode','auto') %set paper pos for printing
	export_fig([diretorio 'Images/' file(1:end-5) 'timeResponse'],'-eps','-png')
    set(gcf,'Position', origSize) %set back to original dimensions
% set(findobj(out,'Tag','MessageBox'),'String','Finished Saving Time Response')

% delete(out)
close(timeResponse)

end