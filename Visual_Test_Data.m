clc;clear;close all;
load('dataUpdated.mat');
%%
i =10;
plot(data(:,i)/mean(data(:,i),1));
disp(labels(i));
