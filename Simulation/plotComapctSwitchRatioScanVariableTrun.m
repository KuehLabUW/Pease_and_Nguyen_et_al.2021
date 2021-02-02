clear
Truns = ["48","50","52"];
for tr = 1:numel(Truns)
    AlphaOFF = 8;
    alphas = ["0.4","0.8","1.6","3.2"];
    alphasN = [0.4,0.8,1.6,3.2];
    AlphaRatio = alphasN./(AlphaOFF);
    MeanFMethyl = (50./(1+AlphaOFF./alphasN))./50;
    SwitchRate = [];
    AverageSwitchTime = [];
    for i = 1:numel(alphas)
        GoodM = [];
        filename = 'Trun%sF0.825LifeTimePhaseAlphaON%sAlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
        filename = sprintf(filename,Truns(tr),alphas(i));
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
    scatter(AlphaRatio,AverageSwitchTime)
    plot(AlphaRatio,AverageSwitchTime)
    ylabel('Average Switching Time (hrs)')
    xlabel('AlphaON/AlphaOFF')
end




%[fit gof] = fitLinear(log10(AlphaRatio(2:end)'),log10(AverageSwitchTime(2:end)'));
%figure(6)
%hold on
%scatter(log10(AlphaRatio),log10(AverageSwitchTime))
%plot(log10(AlphaRatio),log10(AverageSwitchTime))
%plot(fit)