function [R,SF]=ProcessaFES10(Sinal,CR,prot)
global R
%Definindo qual lado foi controlado e ajustando para indices mais
%convenientes
if Sinal.Param(9)==1 %Lado Controlado 1-lado direito 0-lado esquerdo
    R.indCon=1; %Indice para Sinal GonioD
    indrefbilat=2;
else
    R.indCon=2; %Indice para Sinal GonioE
    indrefbilat=1;
end

indErro=4;

%Correção para alguns casos do protocolo unilateralsemfes  que a referência veio zerada
if sum(strcmpi(prot,{ 'unilatsemfes'}))
    Sinal.Dado(:,3)=Sinal.Dado(:,12);  %sinal de referência igual ao de feedback
    Sinal.Dado(:,4)=Sinal.Dado(:,3)-Sinal.Dado(:,R.indCon); %erro é o angulo de ref-o braço controlado
end

%Correção para alguns casos do protocolo bilateralsemfes  que a referência
%veio como arbitraria
if sum(strcmpi(prot,{ 'bilatsemfes'}))
    Sinal.Dado(:,3)=Sinal.Dado(:,indrefbilat);  %sinal de referência igual ao de feedback
    Sinal.Dado(:,4)=Sinal.Dado(:,3)-Sinal.Dado(:,R.indCon); %erro é o angulo de ref-o braço controlado
end

%Correção do valor da Corrente
Sinal.Dado(:,[6,7])=abs(Sinal.Dado(:,[6,7])*2.5151);

%################################
%Processando
%################################
temp=find(diff(Sinal.Dado(:,8))==0); %remoção de intervalos nulos de tempo entre iterações
temp=setdiff(1:length(Sinal.Dado),temp);
if ~isempty (temp)
    Sinal.Dado=Sinal.Dado(temp,:);
    %disp(['Identificados ' num2str(length(temp)) 'intervalos nulos de tempo entre iterações'])
end
legenda='-';

%##FILTROS
tempo=(Sinal.Dado(:,8)-Sinal.Dado(1,8))/1000; %tempo original
if CR.interpolar==1
    legenda=[legenda 'Interpolado-'];    
    xx=(0:(1/Sinal.Param(12)):max(tempo))'; %tempo interpolado - Sinal.Param(12) é a frequencia
    temp=[];
    for k=1:size(Sinal.Dado,2)
        temp(:,k)=spline(tempo,Sinal.Dado(:,k),xx);
    end
    Sinal.Dado=temp;
    tempo=xx;
	
	tempo;
    
    if CR.passabaixas==1
        FpassaBaixas=4;
        legenda=[legenda,'Passa Baixas: ' num2str(FpassaBaixas) 'Hz-' ];
        [b a]=butter(4,FpassaBaixas/(Sinal.Param(12)/2));
        Sinal.Dado=filtfilt(b,a,Sinal.Dado);
    end
    
    if CR.medianamovel==1
        n=20; %numero de amostras da mediana movel
        legenda=[legenda,'Mediana Móvel ordem:' num2str(n),'-'];
        temp=Sinal.Dado;
        Sinal.Dado=(medfilt1(temp,n)+...
            flipud(medfilt1(flipud(temp),n)))/2;
    end    
    clear x xx Sinal.Interp
end
SF=Sinal.Dado;

%############
%Detecção de Ciclos
indRef=12;
%temp é a primeira derivada do sinal de referência em relação ao tempo amostrado(s)
temp=[0;diff(Sinal.Dado(:,indRef),1)]./(Sinal.Dado(:,5)/1000);

%retifico temp e adiciono um offset
temp=abs(temp)-3;

%identifico mudança de sinal em temp
ind=find(diff(sign(temp))~=0); %encontro os trechos separados pelos transientes
if CR.nCiclos==4
    if length (ind)==12 || length (ind)==8
        ind(end+1)=length(Sinal.Dado(:,indRef));%corrigindo problema na detecção do final do movimento
    end
end

%manipulação dos índices para repetir o 5 ponto, que é o fim de um ciclo e o início de outro
ii=[];
ic=1:4:length(ind)-4;
it=ic+4;
for k=1:length(ic)
    ii(k,:)=[ic(k):it(k)];
end

R.Trechos=ind(ii);

%identifico o número de ciclos completos
R.nCiclos=size(R.Trechos,1);
if R.nCiclos ~= CR.nCiclos
    disp(['=> ' num2str(R.nCiclos) ' ciclos detectados'])    
end

%################################
%Extração de Parametros
%################################

for ciclo=1:size(R.Trechos,1) %numero de ciclos
    
    %determinando parametros de corrente/movimento
    R.Cor=(Sinal.Dado(:,6)-Sinal.Param(:,4))-(Sinal.Dado(:,7)-Sinal.Param(:,5));%corrente aplicada (positiva bic negativa tric)
    
    %Steady State
    larg=10; %numero de amostras para calculo do steady state
    
    ind=R.Trechos(ciclo,3)-larg:R.Trechos(ciclo,3); %indice a ser tratado na Iteração
    
    tempoInd=Sinal.Dado(ind,5);
    R.TT.ErroAngSS(ciclo)=mean(abs(Sinal.Dado(ind,indErro))); %erro em steady state
    
    ind=R.Trechos(ciclo,5)-larg:R.Trechos(ciclo,5); %indice a ser tratado na Iteração
    tempoInd=Sinal.Dado(ind,5);
    R.TT.ErroAngSS2(ciclo)=mean(abs(Sinal.Dado(ind,indErro))); %erro em steady state
    
    %#######################################
    %TESTE DE PARAMETROS MEDIDOS EM TODO O TEMPO - TT
    ind=R.Trechos(ciclo,1):R.Trechos(ciclo,5);
    
    %Medidas de Erro em Relação ao Angulo alvo EM TODO O TEMPO - TT
    R.TT.ErroAbsMedio(ciclo)=mean(abs(Sinal.Dado(ind,indErro)));
    R.TT.EM(ciclo)=mean(Sinal.Dado(ind,indErro));
    R.TT.ErroMax(ciclo)=max(abs(Sinal.Dado(ind,indErro)));
    R.TT.ErroMaxPos(ciclo)=max(Sinal.Dado(ind,indErro));
    R.TT.ErroMaxNeg(ciclo)=min(Sinal.Dado(ind,indErro));
    R.TT.ErroSTD(ciclo)=std(Sinal.Dado(ind,indErro));
    
    %#######################################
    for trecho=1:size(R.Trechos,2)-1 %4 trechos do sinal - subida, plato, descida, plato (1-2 2-3 3-4 4-5)
        %extração de parametros dependentes de trecho do ciclo
        ind=R.Trechos(ciclo,trecho):R.Trechos(ciclo,trecho+1); %indice a ser tratado na Iteração        
        tempoInd=Sinal.Dado(ind,8);
    
        R.DurTR(ciclo,trecho)=tempoInd(end)-tempoInd(1);       
        
        %Medidas de Erro em Relação ao Angulo alvo
        R.ErroAbsMedio(ciclo,trecho)=mean(abs(Sinal.Dado(ind,indErro)));
        R.EM(ciclo,trecho)=mean(Sinal.Dado(ind,indErro));
        R.ErroMax(ciclo,trecho)=max(abs(Sinal.Dado(ind,indErro)));
        R.ErroMaxPos(ciclo,trecho)=max(Sinal.Dado(ind,indErro));
        R.ErroMaxNeg(ciclo,trecho)=min(Sinal.Dado(ind,indErro));
        R.ErroSTD(ciclo,trecho)=std(Sinal.Dado(ind,indErro));        
    end
end

%#######
%Cálculo do Valor do Erro Absoluto Médio dos 3 ciclos inteiros
temp=R.Trechos(1):R.Trechos(end);
R.EAM_SinalCompl=mean(abs(Sinal.Dado(temp,indErro)));
R.EMA_SinalCompl=abs(mean(Sinal.Dado(temp,indErro)));
%#######

%histograma
%100 bins de 2ms
edges=-1:2:100;
[n,bin] = histc(Sinal.Dado(:,5),edges);
n=(n/sum(n))*100;
R.Historama=n;
R.pct20ms=n(11);

if R.pct20ms<80;
    disp(['Alerta: ' round(num2str(R.pct20ms)) '% de intervalos entre 19-21ms'])
end

if Sinal.Param(12)~=50;
    disp('erro Fstim');
end

%%%%%%%%%%
param=fieldnames(R);
%%%%%%%%%%

%################################
%Graficos
%################################
if CR.graficos==1
    %#########
    %Graficos dos Sinais Completos
    figure('Color',[1 1 1],'name',Sinal.File(1:end-4),'NumberTitle','off');
    
    ax(1)=subplot(3,1,1);
    plot(tempo,Sinal.Dado(:,1),'b',...
        tempo,Sinal.Dado(:,2),'k',...
        tempo(1:10:end),Sinal.Dado(1:10:end,3),'r^-',...
        tempo(1:10:end),Sinal.Dado(1:10:end,12),'mv-','MarkerSize',5);
    xlabel('Time (s)')
    ylabel('Elbow Angle (Degrees)')
    legend(Sinal.Nome{[1,2,3,12]}); grid on
    
    title(Sinal.File(1:end-4),'FontSize',14)
    
    ax(2)=subplot(3,1,2); grid on
    plot(tempo,Sinal.Dado(:,6),'r',...
        tempo,Sinal.Dado(:,7),'b',...
        tempo,ones(length(tempo),1)*Sinal.Param(:,4),'r--',...
        tempo,ones(length(tempo),1)*Sinal.Param(:,5),'b--');
    legend(Sinal.Nome{[6,7]},Sinal.NParam{[4,5]}); grid on
    xlabel('Time (s)')
    ylabel('Current (mA)')
    
    pidSum=Sinal.Dado(:,9)+Sinal.Dado(:,10)+Sinal.Dado(:,11);
    ax(3)=subplot(3,1,3); grid on
    plot(tempo,Sinal.Dado(:,11),...
        tempo,Sinal.Dado(:,10),...
        tempo,pidSum,...
        tempo,ones(length(tempo),1)*Sinal.Param(6),'--',...
        tempo,ones(length(tempo),1)*-Sinal.Param(7),'--');
    xlabel('Time (s)')
    ylabel('Current (mA)')
    legend(Sinal.Nome{11},Sinal.Nome{10},'P+I+D',Sinal.NParam{6},Sinal.NParam{7}); grid on
    
    linkaxes(ax,'x')
end
%#########
% Gráficos dos Ciclos
if CR.grafCiclos==1;
	
    figure('Color',[1 1 1],'name',Sinal.File(1:end-4),'NumberTitle','off');
	subplot(3,1,[1 2]);
    plot(tempo,Sinal.Dado(:,indRef),'r--','LineWidth', 2);hold on;
    plot(tempo,Sinal.Dado(:,R.indCon),'b','LineWidth', 2);
	axis([0, inf, -inf,inf])
%     plot(tempo(R.Trechos(:,1)),Sinal.Dado(R.Trechos(:,1),indRef),...
%         'r*','MarkerSize',10,'LineWidth',2);
%     plot(tempo(R.Trechos(:,2)),Sinal.Dado(R.Trechos(:,2),indRef),...
%         'ro','MarkerSize',10,'LineWidth',2);
%     plot(tempo(R.Trechos(:,3)),Sinal.Dado(R.Trechos(:,3),indRef),...
%         'm*','MarkerSize',10,'LineWidth',2);
%     plot(tempo(R.Trechos(:,4)),Sinal.Dado(R.Trechos(:,4),indRef),...
%         'mo','MarkerSize',10,'LineWidth',2);
%     plot(tempo(R.Trechos(:,5)),Sinal.Dado(R.Trechos(:,5),indRef),...
%         'k+','MarkerSize',10,'LineWidth',2);
%     legend(Sinal.Nome{R.indCon},Sinal.Nome{3},'1','2','3','4','5')
% 		xlabel('Time (s)')
	    ylabel('Angle (º)','FontWeight','bold')
		h = legend('Reference y_{m}','Elbow Angle y','Location',...
			'northoutside','Orientation','horizontal');
		legend('boxoff');
		set(h,'FontSize',14);
		subplot(3,1,3);
		min1 = min(Sinal.Param(4),Sinal.Param(5));
		plot(tempo,Sinal.Dado(:,6),'r',...
        tempo,Sinal.Dado(:,7),'g','LineWidth', 2);
%         tempo,ones(length(tempo),1)*Sinal.Param(:,4),'r',...
%         tempo,ones(length(tempo),1)*Sinal.Param(:,5),'g');
   h1 =  legend('Biceps','Triceps','Location',...
			'northoutside','Orientation','horizontal');
		legend('boxoff');
		set(h1,'FontSize',14);
	axis([0, inf, min1,inf])
    xlabel('Time (s)','FontWeight','bold')
    ylabel('Current (mA)','FontWeight','bold')

end

%#########
%histograma do dt
if CR.histograma==1;
    figure('Color',[1 1 1],'name',Sinal.File(1:end-4),'NumberTitle','off');
    bar(edges,R.Historama,'histc')
end

assignin('base', 'TempoTempo', tempo)
