clear
filenameDMSO = 'Trun50F0.825LifeTimePhaseAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
M = csvread(filenameDMSO);
GoodData = [];
for i= 1:numel(M)
    if 2< M(i) < 19998
        GoodData = [GoodData M(i)];
    end
end 
figure(1)
hold on
h = histogram(GoodData,8,'normalization','probability');
BinCenters = (h.BinEdges(2)-h.BinEdges(1))/2:h.BinWidth:(h.BinEdges(end)-h.BinWidth/2);
[expD gof] = fitExponential(BinCenters',h.Values');
plot(expD)
scatter(BinCenters,h.Values)
xlim([0,1000])
xlabel('time (hours)');
ylabel('fraction ON');
hold off
%%%%%%%%%%%%%%%%%%%%
filenameGSKJ4 = 'Trun50F0.825LifeTimePhaseAlphaON1AlphaOFF4LambdaON310DeltaOFF5300Cycle20.csv';
M = csvread(filenameGSKJ4);
GoodData = [];
for i= 1:numel(M)
    if 2< M(i) < 19998
        GoodData = [GoodData M(i)];
    end
end 
figure(1)
hold on
h = histogram(GoodData,8,'normalization','probability');
BinCenters = (h.BinEdges(2)-h.BinEdges(1))/2:h.BinWidth:(h.BinEdges(end)-h.BinWidth/2);
[expG gof] = fitExponential(BinCenters',h.Values');
scatter(BinCenters,h.Values)
plot(expG)
xlim([0,1000])
xlabel('time (hours)');
ylabel('fraction ON');
hold off
%%%%%%%%%%%%%%%%%%%
filenameUNC1999 = 'Trun50F0.825LifeTimePhaseAlphaON0.4AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
M = csvread(filenameUNC1999);
GoodData = [];
for i= 1:numel(M)
    if 2< M(i) < 19998
        GoodData = [GoodData M(i)];
    end
end 
figure(1)
hold on
h = histogram(GoodData,8,'normalization','probability');
BinCenters = (h.BinEdges(2)-h.BinEdges(1))/2:h.BinWidth:(h.BinEdges(end)-h.BinWidth/2);
[expU gof] = fitExponential(BinCenters',h.Values');
scatter(BinCenters,h.Values)
plot(expU)
xlim([0,1000])
xlabel('time (hours)');
ylabel('fraction ON');
hold off
%%%%%%%%%%%%%%%%%%%
filenameM_DMSO = 'Tr50RawMethylAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
M1 = csvread(filenameM_DMSO);
Time = 0:1:numel(M1)-1;%
figure(4)
hold on
plot(Time*0.1,(M1/50)*100) %each timestep is 2 hour
disp(M1)
Y = 0:1:100;
X = zeros(1,101);
xlim([0,200])
ylim([0,70])
%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Percent methylated (%)')
hold off
%%%%%%%%%%%%%%%%%%%
filenameM_GSKJ4 = 'Tr50RawMethylAlphaON1AlphaOFF4LambdaON310DeltaOFF5300Cycle20.csv';
M1 = csvread(filenameM_GSKJ4);
Time = 0:1:numel(M1)-1;%
figure(4)
hold on
plot(Time*0.1,(M1/50)*100) %each timestep is 2 hour
disp(M1)
Y = 0:1:100;
X = zeros(1,101);
xlim([0,200])
ylim([0,70])
%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Percent methylated (%)')
hold off
%%%%%%%%%%%%%%%%%%%
filenameM_UNC1999 = 'Tr50RawMethylAlphaON0.4AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';
M1 = csvread(filenameM_UNC1999);
Time = 0:1:numel(M1)-1;%
figure(4)
hold on
plot(Time*0.1,(M1/50)*100) %each timestep is 2 hour
disp(M1)
Y = 0:1:100;
X = zeros(1,101);
xlim([0,200])
ylim([0,70])
%plot cell division divider
for i = 1:100
    plot(X+(i*20),Y,'-green','LineWidth',0.01)
end
xlabel('Time (hours)')
ylabel('Percent methylated (%)')
hold off
%%%%%%%%%%%%%%%%%%%
figure(5)
c = categorical({'UTX/JMJDi','DMSO','PRC2i'});
switchslope = 1./[-expG.k -expD.k -expU.k];
bar(c,switchslope);

