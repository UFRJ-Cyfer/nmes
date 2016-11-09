close all
clear all
Kp = 3.83;
Ti = 19.13;
Td = 1.95;
K = [Kp Ti Td];


alpha = 1e-1*[1 10 1];
gamma = 1e-2*[1 5 1];
omega = pi*[0.8 0.8^2 0.8^3];
h = 0.5;


G = 1;
D = 5;
B = 20;
A = 0;
Wo = 1;

s = tf('s');	
sys_d = exp(-s*D); sysx = pade(sys_d,3);

H = tf(G,[A B Wo])*sysx;
H.u = 'u';
H.y = 'y';

IT = 20;
csi = zeros(IT,3);
theta_ = zeros(IT,3);
theta_(1,:) = K(1,:) - alpha;
J = zeros(IT,1);
J(1) = geraSistema(H,K,1);
Jmin = 10000;

for n=2:IT
	
	csi(n) = -h*csi(n-1) + J(n-1);
% 	
	theta_(n,:) = theta_(n-1,:) - alpha.*gamma.*cos(omega*(n-1)) ...
			* (J(n-1) - (1+h)*csi(n-1));
	K(n,:) = theta_(n,:) + alpha.*cos(omega*(n));
	
% 	theta_(n+1,:) = theta_(n,:) - alpha.*gamma.*cos(omega*(n)) ...
% 			* (J(n) - (1+h)*csi(n));
% 	K(n+1,:) = theta_(n+1,:) + alpha.*cos(omega*(n+1));	
% 	
	J(n) = geraSistema(H,K(n,:),0);
	if(J(n) < Jmin)
		Kmin = K(n,:);
		Jmin = J(n);
		Nmin = n;
	end
	J;
% 	K(n,:)
% 	pause
	
	

end

Minimo = geraSistema(H,Kmin,1);
figure
plot(K(:,1),':','LineWidth',2); hold on
plot(K(:,2),'--','LineWidth',2);hold on
plot(K(:,3),'-.','LineWidth',2);hold on
y1 = get(gca,'ylim');
line([Nmin Nmin],y1,'Color',[0 0 0]);
legend('K','Ti','Td')

plot(Nmin,Kmin(1),'*k',...
	Nmin,Kmin(2),'*k',...
	Nmin,Kmin(3),'*k','markers',14)

hold off;

str = sprintf('K = %f, Ti = %f, Td = %f., Nmin = %i',...
				Kmin(1),Kmin(2),Kmin(3),Nmin);
 title(str);

figure
plot(J);

