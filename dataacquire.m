%% Initialize DAQ
clc;clear;close all;
adi = daq("adi");
addinput(adi,'smu1','a','Voltage');
fs = adi.Rate;
load('dataUpdated.mat');

%% Acquire data

%THIS IS A TEST FOR OUR PROJECT

% Set as 0 for statement and 1 for question
label = 0;
name = 'Name';
new = read(adi,5*fs,'OutputFormat','Matrix');



%% Save data to dataset

data = [data new];
labels = [labels label];
names = [names {name}];
%% Save data to file
%save('dataUpdated.mat','data','labels','names');
