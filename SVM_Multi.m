function [acc,precision,recall, f1score] = SVM(X_train,y_train,X_test,y_test)

% SVMModel = fitcsvm(X_train,y_train,'Standardize',true,'KernelFunction','RBF');

classNames = unique([y_test' y_train']) ;

classCount = numel(classNames);
SVMModels = cell(classCount,1);
mkdir('models');
% 10 models for 10 actions, using 1 vs all SVM
for i = 1:classCount
    indx = y_train;
    indx(indx ~= classNames(i)) = 0; % Create binary classes for each classifier
    indx(indx == classNames(i)) = 1;
    SVMModels{i} = fitcsvm(X_train,indx,'ClassNames',[1 0],'Standardize',true,...
        'KernelFunction','rbf','BoxConstraint',1);
    model_nm = strcat('models/SVM_model', num2str(i) ,'_',  num2str(now));
    disp(i);
    saveCompactModel(SVMModels{i}, model_nm)
end
% Model=svm.train(X_train,y_train);

predictions = zeros(length(X_test(:,1)),1);

%classify test cases
for j=1:size(y_test,1)
    test_instance = X_test(i, :);
    max_score = -1000;
    max_label = 0;
    for k=1:10
        actual_label = y_test(j, :);
        [label,score2] = predict(SVMModels{k},test_instance);
%         if label == 1
            if score2(1) > max_score
                max_score = score2(1);
                max_label = k;
            end
%         end
    end
    predictions(j) = max_label;
end


tc = transpose(y_test); % True classes
% pc = transpose(label); % Predicted classes
pc = transpose(predictions); % Predicted classes

% h = figure;
% plotroc(tc,pc);
% saveas(h,'SVM_ROC.png');
% h = figure;
% plotconfusion(tc,pc);
% saveas(h,'SVM_CONFUSION.png');

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
fVal = (2*tpr*precision)/(tpr+precision);

fprintf('The sensitivity/Recall is : %d \n', sensitivity);
fprintf('The specificity is : %d \n', specificity);
fprintf('The accuracy is : %d \n', accuracy);
fprintf('The tpr is : %d \n', tpr);
fprintf('The fpr is : %d \n', fpr);
fprintf('The precision is : %d \n', precision);
fprintf('The fVal is : %d \n', fVal);

acc = accuracy;
precision = precision; 
recall = sensitivity;
f1score = fVal;
end