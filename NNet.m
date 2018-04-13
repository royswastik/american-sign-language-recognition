function [acc,precision,recall, f1score] = NNet(nn_X_train, nn_X_test,nn_Y_train, nn_Y_test, label)

x = nn_X_train';
t = nn_Y_train';

trainFcn = 'trainscg';

hiddenLayerSize = 10;

% Returns the neural network model
net = patternnet(hiddenLayerSize, trainFcn);


net.divideFcn = 'divideind';

len = length(nn_X_train);
train_len = round(len*1);
val_len = round(train_len*0.7);

net.divideParam.trainInd = 1:val_len;

net.divideParam.valInd = (val_len+1):train_len;

net.divideParam.testInd = (train_len+1):len;

% Train the Network
[net,tr] = train(net,x,t);


% Test the Network
y = net(nn_X_test');
e = gsubtract(nn_Y_test',y);
performance = perform(net,nn_Y_test',y)
tind = vec2ind(nn_Y_test');
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
% view(net)
% h = figure;
% plotroc(nn_Y_test',y);
% saveas(h,'NN_ROC.png');
% h = figure;
% plotconfusion(nn_Y_test',y);
% saveas(h,'NN_CONFUSION.png');
% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, ploterrhist(e)
% figure, plotconfusion(nn_Y_test',y)
% figure, plotroc(nn_Y_test',y)


[C,cm,ind,per] = confusion(nn_Y_test',y);

tp = cm(1,1);
fn = cm(1,2);
fp = cm(2,1);
tn = cm(2,2); 

if tn < 3
    figure, plotconfusion(nn_Y_test',y)
end

sensitivity = tp /( tp + fn );
specificity = tn /( fp + tn );
recall = tp / ( tp + fn );
accuracy = (tp+tn) / (tp+fn+fp+tn); 
tpr = sensitivity;
fpr = 1-specificity;
% fVal = (2*tpr*precision)/(tpr+precision);
precision = tp /( tp + fp );
recall = tp / ( tp + fn );
f1score = (2*recall*precision) / ( recall + precision);

fprintf('The sensitivity/Recall is : %d \n', sensitivity);
fprintf('The specificity is : %d \n', specificity);
fprintf('The accuracy is : %d \n', accuracy);
fprintf('The tpr is : %d \n', tpr);
fprintf('The fpr is : %d \n', fpr);
fprintf('The precision is : %d \n', precision);
% fprintf('The fVal is : %d \n', fVal);

acc = accuracy;
precision = precision; 
recall = recall;
f1score = f1score;

end