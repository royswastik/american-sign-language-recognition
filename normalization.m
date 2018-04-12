M = readtable('features.csv');
M = table2array(M(1:end,1:75));
final = [];
for m=1:74
    V = M(:,m);
    minData = min(V);
    maxData = max(V);
    norm_a = (V - minData) / (maxData - minData);
    final = [final, norm_a];
end
final = horzcat(final,M(:,75));
dlmwrite('feature_normalization.csv',final);