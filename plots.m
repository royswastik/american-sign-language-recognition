var(1:20) = 1;
for n=2:74
    var1(1:20) = n;
    var = vertcat(var,var1);
end
M = dlmread('feature_normalization.csv');
M = M(1:end,1:75);
actions = {'About', 'And', 'Can', 'Cop', 'Deaf', 'Decide', 'Father', 'Find', 'Goout', 'Hearing'};
for i = 1 : 10
figure();
for m=1:74
    y = M(20*(i-1)+1:20*(i-1)+20,m);    
    scatter(var(m,1:20),y,'Linewidth',1);
    xticks([1:74]);
    hold on
end
title(actions(i));

end
