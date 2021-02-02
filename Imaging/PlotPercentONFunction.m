function P = PlotPercentONFunction(data,logCutOff)
    ON = [];
    OFF = [];
    Time = linspace(1,numel(data),numel(data));
    for i= 1:numel(data)
        ONcount = 0;
        OFFcount = 0;
        index = data(i).YFP;
        for j= 1:numel(index)
            if index(j) > 1
                if index(j) > logCutOff
                    ONcount = ONcount + 1;
                else
                    OFFcount = OFFcount +1;
                end
            end
        end
    ON = [ON ONcount];
    OFF = [OFF OFFcount];
    end
    
    P = (ON./(ON+OFF));
    %RealTime = Time * 0.5;
    %figure
    %plot(RealTime,(ON./(ON+OFF)))
    %axis([0*0.5 numel(data)*0.5 0 1])
    %xlabel('Time (hours)')
    %ylabel('Fraction ON')
end

        


