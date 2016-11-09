function J = geraSistema(H,K,plot)
C = pid(K(1),K(1)/K(2),K(1)*K(3));
C.u = 'e';
C.y = 'u';


Ton = 100;
Toffset = 0;
Tc = 10;
T = Ton+Toffset;
Ts = 0.01;
t = 0:Ts:T;

r = 45*rectpuls(t-Ton/2-Toffset,Ton);
r(end) = 1;

Sum1 = sumblk('e=r-y');
Htotal = connect(C,H,Sum1,'r','y');
	if plot
		figure;
		lsim(Htotal,r,t)
	end
y = lsim(Htotal,r,t);
J = trapz((y(Tc/Ts:end)-r(Tc/Ts:end)').^2)/Ts/(45^2*(Ton-Tc));
clear Sum1 Htotal C
instrreset
end