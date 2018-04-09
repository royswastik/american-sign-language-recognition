function [acc,precision,recall, f1score] = DecisionTree(X_train,y_train,X_test,y_test)

DmModel = fitctree(X_train,y_train);

saveCompactModel(DmModel, 'models/DmModel');

[label,score] = predict(DmModel,X_test);


tc = transpose(y_test); % True classes
pc = transpose(label); % Predicted classes

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