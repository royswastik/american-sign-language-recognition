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

x = [X_train;X_test]';
y_tmp = [y_train;y_test];
% t = bsxfun(@eq, y_tmp(:), 1:max(y_tmp));
t = bsxfun(@eq, y_tmp(:), 1:max(y_tmp));
t = t';

trainFcn = 'trainscg';

hiddenLayerSize = [500 300 100];
net = patternnet(hiddenLayerSize, trainFcn);

net.divideFcn = 'divideind';

len = length([X_train;X_test]);
train_len = round(len*0.6);
val_len = round(train_len*0.7);

net.divideParam.trainInd = 1:val_len;

net.divideParam.valInd = (val_len+1):train_len;

net.divideParam.testInd = (train_len+1):len;

% Train the Network
[net,tr] = train(net,x,t);


testX = x(:,tr.testInd);
testT = t(:,tr.testInd);
% Test the Network
predY = net(x);
% testIndices = vec2ind(predY);
tind = vec2ind(t);
yind = vec2ind(predY);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
% view(net)
% h = figure;
% plotroc(t,y);
% saveas(h,'NN_ROC.png');
% h = figure;
% plotconfusion(t,y);
% saveas(h,'NN_CONFUSION.png');
% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotconfusion(t,y)
%figure, plotroc(t,y)


[C,cm,ind,per] = confusion(t,y);

tp = cm(1,1);
fn = cm(1,2);
fp = cm(2,1);
tn = cm(2,2); 

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
