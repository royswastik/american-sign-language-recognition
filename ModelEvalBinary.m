users = [1,2,3,4,5,7,8,9,11,12];
SamplerUtil = sampler_util;
basePath = '';
%Storing the generated Accuracy, Precision, Recall , F1_Score
% svmFile = fullfile(baseDir,'Accuracy','SVM_Metrics.csv');
% nnFile = fullfile(baseDir,'Accuracy','NN_Metrics.csv');
% dtFile = fullfile(baseDir,'Accuracy','DT_Metrics.csv');
metrics = ["User", "Action", "Accuracy","Precision","Recall","F1_Score"];
actions = {'About', 'And', 'Can', 'Cop', 'Deaf', 'Decide', 'Father', 'Find', 'Goout', 'Hearing'};

svm_data = metrics;
nn_data = metrics;
dt_data = metrics;

mkdir('pca_features')
for j = 1:10
    % read in data
    file_path_separator = '\';
    if users(j) < 10
        idx = strcat('0',num2str(users(j)));
    else
        idx = num2str(users(j))
    end
    pcaFileName = strcat('pca_features',num2str(idx),'.csv')
    pcaDataFile = strcat(basePath,'pca_features',file_path_separator,pcaFileName)
    data_tmp = dlmread(pcaDataFile);
    baseDir = pwd;
    
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

    classNames = unique([y_test' y_train']) ;
    user_idx = users(j);
    for i = 1:10  %For each action
        
        X_train2 = X_train;
        y_train_2 = y_train;
        dataXY = SamplerUtil.undersample([X_train2 y_train_2], classNames(i));  %Comment out to remove undersampling
        X_train2 = dataXY(:, 1:end-1);  %Comment out to remove undersampling
        y_train_2 = dataXY(:, end);     %Comment out to remove undersampling
        
        y_train_2(y_train_2 ~= classNames(i)) = 0; % Create binary classes for each classifier
        y_train_2(y_train_2 == classNames(i)) = 1;

        X_test2 = X_test;
        y_test2 = y_test;
        dataXY = SamplerUtil.undersample([X_test2 y_test2], classNames(i));     %Comment out to remove undersampling
        X_test2 = dataXY(:, 1:end-1);       %Comment out to remove undersampling
        y_test2 = dataXY(:, end);   %Comment out to remove undersampling
        
        y_test2(y_test2 ~= classNames(i)) = 0; % Create binary classes for each classifier
        y_test2(y_test2 == classNames(i)) = 1;
        [acc,precision,recall, f1score] = SVM(X_train2,y_train_2,X_test2,y_test2, i);
        svm_data = [ svm_data ; [user_idx ,actions(i) ,acc,precision,recall, f1score]];

        [acc,precision,recall, f1score] = NNet(X_train2, X_test2 ,y_train_2, y_test2, actions(i));
        nn_data = [ nn_data ; [user_idx ,actions(i) ,acc,precision,recall, f1score]];

%         [acc,precision,recall, f1score] = DecisionTree(X_train2,y_train_2,X_test2,y_test2);
%         dt_data = [ dt_data ; [user_idx ,actions(i) ,acc,precision,recall, f1score]];
    end
end

writetable(array2table(svm_data), 'Accuracy/SVM_Metrics_undersampled.csv');
writetable(array2table(nn_data), 'Accuracy/NN_Metrics_undersampled.csv');
writetable(array2table(dt_data), 'Accuracy/DT_Metrics_undersampled.csv');
