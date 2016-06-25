close all
figure;
tempo=(Sinal.LCS1510.rampa.Dado(:,8)-Sinal.LCS1510.rampa.Dado(1,8))/1000;
ax(1) = subplot(3,1,1);
plot(tempo,Sinal.LCS1510.rampa.Dado(:,1));
ax(2) = subplot(3,1,2);
plot(tempo,Sinal.LCS1510.rampa.Dado(:,6));
ax(3) = subplot(3,1,3);
plot(tempo,Sinal.LCS1510.rampa.Dado(:,7));

linkaxes(ax,'x');