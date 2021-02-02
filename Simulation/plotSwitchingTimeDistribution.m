clear
filename = '20Trun50F0.825LifeTimePhaseAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
M = csvread(filename);
GoodData = [];
for i= 1:numel(M)
    if 2< M(i) < 19998
        GoodData = [GoodData M(i)];
    end
end 
figure(1)
hold on
h = histogram(GoodData,15,'normalization','probability');
BinCenters = (h.BinEdges(2)-h.BinEdges(1))/2:h.BinWidth:(h.BinEdges(end)-h.BinWidth/2);
[exp gof] = fitExponential(BinCenters',h.Values');
plot(exp)
xlim([0,500])
xlabel('time (hours)');
ylabel('fraction ON');
hold off
%xlim([0,60])
title('Probability Distribution Fuction')
figure(2)
ecdf(GoodData)
xlabel('time (hours)');
ylabel('cummulative fraction on')
xlim([0,60])
%ylim([0,1])
%%%%%%%%%%%%%%%%%%%%