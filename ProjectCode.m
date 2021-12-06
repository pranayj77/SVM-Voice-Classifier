close all
adi = daq('adi');
addinput(adi,'smu1','a','Voltage');

fs = adi.Rate;

new = read(adi,5*fs,'OutputFormat','Matrix');
%[B,A] = butter(2,100/200000,'high');
%filtered = filtfilt(B,A,new);

% %%plot(filtered)
% xlabel('Time (sec)');
% ylabel('Voltage (V)');

figure;
pspectrum(new,fs,'spectrogram','TimeResolution',0.5)
% xlim([.4 5]);
% ylim([0 10]);

%sound(filtered,fs)

