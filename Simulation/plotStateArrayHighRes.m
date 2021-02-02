clear
filename = 'HighResRawAlpha16.5Beta1Cycle20.csv';
M = csvread(filename);
Time = 0:1:numel(M)-1;%
Y = 0:1:100;
X = zeros(1,101);
figure(1)
%%%
filter = 50;
T = Time(1:filter:end)*0.001;
Methyl = M(1:filter:end);
plot(T,Methyl)
%%%
%plot(Time*0.001,M) %each timestep is 2 hour
disp(M)
hold on
xlim([0,150])
ylim([0,70])

%plot cell division divider
for i = 1:150
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Fraction methylated')
%hold off
%%%%%%%%%%%%%%%%%%%%%
figure(2)
hold on
%plot(Time*0.001,M)
%plot cell division divider
for i = 1:100
    %plot(X+(i*20),Y,'-black','LineWidth',0.1)
end
xlim([39.9,40.5])
ylim([0,70])
xlabel('Time (hours)')
ylabel('Fraction methylated')
hold off