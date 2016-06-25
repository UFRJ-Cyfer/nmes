close all
load([cd '\antr0_7v2.mat')
tempo=(Sinal.Dado(:,8)-Sinal.Dado(1,8))/1000;

ax(1)=subplot(2,1,1);
h=plot(tempo,Sinal.Dado(:,1:3),'.-');grid on
legend(h,{'GoniD' 'GoniE' 'SinRef'})

ax(2)=subplot(2,1,2);
h=plot(tempo,Sinal.Dado(:,6:7),'.-');grid on
legend(h,['CH1' 'CH2'])

linkaxes(ax,'x');

figure
hist(Sinal.Dado(:,5),100)