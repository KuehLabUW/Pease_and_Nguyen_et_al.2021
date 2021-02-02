Cycles = [4 10 14 20 24 30 34 40];
SwitchCycle = [];
SwitchEnzyme = [];
for i = 1:numel(Cycles)
    filename = 'LifeTimeAlpha0Beta0Cycle%dT.csv';
    filename = sprintf(filename,Cycles(i));
    
    M = csvread(filename);
    M = 1/mean(M);
    SwitchCycle = [SwitchCycle M];
end
for i = 1:numel(Cycles)
    filename = 'LifeTimeAlpha17.4Beta0.426Cycle%dT.csv';
    filename = sprintf(filename,Cycles(i));
    M = csvread(filename);
    M = 1/mean(M);
    SwitchEnzyme = [SwitchEnzyme M];
end
figure(1)
hold on
scatter(Cycles(3:end),SwitchCycle(3:end))
scatter(Cycles(3:end),SwitchEnzyme(3:end))
%ylim([0,0.05])
hold off
figure(2)
divisionRate = 1./Cycles;
hold on
scatter(divisionRate(3:end),SwitchCycle(3:end))
scatter(divisionRate(3:end),SwitchEnzyme(3:end))
hold off
figure(3)
hold on
FoldChangeDivRate = [0.0333 0.0417 0.0500 0.0714]./0.0333;
FoldChangeSwitchCycle = [0.0041 0.0052 0.0062 0.0088]./0.0041;
FoldChangeSwitchEnzyme = [0.0114 0.0121 0.0121 0.0135]./0.0114;
[L1 gof] = fitLinear(FoldChangeDivRate',FoldChangeSwitchCycle');
[L2 gof] = fitLinear(FoldChangeDivRate',FoldChangeSwitchEnzyme');
plot(1:0.1:2.5,L1(1:0.1:2.5))
plot(1:0.1:2.5,L2(1:0.1:2.5))
xlim([1,2.5])
scatter(FoldChangeDivRate,FoldChangeSwitchCycle)
scatter(FoldChangeDivRate,FoldChangeSwitchEnzyme)
hold off