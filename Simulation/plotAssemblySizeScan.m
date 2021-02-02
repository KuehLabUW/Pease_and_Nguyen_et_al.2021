clear
AlphaOFF = 8;
alphas = ["0.2","0.4","0.6","0.8"];
alphasN = [0.2,0.4,0.6,0.8];
AlphaRatio = alphasN./(AlphaOFF);
MeanFMethyl = (100./(1+AlphaOFF./alphasN))./100;
SwitchRate = [];
for i = 1:numel(alphas)
    GoodM = [];
    filename = 'Trun50F0.825AssemblySizePhaseAlphaON%sAlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
    filename = sprintf(filename,alphas(i));
    disp(filename)
    M = csvread(filename);
    for j = 1:numel(M)
        if M(j)< 19999.9
            GoodM = [GoodM M(j)];
        end
    end
    %histogram(GoodM)
    GoodM = mean(GoodM);
    SwitchRate = [SwitchRate GoodM];
end
figure(1)
hold on
scatter(log10(AlphaRatio),SwitchRate)
plot(log10(AlphaRatio),SwitchRate)
ylabel('Assembly Size')
xlabel('log10(alphaON/alphaOFF)')

figure(2)
hold on
scatter(log10(MeanFMethyl),SwitchRate)
plot(log10(MeanFMethyl),SwitchRate)
ylabel('Assembly Size')
xlabel('log10(average methylation state)')


