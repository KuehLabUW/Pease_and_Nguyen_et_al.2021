clear
AlphaOFF = 8;
Cycles = ["10","15","20","25","30","35"];
CyclesN = [10,15,20,25,30,35];

SwitchRate = [];
for i = 1:numel(Cycles)
    GoodM = [];
    %filename = 'Trun50F0.825LifeTimePhaseAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle%s.csv';
    filename = 'Trun50F0.825LifeTimePhaseAlphaON0AlphaOFF0LambdaON310DeltaOFF5300Cycle%s.csv';
    filename = sprintf(filename,Cycles(i));
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
scatter(CyclesN,1./SwitchRate)
plot(CyclesN,1./SwitchRate)
ylabel('Average activation time (hours)')
xlabel('Cell cycle length (hours)')


