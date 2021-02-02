clear
AlphaOFF = 8;
alphas = ["0.2","0.4","0.8","1.6","3.2","6.4"];
alphasN = [0.2,0.4,0.8,1.6,3.2,6.4];
AlphaRatio = alphasN./(AlphaOFF);
MeanFMethyl = (50./(1+AlphaOFF./alphasN))./50;
SwitchRate = [];
AverageSwitchTime = [];
for i = 1:numel(alphas)
    GoodM = [];
    filename = 'Trun50F0.825LifeTimePhaseAlphaON%sAlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
    filename = sprintf(filename,alphas(i));
    disp(filename)
    M = csvread(filename);
    for j = 1:numel(M)
        if M(j)< 19999.9
            GoodM = [GoodM M(j)];
        end
    end
    %histogram(GoodM)
    GoodM = 1/mean(GoodM);
    SwitchRate = [SwitchRate GoodM];
    AverageSwitchTime = [AverageSwitchTime 1/GoodM];
end
figure(1)
hold on
scatter((AlphaRatio),(SwitchRate))
plot((AlphaRatio),(SwitchRate))
ylabel('switch rate')
xlabel('alphaON/alphaOFF')

%figure(2)
%hold on
%scatter(log10(MeanFMethyl),log10(SwitchRate))
%plot(log10(MeanFMethyl),log10(SwitchRate))
%ylabel('log10(switch rate)')
%xlabel('log10(average methylation state)')

%figure(3)
%hold on
%scatter(log10(MeanFMethyl),log10(AverageSwitchTime))
%plot(log10(MeanFMethyl),log10(AverageSwitchTime))
%ylabel('log10(Average Switching Time (hrs) )')
%xlabel('log10(average methylation state)')

figure(5)
hold on
scatter(AlphaRatio,AverageSwitchTime)
plot(AlphaRatio,AverageSwitchTime)
ylabel('Average Switching Time (hrs)')
xlabel('AlphaON/AlphaOFF')

[fit gof] = fitLinear(log10(AlphaRatio(2:end)'),log10(AverageSwitchTime(2:end)'));
figure(6)
hold on
scatter(log10(AlphaRatio),log10(AverageSwitchTime))
plot(log10(AlphaRatio),log10(AverageSwitchTime))
plot(fit)