clear
%% get methylation and switching rate for the Old Model
BetaON = 1;
AlphaOFF = ["16","17.0","17.5"];
alphasOFF = [16,17,17.5];

%first condition
filename = 'HighResRawAlpha%sBeta1Cycle20long.csv';
filename = sprintf(filename,AlphaOFF(3));
disp(filename)
M1 = csvread(filename);
Time = 1:1:numel(M1);
realTime = Time.*0.001;
figure(3)
plot(realTime(1:100:end),M1(1:100:end))
xlabel('Time (hours)')
ylabel('Methylation level')
