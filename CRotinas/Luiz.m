C = who;
hold on;
legS = '';

for k=1:length(C)
	
	name = C{k};
	figure(1);
	
	M = strfind(name,'PIR');
	
 	if ((length(name) > 4) && isempty(M))
	eval(['plot(',name,'.Dado(:,1))'])
		legS = strvcat(legS, strcat(name,' GonioE.'));
	eval(['plot(',name,'.Dado(:,2))'])
		legS = strvcat(legS, strcat(name,' GonioD.'));
	eval(['plot(',name,'.Dado(:,3))'])
		legS = strvcat(legS, strcat(name,' AngAlvo'));
		
		legC = cellstr(legS);
		legend(legC);
	

	title('Controle sem Relé');
	end
	
end
ylim([0 90]);
hold off;