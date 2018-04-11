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

% [acc,precision,recall, f1score] = SVM(X_train,y_train,X_test,y_test);
classNames = unique([y_test' y_train']) ;
for i = 1:10
    y_train_2 = y_train;
    y_train_2(y_train_2 ~= classNames(i)) = 0; % Create binary classes for each classifier
    y_train_2(y_train_2 == classNames(i)) = 1;
    
    y_test2 = y_test;
    y_test2(y_test2 ~= classNames(i)) = 0; % Create binary classes for each classifier
    y_test2(y_test2 == classNames(i)) = 1;
    [acc,precision,recall, f1score] = SVM(X_train,y_train_2,X_test,y_test2, i);
    
    [acc,precision,recall, f1score] = NNet([X_train; X_test] ,[y_train_2 ;y_test2]);
    
    [acc,precision,recall, f1score] = DecisionTree(X_train,y_train_2,X_test,y_test2);
end

