clear
filenameC = 'HighResTr50RawCompacAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
filenameM = 'HighResTr50RawMethylAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';

%filenameC = 'Tr50RawCompacAlphaON0AlphaOFF0LambdaON310DeltaOFF5300Cycle20.csv';
%filenameM = 'Tr50RawMethylAlphaON0AlphaOFF0LambdaON310DeltaOFF5300Cycle20.csv';
M = csvread(filenameC);
Time = 0:1:numel(M)-1;%
Y = 0:1:100;
X = zeros(1,101);
figure(1)
%%%
filter = 100;
T = Time(1:filter:end)*0.001;
Compact = M(1:filter:end)./50;
plot(T,Compact*100)
%%%
%plot(Time*0.001,(M/50)*100) %each timestep is 0.1 hour
disp(M)
hold on
xlim([0,150])
ylim([0,100])

%plot cell division divider
for i = 1:150
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Percent nucleosome in compacted state (%)')
hold off
%%%%%%%%%%%%%%%%%%%%%
M1 = csvread(filenameM);
Time = 0:1:numel(M1)-1;%
figure(2)
hold on
%%%
filter = 1;
T = Time(1:filter:end)*0.001;
Methyl = M1(1:filter:end)./50;
plot(T,Methyl*100)
%%%
%plot(Time*0.001,(M1/50)*100) %each timestep is 2 hour
disp(M1)
%xlim([19.85,20.5])
xlim([0,145])
ylim([0,70])
%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Percent methylated (%)')
hold off

%% plot compaction vs methylation
%TotalData = horzcat((Time*0.1)',M/50,M1/50); %concatenate 2 arrays horizontally into matrix
m1 = ((M1/50)*100)';
m = ((M/50)*100)';
T = Time*0.001;
figure(3)
%hold on
scatter3(m(1:1000),m1(1:1000),T(1:1000))
ylabel('Percent methylated (%) ')
xlabel('Percent compacted (%) ')
zlabel('Time (hours) ')
%hold off


