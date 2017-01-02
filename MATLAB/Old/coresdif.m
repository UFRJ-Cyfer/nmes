function cores=coresdif(Ncores) %rotina que gera um cell array de cores diferentes
colors = distinguishable_colors(Ncores);
[y,ind] = sort(sum(colors,2), 'descend');
colors=colors(ind,:);

for k=1:Ncores
    cores(k)={colors(k,:)};
end


