function saveITES(handles)
	
X=150;
Y=60;
nome = handles.file(1:end-5);
iterationsLineWidth = 2;

FONTSIZE = 16;
legendS = {'K','Ti','Td'};
legendP = {'K','Ki','Kd'};
xLabelIterations = 'Iterações (k)';
parameterEvolution = 'evo';


iterations = figure('Color',[1 1 1],'name',nome,'NumberTitle','off','visible','on');

K = 0:1:length(handles.J(handles.initialJ:handles.finalJ))-1;

if length(handles.J(handles.initialJ:handles.finalJ)) <= 1
	return 
end


% str = inputdlg('Input Image Title','ImageTitle');
% 
% if isempty(str) == 0
% 	title(str)
% end

ax(1) = subplot(2,1,1);
% set(ax(1),'XTickLabel',{'1','2','3','4','5','6','7','8','9','10'});
% xlim([1 length(J)])
plot(K,handles.thetaP(handles.initialJ:handles.finalJ,1),'-',K,handles.thetaP(handles.initialJ:handles.finalJ,2),'-.',K,handles.theta(handles.initialJ:handles.finalJ,3),'--','Marker','o','LineWidth',iterationsLineWidth);

legend(legendP,'Location','northoutside','Orientation',...
	'horizontal');
legend('boxoff');
% title('Evolução dos Parâmetros')
set(gca, 'FontSize', FONTSIZE)
 set(ax(1),'XTick',K);
%  xlabel(xLabelIterations)
 axis([0 K(end) -inf inf]);



% ax(2) = subplot(2,2,2);
% ax(3).XTickMode = 'manual';
% xlim([1 length(J)])

% plot(K,handles.thetaP(handles.initialJ:handles.finalJ,1),'-',K,handles.thetaP(handles.initialJ:handles.finalJ,2),'-.',K,handles.thetaP(handles.initialJ:handles.finalJ,3),'--','Marker','o','LineWidth',iterationsLineWidth);
% title('Evolução dos Parâmetros')
% legend(legendP,'Location','northoutside','Orientation',...
% 	'horizontal');
% legend('boxoff');

% set(gca, 'FontSize', FONTSIZE)
%  set(ax(2),'XTick',K);
%  xlabel(xLabelIterations)
%   axis([0 K(end) -inf inf]);


 
ax(3) = subplot(2,1,2);

plot(K,handles.J(handles.initialJ:handles.finalJ),'k','LineWidth',3,'Marker','o');
% title('Custo')
legend('J(\theta(k))','Location','northoutside','Orientation',...
	'horizontal');
legend('boxoff');

xlabel(xLabelIterations)
ylabel('J(\theta(k))')
 axis([0 K(end) -inf inf]);


set(gca, 'FontSize', FONTSIZE)
 set(ax(3),'XTick',K);
%  
% ax(4) = subplot(2,2,4);
% 
% plot(handles.timeBestResponse,handles.bestResponse(:,1),'b','LineWidth',iterationsLineWidth); hold on
% plot(handles.timeBestResponse,handles.bestResponse(:,2),'r-.','LineWidth',iterationsLineWidth); hold off
% legend({'V','R'},'Location','northoutside','Orientation',...
% 	'horizontal');
% legend('boxoff');
% 
% % title('Melhor Resposta');
% xlabel('Tempo (s)')
% ylabel('Ângulo (\circ)')
% axis([0 20 0 70]);

% set(gca, 'FontSize', FONTSIZE)


% out = msgbox('Starting to Save Figure 1');

    screen_size = get(0, 'ScreenSize');
	set(gcf,'color','w');
    origSize = get(gcf, 'Position'); % grab original on screen size
    set(gcf,'units','centimeters')
    set(gcf, 'Position', [0 0 15 15] ); %set to scren size
    set(gcf,'PaperPositionMode','auto') %set paper pos for printing
	export_fig([handles.diretorio 'Images/' nome 'Iterations'],'-eps','-png','-r600','-m2.5')
    set(gcf,'Position', origSize) %set back to original dimensions
end