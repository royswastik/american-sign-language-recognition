function [acc,precision,recall, f1score] = SVM(X_train,y_train,X_test,y_test, i)

% SVMModel = fitcsvm(X_train,y_train,'Standardize',true,'KernelFunction','RBF');

classNames = unique([y_test' y_train']) ;

classCount = numel(classNames);
SVMModels = cell(classCount,1);
mkdir('models');
% 10 models for 10 actions, using 1 vs all SVM
    SVMModels{i} = fitcsvm(X_train,y_train,'ClassNames',[1 0],'Standardize',true,...
        'KernelFunction','rbf','BoxConstraint',1);
    model_nm = strcat('models/SVM_model', num2str(i) ,'_',  num2str(now));
    disp(i);
    saveCompactModel(SVMModels{i}, model_nm)
    
    [label,score2] = predict(SVMModels{i},X_test);
    tc = transpose(y_test); % True classes
    pc = transpose(label); % Predicted classes
%     h = figure;
%     plotroc(tc,pc);
%     saveas(h,strcat(num2str(i),'SVM_ROC.png'));
%     h = figure;
%     plotconfusion(tc,pc);
%     saveas(h,strcat(num2str(i),'SVM_CONFUSION.png'));

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
f1score = (2*recall*precision) / ( recall + precision);
    fprintf('The sensitivity/Recall is : %d \n', sensitivity);
    fprintf('The specificity is : %d \n', specificity);
    fprintf('The accuracy is : %d \n', accuracy);
    fprintf('The tpr is : %d \n', tpr);
    fprintf('The fpr is : %d \n', fpr);
    fprintf('The precision is : %d \n', precision);
    fprintf('The fVal is : %d \n', fVal);

    acc = accuracy;
    precision = precision; 
    recall = recall;
    f1score = f1score;


end

