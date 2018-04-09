function [acc,precision,recall, f1score] = NNet(nn_X,nn_Y)

x = nn_X';
t = nn_Y';

trainFcn = 'trainscg';

hiddenLayerSize = 10;

% Returns the neural network model
net = patternnet(hiddenLayerSize, trainFcn);

net.divideFcn = 'divideind';

len = length(nn_X);
train_len = round(len*0.6);
val_len = round(train_len*0.7);

net.divideParam.trainInd = 1:val_len;

net.divideParam.valInd = (val_len+1):train_len;

net.divideParam.testInd = (train_len+1):len;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);
yind = vec2ind(y);
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

acc = accuracy;
precision = precision; 
recall = sensitivity;
f1score = fVal;

end