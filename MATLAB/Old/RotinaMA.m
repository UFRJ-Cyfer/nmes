
tempo = (Sinal.Dado(:,8) - Sinal.Dado(1,8))/1000;
Angulo = Sinal.Dado(:,1);
Controle = Sinal.Dado(:,6);

figure(10);
subplot(2,1,1)
plot(tempo,Angulo, 'b','LineWidth',2);
ylabel('Angle (º)','FontWeight','bold')
h = legend('Elbow Angle y','Location',...
			'northoutside','Orientation','horizontal');
		legend('boxoff');
		set(h,'FontSize',14);
axis([0, 16, -inf,inf])


subplot(2,1,2)

plot(tempo, Controle, 'r', 'LineWidth',2);
h1 =  legend('Biceps','Location',...
			'northoutside','Orientation','horizontal');
		legend('boxoff');
		set(h1,'FontSize',14);
	axis([0, 16, -inf,inf])
    xlabel('Time (s)','FontWeight','bold')
    ylabel('Current (mA)','FontWeight','bold')