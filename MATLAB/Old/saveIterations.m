function [K,tempo] = saveIterations(theta,thetaP,J,bestResponse,tempo,arquivo,diretorio)
	
X=150;
Y=60;
nome = arquivo(1:end-5);

FONTSIZE = 18;
legendS = {'K','Ti','Td'};
legendP = {'K','Ki','Kd'};


iterations = figure('Color',[1 1 1],'name',arquivo,'NumberTitle','off','visible','on');
K = 0:1:length(J)-1;

if length(J) <= 1
	return 
end


str = inputdlg('Input Image Title','ImageTitle');

if isempty(str) == 0
	title(str)
end

ax(1) = subplot(2,2,1);
% set(ax(1),'XTickLabel',{'1','2','3','4','5','6','7','8','9','10'});
% xlim([1 length(J)])
plot(K,theta(:,1),'-',K,theta(:,2),'-.',K,theta(:,3),'--','Marker','o','LineWidth',3);




legend(legendS,'Location','northoutside','Orientation',...
	'horizontal');
title('Parameter Evolution')
set(gca, 'FontSize', FONTSIZE)
 set(ax(1),'XTick',K);
 xlabel('Iterations (k)')


ax(2) = subplot(2,2,2);
% ax(3).XTickMode = 'manual';
% xlim([1 length(J)])

plot(K,thetaP(:,1),'-',K,thetaP(:,2),'-.',K,thetaP(:,3),'--','Marker','o','LineWidth',3);
title('Parameter Evolution')
legend(legendP,'Location','northoutside','Orientation',...
	'horizontal');
set(gca, 'FontSize', FONTSIZE)
 set(ax(2),'XTick',K);
 xlabel('Iterations (k)')

 
ax(3) = subplot(2,2,3);

plot(K,J,'k','LineWidth',3,'Marker','o');
title('Cost Function Evolution')
legend('J(\theta(k))','Location','northoutside','Orientation',...
	'horizontal');
xlabel('Iterations (k)')
ylabel('J(\theta(k))')

set(gca, 'FontSize', FONTSIZE)
 set(ax(3),'XTick',K);
 
ax(4) = subplot(2,2,4);

plot(bestResponse(:,1),bestResponse(:,2),'b','LineWidth',3); hold on
plot(bestResponse(:,1),bestResponse(:,3),'r-.','LineWidth',3); hold off
legend({'Reference','Arm Angle'},'Location','northoutside','Orientation',...
	'horizontal');
title('Best Response');
xlabel('Time (s)')
ylabel('Angle (º)')
axis([0 20 0 70]);

set(gca, 'FontSize', FONTSIZE)


% out = msgbox('Starting to Save Figure 1');

    screen_size = get(0, 'ScreenSize');
	set(gcf,'color','w');
    origSize = get(gcf, 'Position'); % grab original on screen size
    set(gcf, 'Position', [0 0 screen_size(3) screen_size(4) ] ); %set to scren size
    set(gcf,'PaperPositionMode','auto') %set paper pos for printing
	export_fig([diretorio 'Images/' nome 'Iterations'],'-eps','-png','-r600','-m2.5')
    set(gcf,'Position', origSize) %set back to original dimensions
	
% set(findobj(out,'Tag','MessageBox'),'String','Finished Saving Picture 1')
% delete(out)

% timeResponse = figure('Color',[1 1 1],'name',Sinal.File(1:end-4),'NumberTitle','off','visible','off');

% 
% timeResponseFig;
% 
% out = msgbox('Starting to Save Figure 1');
%     screen_size = get(0, 'ScreenSize');
%     origSize = get(gcf, 'Position'); % grab original on screen size
%     set(gcf, 'Position', [0 0 screen_size(3) screen_size(4) ] ); %set to scren size
%     set(gcf,'PaperPositionMode','auto') %set paper pos for printing
% 	export_fig([diretorio 'Images/' nome 'timeResponse'],'-eps','-png')
%     set(gcf,'Position', origSize) %set back to original dimensions
% set(findobj(out,'Tag','MessageBox'),'String','Finished Saving Picture 1')
% 
% delete(out)

%
% set(iterations, 'PaperPositionMode', 'auto');
% set(timeResponse, 'PaperPositionMode', 'auto');
%
% print(iterations,[diretorio 'Images/' nome 'Iterations'] ,'-djpeg','-r200');
% print(timeResponse,[diretorio 'Images/' nome 'timeResponse'] ,'-djpeg','-r200');
%
% %# figure size displayed on screen
% set(iterations, 'Units','centimeters', 'Position',[0 0 X Y])
% movegui(iterations, 'center')
%
% %# figure size printed on paper
% set(iterations, 'PaperUnits','centimeters')
% set(iterations, 'PaperSize',[X Y])
% set(iterations, 'PaperPosition',[0 0 X Y])
% set(iterations, 'PaperOrientation','portrait')
%
% %# figure size displayed on screen
% set(timeResponse, 'Units','centimeters', 'Position',[0 0 X Y])
% movegui(timeResponse, 'center')
%
% %# figure size printed on paper
% set(timeResponse, 'PaperUnits','centimeters')
% set(timeResponse, 'PaperSize',[X Y])
% set(timeResponse, 'PaperPosition',[0 0 X Y])
% set(timeResponse, 'PaperOrientation','portrait')




% print(iterations,[diretorio 'Images/' nome 'Iterations'] ,'-depsc','-r600');
% print(timeResponse,[diretorio 'Images/' nome 'timeResponse'] ,'-depsc','-r600');
close(iterations);
end