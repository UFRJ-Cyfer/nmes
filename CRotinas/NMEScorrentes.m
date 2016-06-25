clc
for k=1:length(vol)
    limbic(k)=Sinal.(vol{k}).rampa.Param(4)
    limtric(k)=Sinal.(vol{k}).rampa.Param(5)
    maxbic(k)=Sinal.(vol{k}).rampa.Param(6)
    maxtric(k)=Sinal.(vol{k}).rampa.Param(7)
end
vol' 
bic=[limbic',maxbic']
tric=[limtric',maxtric']