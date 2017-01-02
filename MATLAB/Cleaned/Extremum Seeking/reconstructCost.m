function [handles] = reconstructCost(handles)
% close all
% clear Jmin

alpha = handles.M(:,2)';
gamma = handles.M(:,3)';
omega = handles.M(:,4)';
PID0 = handles.M(:,1)';

h = 0.5;
To = 5;


PID0 = [PID0(1) PID0(1)/PID0(2) PID0(1)*PID0(3)];


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

user = handles.timeData.timeResponse(:,1);
idx = find(user>150);
user(idx)= user(idx-1);

ref = handles.timeData.timeResponse(:,2);
idx = find(ref>150);
ref(idx)= ref(idx-1);

[~, index] = find( handles.timeData.timeResponse(1,:) > 10000);

tempo = (handles.timeData.timeResponse(:,index) - ...
	handles.timeData.timeResponse(1,index))/1000;

dts = handles.timeData.timeResponse(:,4);

err = ref - user;

ind = ref > 0;

ind = find(abs(diff(ind))>0);

% if rem(length(ind),2) ~= 0
% 	ind = ind(1:end-1);
% end

J = zeros(floor(length(ind)/2),1);
zeta = J;

theta_ = zeros(floor(length(ind)/2),length(PID0));

theta = theta_;
thetaP = theta_;

theta(1,:) = PID0;
theta_(1,:) = theta(1,:)-alpha;
zeta(1) = 0;
bestResponse =[];

for k=1:length(ind)/2
	
	cSum = cumsum(dts(ind(2*k-1):ind(2*k)))/1000;
	T0_begin = find(cSum >= To,1);
	int_err = err(ind(2*k-1):ind(2*k));
    int_err = int_err.^2/(max(ref))^2/(20-To);
	J(k) = trapz(cSum(T0_begin:end),int_err(T0_begin:end));
    
    if k == 1
		Jmin = J(k);
		bestResponse = [user(ind(2*k-1):ind(2*k)) ref(ind(2*k-1):ind(2*k))];
        timeBestResponse = cSum-cSum(1);
    end
    
		zeta(k+1) = -h*zeta(k) + J(k);
		theta_(k+1,:) = theta_(k,:) - gamma.*alpha.*cos(omega*(k))...
					* (J(k) - (1+h)*zeta(k)); 
		theta(k+1,:) = theta_(k+1,:) + alpha.*cos(omega*(k+1));
	
	if J(k) < Jmin && (ind(2*k) - ind(2*k-1)) > 500
		Jmin = J(k);
		bestResponse = [user(ind(2*k-1):ind(2*k)) ref(ind(2*k-1):ind(2*k))];
        timeBestResponse = cSum-cSum(1); 
	end
	
end

for k = 1:size(theta,1)
	thetaP(k,:) = [theta(k,1) theta(k,1)/theta(k,2) theta(k,1)*theta(k,3)];
end

handles.theta = theta;
handles.thetaP = thetaP;
handles.bestResponse = bestResponse;
handles.timeBestResponse = timeBestResponse;

handles.user = user;
handles.ref = ref;
handles.tempo = tempo;

handles.ind = ind;
handles.J = J;


end








