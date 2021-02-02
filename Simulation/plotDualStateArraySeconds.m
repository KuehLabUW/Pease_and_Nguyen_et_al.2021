clear
filenameC = 'kTrRawCompacAlphaON1AlphaOFF4LambdaON0.01DeltaOFF0.55Cycle20.csv';
filenameM = 'kTrRawMethylAlphaON1AlphaOFF4LambdaON0.01DeltaOFF0.55Cycle20.csv';
M = csvread(filenameC);
Time = 0:1:numel(M)-1;%
Y = 0:1:100;
X = zeros(1,101);
figure(1)
plot(Time*(1/3600),M) %each timestep is 1 second, converting into hours
disp(M)
hold on
xlim([0,200])
ylim([0,100])

%plot cell division divider
%for i = 1:100
%    plot(X+(i*20),Y,'-green','LineWidth',0.01)
%end
%xlabel('Time (hours)')
%ylabel('Fraction methylated')
%hold off
%%%%%%%%%%%%%%%%%%%%%
M1 = csvread(filenameM);
Time = 0:1:numel(M1)-1;%
figure(2)
plot(Time*(1/3600),M1) %each timestep is 1 second, converting into hours
disp(M1)
%xlim([20,60])
ylim([0,100])
