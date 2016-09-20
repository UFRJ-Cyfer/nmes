    figure('Color',[1 1 1],'name',Sinal.File(1:end-4),'NumberTitle','off');
	plot1 = subplot(3,1,1);
	
	
   p11= plot(TempoVic01,VictorReferencia(1:length(TempoVic01)),'r--','LineWidth', 2);hold on;
	
    p12=plot(TempoVic01,Victor01(1:length(TempoVic01)),'b','LineWidth', 2);
	
	set(plot1,'Ytick',0:10:60)
	set(plot1,'YtickLabel',0:10:60)
	
	

	axis([0, 102, -inf,65])

	    ylabel('Angle (º)','FontWeight','bold')
		h1 = legend(p12,'\mu = 0.1','Location',...
			'northoutside','Orientation','horizontal');
		
		legend('boxoff');
% 		set(h,'FontSize',14);
		
		plot2 = subplot(3,1,2);
		min1 = min(Sinal.Param(4),Sinal.Param(5));
		
		p21=plot(TempoVictor0001(1:length(TempoVic01)),...
			VictorReferencia(1:length(TempoVic01)),'r--','LineWidth', 2);hold on;
		
		p22=plot(TempoVictor0001(1:length(TempoVic01)),...
			Victor0001(1:length(TempoVic01)),'b','LineWidth', 2);
		
		set(plot2,'Ytick',0:10:60)
		set(plot2,'YtickLabel',0:10:60)


%         tempo,ones(length(tempo),1)*Sinal.Param(:,4),'r',...
%         tempo,ones(length(tempo),1)*Sinal.Param(:,5),'g');
   h2 = legend(p22,'\mu = 0.001','Location',...
			'northoutside','Orientation','horizontal');
		set(h2,'FontSize',14);
		ylabel('Angle (º)','FontWeight','bold')
		legend('boxoff');
		set(h1,'FontSize',14);
		
	axis([0, 102, -inf,65])
%     xlabel('Time (s)','FontWeight','bold')
%     ylabel('Current (mA)','FontWeight','bold')
	
	plot3 = subplot(3,1,3);
	
   p31 =  plot(TempoVictor00001(1:length(TempoVic01)),VictorReferencia(1:length(TempoVic01)),'r--','LineWidth', 2);hold on;
	
   p32 =  plot(TempoVictor00001(1:length(TempoVic01)),Victor00001(1:length(TempoVic01)),'b','LineWidth', 2);
	axis([0, 102, -inf,65])
	
		ylabel('Angle (º)','FontWeight','bold')
		h3 = legend(p32,'\mu = 0.0001','Location',...
			'northoutside','Orientation','horizontal');
		set(h3,'FontSize',14);
		
		legend('boxoff');
% 		set(h,'FontSize',14);
		set(plot3,'Ytick',0:10:60)
	set(plot3,'YtickLabel',0:10:60)
	
% 	set(gca,'YTickLabel',0:10:60)
	xlabel('Time (s)','FontWeight','bold')
	
		set(h1,'FontSize',20);
		set(h2,'FontSize',20);
		set(h3,'FontSize',20);

	