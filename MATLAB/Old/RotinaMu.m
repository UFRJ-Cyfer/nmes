    titleFont = 18;
figure('Color',[1 1 1],'NumberTitle','off');
	plot1 = subplot(3,1,1);
	load('F:\BitBucket\ProjetoFinal\projetofinal\FES2CHMAIN24_V85\Antigo\VictorPIRele15_0401.mat');
    TempoVic01 = (Sinal.Dado(:,8)-Sinal.Dado(1,8))/1000;
    VictorReferencia = Sinal.Dado(:,3);
    ref = (VictorReferencia>0);
    ind = ref > 0;
    ind = find(abs(diff(ind))>0);
    Victor01 = Sinal.Dado(:,1);
	
    p12=plot(TempoVic01(ind(1):ind(7)) - TempoVic01(ind(1)),...
        Victor01(ind(1):ind(7)),'b','LineWidth', 2);
    hold on;
		
   p11= plot(TempoVic01(ind(1):ind(7)) - TempoVic01(ind(1)),...
       VictorReferencia(ind(1):ind(7)),'r--','LineWidth', 2);
   t = title('\mu = 0.1','FontWeight','bold');
                set(t, 'FontSize', titleFont);


	set(plot1,'Ytick',0:20:60)
	set(plot1,'YtickLabel',0:20:60)
	
	

	axis([0, 120, -5,65])

	    ylabel('Angle (º)','FontWeight','bold')
                set(gca,'fontsize',18);

% 		h1 = legend(p12,'\mu = 0.1','Location',...
% 			'northoutside','Orientation','horizontal');
		  h1 =  legend('Elbow Angle y','Reference y_{m}')

		legend('boxoff');
% 		set(h,'FontSize',14);
		
		plot2 = subplot(3,1,2);
% 		min1 = min(Sinal.Param(4),Sinal.Param(5));
        
    load('F:\BitBucket\ProjetoFinal\projetofinal\FES2CHMAIN24_V85\Antigo\VictorPIRele15_040001.mat');
    TempoVictor0001 = (Sinal.Dado(:,8)-Sinal.Dado(1,8))/1000;
    VictorReferencia = Sinal.Dado(:,3);
        ref = (VictorReferencia>0);
    ind = ref > 0;
    ind = find(abs(diff(ind))>0);
    Victor0001 = Sinal.Dado(:,1);
    
		

		p22=plot(TempoVictor0001(ind(3):ind(9)) - TempoVictor0001(ind(3)),...
			Victor0001(ind(3):ind(9)),'b','LineWidth', 2);
        hold on;
        
		p21=plot(TempoVictor0001(ind(3):ind(9))- TempoVictor0001(ind(3)),...
			VictorReferencia(ind(3):ind(9)),'r--', 'LineWidth', 2);
        t=    title('\mu = 0.001','FontWeight','bold');
                     set(t, 'FontSize', 18);


		
		set(plot2,'Ytick',0:20:60)
		set(plot2,'YtickLabel',0:20:60)


%         tempo,ones(length(tempo),1)*Sinal.Param(:,4),'r',...
%         tempo,ones(length(tempo),1)*Sinal.Param(:,5),'g');
%    h2 = legend(p22,'\mu = 0.001','Location',...
% 			'northoutside','Orientation','horizontal');
% 		set(h2,'FontSize',14);
   h2 = legend('Elbow Angle y','Reference y_{m}');

		ylabel('Angle (º)','FontWeight','bold')
                set(gca,'fontsize',18);

		legend('boxoff');
% 		set(h1,'FontSize',14);
		
	axis([0, 120, -5,65])
%     xlabel('Time (s)','FontWeight','bold')
%     ylabel('Current (mA)','FontWeight','bold')
	
	plot3 = subplot(3,1,3);
    
    load('F:\BitBucket\ProjetoFinal\projetofinal\FES2CHMAIN24_V85\Antigo\VictorPIRele15_0400001.mat');
    TempoVictor00001 = (Sinal.Dado(:,8)-Sinal.Dado(1,8))/1000;
    VictorReferencia = Sinal.Dado(:,3);
        ref = (VictorReferencia>0);
    ind = ref > 0;
    ind = find(abs(diff(ind))>0);
    Victor00001 = Sinal.Dado(:,1);
    
	   p32 =  plot(TempoVictor00001(ind(3):ind(9))- TempoVictor00001(ind(3)),...
           Victor00001(ind(3):ind(9)),'b','LineWidth', 2);
       hold on

   p31 =  plot(TempoVictor00001(ind(3):ind(9))- TempoVictor00001(ind(3)),...
       VictorReferencia(ind(3):ind(9)),'r--','LineWidth', 2);
   h3 = legend('Elbow Angle y','Reference y_{m}')
	
	axis([0, 120, -5,65])
	
		ylabel('Angle (º)','FontWeight','bold')
        set(gca,'fontsize',18);
% 		h3 = legend(p32,'\mu = 0.0001','Location',...
% 			'northoutside','Orientation','horizontal');
% 		set(h3,'FontSize',14);
		
		legend('boxoff');
% 		set(h,'FontSize',14);
		set(plot3,'Ytick',0:20:60)
	set(plot3,'YtickLabel',0:20:60)
    
             t =   title('\mu = 0.0001','FontWeight','bold');
             set(t, 'FontSize', 18);

	
% 	set(gca,'YTickLabel',0:10:60)
	xlabel('Time (s)','FontWeight','bold')
	
		set(h1,'FontSize',14);
		set(h2,'FontSize',14);
		set(h3,'FontSize',14);

        
    screen_size = get(0, 'ScreenSize');
	set(gcf,'color','w');
    origSize = get(gcf, 'Position'); % grab original on screen size
    set(gcf, 'Position', [0 0 screen_size(3) screen_size(4) ] ); %set to scren size
    set(gcf,'PaperPositionMode','auto') %set paper pos for printing
	export_fig(['Images\' 'MU' 'timeResponse'],'-eps','-png')
    set(gcf,'Position', origSize) %set back to original dimensions
% set(findobj(out,'Tag','MessageBox'),'String','Finished Saving Time Response')