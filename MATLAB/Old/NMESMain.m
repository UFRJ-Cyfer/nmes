tic
%ABRE E PROCESSA
if 1
    limpa
    %configura formato das figuras que serão salvas
    CR.X=15;
    CR.Y=6;
    
    CR.modo='manual';
    %CR.modo='auto';
    
    %1-executa 0-nao executa
    CR.graficos=1;
    CR.histograma=0;%histograma do dt
    CR.grafCiclos=0;%graficos específicos para a marcação dos ciclos-usando rampa
    CR.interpolar=0;
    CR.passabaixas=0;%só executa se interpolar==1
    CR.medianamovel=0;
    CR.suprimenome=1;
    CR.Ingles=0;
    crg.Ingles=0;
    crg.PB=0;
    
	NMES_AbreProc %não é função- cria variáveis 
    %RTrec=NMES_ResultadoTrechos(R,vol,prot);
    %RProt=NMES_ErroGrupo2(Sinal,R,vol,prot);
    if strcmp(CR.modo,'auto')
     RMed=NMES_ResultadosMedios2(R,vol,prot);
    end
    
end

%CRIA ESTRUTURA DE RESULTADOS E GRAFICOS DE GRUPO
if 0
    %NMES_Resultados(Sinal,CR,vol,protocolo,movCompleto,GeraGraf,SalvaGraf)
    R=NMES_Resultados(Sinal,CR,R,vol,'bilat',1,1,1);
    R=NMES_Resultados(Sinal,CR,R,vol,'unilat',0,1,1);
    R=NMES_Resultados(Sinal,CR,R,vol,'unilat',1,1,1);
    R=NMES_Resultados(Sinal,CR,R,vol,'bilat',0,1,1);
    close all
end

%CRIA GRAFICOS NO TEMPO
crg.SalvaGraf=0;

if 0
    crg.Separados=1;
    crg.Superpostos=0;
    GrafTempoMain6(Sinal,R,CR,crg,vol,prot);
    close all
end

if 0
    crg.Separados=0;
    crg.Superpostos=1;
     GrafTempoMain6(Sinal,R,CR,crg,vol,prot);
    close all
end
toc
