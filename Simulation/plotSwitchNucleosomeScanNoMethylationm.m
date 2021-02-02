clear
AlphaOFF = 8;
alphas = 1;
NT = [0,5,10,15,20];
SwitchRate = [];
for i = 1:numel(NT)
    GoodM = [];
    filename = 'TF%dTrun50F0.825LifeTimePhaseAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
    filename = sprintf(filename,NT(i));
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
end
figure(1)
hold on
scatter((NT),1./(SwitchRate))
plot((NT),1./(SwitchRate))
ylabel('Mean activation time')
xlabel('Number of removed nucleosome')



