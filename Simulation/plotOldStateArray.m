clear
%filenameC = 'TF1Tr50RawMethylAlphaON6.4AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
filenameM = 'RawAlpha17Beta1Cycle20.csv';
X = zeros(1,101);
Y = 0:1:100;
%%%%%%%%%%%%%%%%%%%%%
M1 = csvread(filenameM);
Time = 0:1:numel(M1)-1;%
figure(3)
hold on
plot(Time*0.1,(M1./100).*100) %each timestep is 0.1 hour
disp(M1)
xlim([0,100])
ylim([0,70])
%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Fraction methylated')

figure(4)
hold on
plot(Time*0.1,(M1./100).*100) %each timestep is 0.1 hour
disp(M1)
xlim([19,21])
ylim([0,70])
%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Fraction methylated')