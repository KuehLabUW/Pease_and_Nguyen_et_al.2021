clear
filenameC = 'Tr50RawDivideCompCompacAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
filenameM = 'Tr50RawDivideCompMethylAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
M = csvread(filenameC);
Time = 0:1:numel(M)-1;%
Y = 0:1:100;
X = zeros(1,101);
figure(1)
%%%
filter = 30000;
T = Time(1:filter:end)*0.00001;
Compact = M(1:filter:end)./50;
plot(T,Compact)
%%%
%plot(Time*0.00001,M./50) %each timestep is 0.1 hour

disp(M)
hold on
xlim([0,200])
%xlim([19.998,20.004])
ylim([0,1])

%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Fraction nucleosome in compacted state')
hold off
%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%
M1 = csvread(filenameM);
Time = 0:1:numel(M1)-1;%
figure(3)
hold on
%%%
filter = 10000;
T = Time(1:filter:end)*0.00001;
Methyl = M1(1:filter:end)./50;
plot(T,Methyl)
%%%
%plot(Time*0.00001,M1./50) %each timestep is 2 hour
disp(M1)
xlim([0,200])
ylim([0,0.5])
%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Fraction methylated')
