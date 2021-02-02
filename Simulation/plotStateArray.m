clear
filename = 'RawMethylAlphaON0.1AlphaOFF0.2LambdaON0.1DeltaOFF3.8Cycle20.csv';
M = csvread(filename);
Time = 0:1:numel(M)-1;%
Y = 0:1:100;
X = zeros(1,101);
figure(1)
plot(Time*0.1,M) %each timestep is 2 hour
disp(M)
hold on
%xlim([0,3000])
%ylim([0,60])

%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Fraction methylated')
hold off
%%%%%%%%%%%%%%%%%%%%%
figure(2)
hold on
plot(Time*0.1,M)
%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-black','LineWidth',0.1)
end
xlim([33,47])
%ylim([0,60])
xlabel('Time (hours)')
ylabel('Fraction methylated')
hold off