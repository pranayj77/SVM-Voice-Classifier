clc;clear;close all;
load('dataUpdated.mat');
%%
fs = 100000;

%mfcc_coeff = mfcc(data,fs);
mfcc_coeff = mfcc(data./mean(data,1),fs);
%gfcc_coeff = gtcc(data,fs);


coeff_reshaped = reshape([mfcc_coeff],[],size(data,2));


%% Split Data
cumprec = [];
cumacc= [];
cumreca= [];
cumf1= [];
for i = 1
    data_run = coeff_reshaped';
    % Cross varidation (train: 70%, test: 30%)
    cv = cvpartition(size(data_run,1),'HoldOut',0.30);
    idx = cv.test;
    % Separate to training and test data
    dataTrain = data_run(~idx,:);
    dataTest  = data_run(idx,:);
    labelTrain = labels(~idx);
    labelTest = labels(idx);


    Model = fitcsvm(dataTrain,labelTrain);
    %load('Model.mat');
    labelTest_predict = predict(Model,dataTest);
    correct = labelTest_predict ==labelTest';
    percent = sum(correct)/length(correct);
    [confmat,order] = confusionmat(labelTest,labelTest_predict);
    accuracy = (confmat(1,1)+confmat(2,2))/sum(confmat,'all');
    precision = confmat(1,1)/(confmat(1,1)+confmat(1,2));
    recall = confmat(1,1)/(confmat(1,1)+confmat(2,1));
    f1 = 2*precision*recall/(precision+recall);
    cumacc = [cumacc accuracy];
    cumprec = [cumprec precision];
    cumreca = [cumreca recall];
    cumf1 = [cumf1 f1];
    tp = labelTest_predict == 1 & labelTest' ==1;
    fp = labelTest_predict == 1 & labelTest' ==1;
    tn = labelTest_predict == 1 & labelTest' ==1;
    fn = labelTest_predict == 1 & labelTest' ==1;
end
newacc = sum(cumacc)/length(cumacc);
newprec = sum(cumprec)/length(cumprec);
newreca = sum(cumreca)/length(cumreca);
newf1 = sum(cumf1)/length(cumf1);

%%
load('Model3.mat');
load('testdata.mat');
mfcc_coeff_test = mfcc(filtered,fs);
gtcc_coeff_test = gtcc(filtered,fs);
test = reshape([mfcc_coeff_test;gtcc_coeff_test],[],1);
tes_pred = predict(Model,test');
