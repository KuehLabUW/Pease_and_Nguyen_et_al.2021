filename = 'LifeTimeAlpha0.038Beta0.0021Cycle400Rigorous1.csv';
M = csvread(filename);
%%%% convert to real time (1 time unit = 2.5 min)
M = 2.5*(1/60)*M;
GoodData = [];
for i= 1:numel(M)
    if M(i) <= 800
        GoodData = [GoodData M(i)];
    end
end 
figure(1)
h = histogram(GoodData,0:1:60,'normalization','probability');
xlabel('time (hours)');
ylabel('fraction ON')
xlim([0,60])
title('Probability Distribution Fuction')
figure(2)
ecdf(GoodData)
xlabel('time (hours)');
ylabel('culmulative fraction ON')
xlim([0,90])
ylim([0,1])
%%%%%%%%%%%%%%%%%%%%


