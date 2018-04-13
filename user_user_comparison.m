svm_metrics = table2array(readtable('Accuracy/SVM_Metrics_undersampled.csv'));
nn_metrics = table2array(readtable('Accuracy/SVM_Metrics_undersampled.csv'));
dt_metrics = table2array(readtable('Accuracy/SVM_Metrics_undersampled.csv'));

actions = {'About', 'And', 'Can', 'Cop', 'Deaf', 'Decide', 'Father', 'Find', 'Goout', 'Hearing'};

users = {'1', '2', '3', '4', '5', '7', '8', '9', '11', '12'};
for a = 1: length(actions)
action = cell2mat(actions(a));
f1_score_bar_data = [];
precision_bar_data = [];
recall_bar_data = [];
for i= 1:length(nn_metrics)     %Replace 40 with length of Metrics file
    row_action = cell2mat(svm_metrics(i, 2));
    if (strcmp(row_action, action))
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
xlabel('User');
ylabel('F1 Score %');
title(strcat('User VS F1 Score - Action', action));
legend(b1,l);
mkdir('plots/analysis/');
saveas(gcf,strcat('plots/analysis/action_',action,'_f1_score.jpg'));

h2 = figure();
b2= bar(precision_bar_data);
set(gca,'xticklabel',yticks);
xlabel('User');
ylabel('Precision %');
title(strcat('User VS Precision - Action ', action));
legend(b2,l);

saveas(gcf,strcat('plots/analysis/action_',action,'_precision.jpg'));

h3 = figure();
b3= bar(recall_bar_data);
set(gca,'xticklabel',users);
xlabel('User');
ylabel('Recall %');
title(strcat('User VS Recall - Action ', action));
legend(b3,l);

saveas(gcf,strcat('plots/analysis/action_',action,'_recall.jpg'));

end
