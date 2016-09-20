clc
for v=1:length(vol)
    vol{v}
    R.(vol{v}).rampa.TT.ErroMedioAbs
    R.(vol{v}).rampa.TT.ErroAbsMedio
end

clc
for v=1:length(vol)
    vol{v}
   R.(vol{v}).rampa.ErroAbsMedio
   R.(vol{v}).rampa.EM
end
