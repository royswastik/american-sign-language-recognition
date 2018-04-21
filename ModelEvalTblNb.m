% read in data
data_tmp = dlmread('pca_feature.csv');
X_train = [];
X_test = [];
y_train = [];
y_test = [];
for i = 1:10
    bucket = data_tmp(find(data_tmp(:,end) == i), :);
    data_X_b = bucket(:,1:end-1);
    data_Y_b = bucket(:,end);

    training_fraction = 0.6;


    X_train = [X_train; data_X_b(1:length(data_X_b)*training_fraction, :)];
    X_test = [X_test; data_X_b(1+length(data_X_b)*training_fraction:end, :)];
    y_train = [y_train; data_Y_b(1:length(data_Y_b)*training_fraction, :)];
    y_test = [y_test; data_Y_b(1+length(data_Y_b)*training_fraction:end, :)];
end

Mdl = fitcnb(X_train,y_train);

labels = predict(Mdl,X_test);

tc = transpose(y_test); % True classes
pc = transpose(labels); % Predicted classes

[C,order] = confusionmat(tc,pc);

tp = C(1,1);
fn = C(1,2);
fp = C(2,1);
tn = C(2,2); 
sensitivity = tp /( tp + fn );
specificity = tn /( fp + tn );
accuracy = (tp+tn) / (tp+fn+fp+tn); 
tpr = sensitivity;
fpr = 1-specificity;
precision = tp /( tp + fp );
recall = tp / ( tp + fn );

fprintf('TP: %d TN: %d FP: %d FN: %d', tp, tn, fp, fn);
f1score = (2*recall*precision) / ( recall + precision);
fprintf('The sensitivity/Recall is : %d \n', sensitivity);
fprintf('The specificity is : %d \n', specificity);
fprintf('The accuracy is : %d \n', accuracy);
fprintf('The tpr is : %d \n', tpr);
fprintf('The fpr is : %d \n', fpr);
fprintf('The precision is : %d \n', precision);