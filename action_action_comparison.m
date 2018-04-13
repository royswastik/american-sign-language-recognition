svm_metrics = table2array(readtable('Accuracy/SVM_Metrics_undersampled.csv'));
nn_metrics = table2array(readtable('Accuracy/NN_Metrics_undersampled.csv'));
dt_metrics = table2array(readtable('Accuracy/DT_Metrics_undersampled.csv'));

actions = {'About', 'And', 'Can', 'Cop', 'Deaf', 'Decide', 'Father', 'Find', 'Goout', 'Hearing'};


users = {'1', '2', '4'};

for u = 1: length(users)
user = cell2mat(users(u));
f1_score_bar_data = [];
precision_bar_data = [];
recall_bar_data = [];
for i= 1:length(nn_metrics)     %Replace 40 with length of Metrics file
    row_user = cell2mat(svm_metrics(i, 1));
    if (strcmp(row_user, user))
        f1_score_bar_data = [f1_score_bar_data; str2num(cell2mat(svm_metrics(i, 6))), str2num(cell2mat(nn_metrics(i,6))),  str2num(cell2mat(dt_metrics(i,6)))];
        precision_bar_data = [precision_bar_data; str2num(cell2mat(svm_metrics(i,4))), str2num(cell2mat(nn_metrics(i,4))),  str2num(cell2mat(dt_metrics(i,4)))];
        recall_bar_data = [recall_bar_data; str2num(cell2mat(svm_metrics(i,5))), str2num(cell2mat(nn_metrics(i,5))),  str2num(cell2mat(dt_metrics(i,5)))];
    end
end

if length(f1_score_bar_data) == 0
    continue;
end

f1_score_bar_data = f1_score_bar_data*100;
precision_bar_data = precision_bar_data*100;
recall_bar_data = recall_bar_data*100;
disp(f1_score_bar_data);

yticks=actions';

l = cell(1,3);
l{1}='SVM'; l{2}='Neural Net'; l{3}='Decision Tree'; 

h1 = figure();
b1 = bar(f1_score_bar_data);
set(gca,'xticklabel',yticks);
xlabel('Actions');
ylabel('F1 Score %');
title(strcat('Action VS F1 Score - User', user));
legend(b1,l);

saveas(gcf,strcat('plots/user',user,'_f1_score.jpg'));

h2 = figure();
b2= bar(precision_bar_data);
set(gca,'xticklabel',yticks);
xlabel('Actions');
ylabel('Precision %');
title(strcat('Action VS Precision - User ', user));
legend(b2,l);

saveas(gcf,strcat('plots/user',user,'_precision.jpg'));

h3 = figure();
b3= bar(recall_bar_data);
set(gca,'xticklabel',yticks);
xlabel('Actions');
ylabel('Recall %');
title(strcat('Action VS Recall - User ', user));
legend(b3,l);

saveas(gcf,strcat('plots/user',user,'_recall.jpg'));

end
