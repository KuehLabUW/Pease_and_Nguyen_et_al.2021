CFPlow = struct();
CFPmid = struct();
CFPhigh = struct();
for i = 1:numel(objects)
    low = [];
    mid = [];
    high = [];
    for j = 1:numel(objects(i).obj)
        if objects(i).obj(j).data.logCFP <= 5.25
            low = [low objects(i).obj(j).data.logYFP];
        end
        if 5.25 < objects(i).obj(j).data.logCFP <= 6.0
            mid = [mid objects(i).obj(j).data.logYFP];
        end
        if objects(i).obj(j).data.logCFP > 6.0
            high = [high objects(i).obj(j).data.logYFP];
        end
    end
    CFPlow(i).YFP = low;
    CFPmid(i).YFP = mid;
    CFPhigh(i).YFP = high;
end

%%%%%%%%%%%%%%%make histogram on each CFP population
datalow = [];
datamid = [];
datahigh = [];

for i = 1:numel(objects)
    datalow = [datalow CFPlow(i).YFP];
    datamid = [datamid CFPmid(i).YFP];
    datahigh = [datahigh CFPhigh(i).YFP];
end
figure
histogram(datalow,10000)
axis([0 6 0 100])
figure
histogram(datamid,10000)
axis([0 6 0 1000])
figure
histogram(datahigh,10000)
axis([0 6 0 100])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
Time = linspace(1,numel(objects),numel(objects));    
RealTime = Time * 0.5;    
    
P1 = PlotPercentONFunction(CFPlow,4.1);
P2 = PlotPercentONFunction(CFPmid,4.1);
P3 = PlotPercentONFunction(CFPhigh,4.1);

figure
plot(RealTime,P1)
hold on
plot(RealTime,P2)
plot(RealTime,P3)
axis([0*0.5 numel(objects)*0.5 0 1])
xlabel('Time (hours)')
ylabel('Fraction ON')
legend('CFPlow','CFPmid','CFPhigh')
hold off
                


            
            
        
