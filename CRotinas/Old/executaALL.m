diretorio = 'PIES/';
x = dir([diretorio '*.txt']);
tic
for k=21:length(x)
	tic
	arquivo = x(k).name;
	[J, PID] = rotinaReconstrucaoJ(alpha,gamma,omega,h,PID0,arquivo,diretorio);
	length(x) - k 
	toc
end
toc