clear
BetaON = 1;
AlphaOFF = ["16","17.0","17.5"];
alphasOFF = [16,17,17.5];
Ratio = BetaON./(alphasOFF);
SwitchRate = [];
AverageSwitchTime = [];
for i = 1:numel(AlphaOFF)
    GoodM = [];
    filename = 'LifeTimeAlpha%sBeta1Cycle20.csv';
    filename = sprintf(filename,AlphaOFF(i));
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
scatter((Ratio),(SwitchRate))
plot((Ratio),(SwitchRate))
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
scatter(Ratio,AverageSwitchTime)
plot(Ratio,AverageSwitchTime)
ylabel('Average Switching Time (hrs)')
xlabel('AlphaON/AlphaOFF')

[fit gof] = fitLinear(log10(Ratio(1:end)'),log10(AverageSwitchTime(1:end)'));
%plot(fit)