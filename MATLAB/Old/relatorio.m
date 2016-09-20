				

				X1 = find(Sinal.Dado(:,3) > 0 , 1);
				X1_0 = find(Sinal.Dado(X1:end,3) == 0 , 1);
				X1_0 = X1_0 + X1;
				X2 = find(Sinal.Dado(X1_0:end,3) > 0 , 1);
% 				
				X2 = X1_0 + X2;
				X2_0 = find(Sinal.Dado(X2:end,3) == 0 , 1);
				X2_0 = X2_0 + X2;
				X3 = find(Sinal.Dado(X2_0:end,3) > 0 , 1);
% 								
				X3 = X2_0 + X3;
				X3_0 = find(Sinal.Dado(X3:end,3) == 0 , 1);
				X3_0 = X3_0 + X3;
				X4 = find(Sinal.Dado(X3_0:end,3) > 0 , 1);
% 								
 				X4 = X3_0 + X4;
 				X4_0 = find(Sinal.Dado(X4:end,3) == 0 , 1);
 				X4_0 = X4_0 + X4;
 				X5 = find(Sinal.Dado(X4_0:end,3) > 0 , 1);
				X5 = X4_0 + X5;
% 				
				Ciclos =Sinal.Dado(X1:X5,:);
				
				erro = Ciclos(:,2)-Ciclos(:,3);
				
				plot(erro)
				
				erro1= Ciclos(X1:X2,2)-Ciclos(X1:X2,3);
				erro2=Ciclos(X2:X3,2)-Ciclos(X2:X3,3);
				erro3=Ciclos(X3:X4,2)-Ciclos(X3:X4,3);
				erro4=Ciclos(X4:end,2)-Ciclos(X4:end,3);
				
				RMSE1 = sqrt(mean(erro1.^2));
				RMSE2 = sqrt(mean(erro2.^2));
				RMSE3 = sqrt(mean(erro3.^2));
				RMSE4 = sqrt(mean(erro4.^2));
				
				Evolucao = RMSE4/RMSE1*100
				