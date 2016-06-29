function [J, theta, thetaP, bestResponse,user,ref,control,tempo,ind] = rotinaReconstrucaoJ(alpha,gamma,omega,h,PID0,arquivo,diretorio)
% close all
clear Jmin
if iscolumn(alpha)
	alpha = alpha';
end
if iscolumn(gamma)
	gamma = gamma';
end
if iscolumn(omega)
	omega = omega';
end
if iscolumn(PID0)
	PID0 = PID0';
end



PID0 = [PID0(1) PID0(1)/PID0(2) PID0(1)*PID0(3)];

% diretorio = [cd];
% [arquivo, diretorio] = uigetfile('*.txt','Escolha o Arquivo',diretorio);

[Sinal]=NMESAbreTXT(arquivo, diretorio); %Abre os arquivos e determina o formato
Sinal.Dado(:,[6,7])=abs(round(Sinal.Dado(:,[6,7])*2.5151));

control = [Sinal.Dado(:,6) Sinal.Dado(:,7) ...
	ones(size(Sinal.Dado(:,6)))*Sinal.Param(4)...
	ones(size(Sinal.Dado(:,6)))*Sinal.Param(5)];


% figure('Color',[1 1 1],'name',[Sinal.File],'NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);

% ax(1)=subplot(2,1,1);
% plot(Sinal.Dado(:,1),'r');
% title('Column 1');
% grid on; axis ([0 inf -5 55])
% ax(2)=subplot(2,1,2);
% plot(Sinal.Dado(:,2),'b');
% title('Column 2');
% grid on; axis ([0 inf -5 55])

% prompt = {'Inform T0:'};
% dlg_title = 'Input';
% num_lines = 1;
% defaultans = {'5'};
% answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
% 
% To = str2double(answer{1});

To = 5;

if mean(Sinal.Dado(:,1)) > mean(Sinal.Dado(:,2))
	arm = 1;
else
	arm = 2;
end

user = Sinal.Dado(:,arm);
idx = find(user>150);
user(idx)= user(idx-1);

ref = Sinal.Dado(:,3);
idx = find(ref>150);
ref(idx)= ref(idx-1);

tempo=(Sinal.Dado(:,8)-Sinal.Dado(1,8))/1000;

err = ref - user;


ind = ref > 0;

ind = find(abs(diff(ind))>0);

% if rem(length(ind),2) ~= 0
% 	ind = ind(1:end-1);
% end

J = zeros(length(ind)/2,1);
zeta = J;

theta_ = zeros(length(ind)/2,length(PID0));

theta = theta_;
thetaP = theta_;

theta(1,:) = PID0;
theta_(1,:) = theta(1,:)-alpha;
zeta(1) = 0;

for k=1:length(ind)/2
	
	cSum = cumsum(Sinal.Dado(ind(2*k-1):ind(2*k),5))/1000;
	T0_begin = find(cSum >= To,1);
	int_err = err(ind(2*k-1):ind(2*k));
    int_err = int_err.^2/(max(ref))^2/(20-To);
	J(k) = trapz(cSum(T0_begin:end),int_err(T0_begin:end));
    
    if k == 1
		Jmin = J(k);
		bestResponse = [cSum-cSum(1) user(ind(2*k-1):ind(2*k)) ref(ind(2*k-1):ind(2*k))];
    end
    
		zeta(k+1) = -h*zeta(k) + J(k);
		theta_(k+1,:) = theta_(k,:) - gamma.*alpha.*cos(omega*(k))...
					* (J(k) - (1+h)*zeta(k)); 
		theta(k+1,:) = theta_(k+1,:) + alpha.*cos(omega*(k+1));
	
	if J(k) < Jmin && (ind(2*k) - ind(2*k-1)) > 500
		Jmin = J(k);
		bestResponse = [cSum-cSum(1) user(ind(2*k-1):ind(2*k)) ref(ind(2*k-1):ind(2*k))];
	end
	
% 	if k == 4
% 		bestResponse = [cSum-cSum(1) user(ind(2*k-1):ind(2*k)) ref(ind(2*k-1):ind(2*k))];
% 	end
	
	
end


for k = 1:size(theta,1)
	thetaP(k,:) = [theta(k,1) theta(k,1)/theta(k,2) theta(k,1)*theta(k,3)];
end

end








