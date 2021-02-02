clear
filenameC = '1Tr50RawDivideCompCompacAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
filenameM = '1Tr50RawDivideCompMethylAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
M = csvread(filenameC);
Time = 0:1:numel(M)-1;%
Y = 0:1:100;
X = zeros(1,101);
figure(1)
plot(Time*0.1,M./50) %each timestep is 0.1 hour
disp(M)
hold on
%xlim([0,100])
xlim([19.5,20.5])
ylim([0,1])

%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Fraction nucleosome in compacted state')

%%%%%%%%%%%%%%%%%%%%%
M1 = csvread(filenameM);
Time = 0:1:numel(M1)-1;%
figure(3)
hold on
plot(Time*0.1,M1./50) %each timestep is 2 hour
disp(M1)
xlim([0,100])
ylim([0,0.5])
%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Fraction methylated')
