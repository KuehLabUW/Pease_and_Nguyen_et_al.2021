ON = [];
OFF = [];
Time = linspace(1,numel(objects),numel(objects));
for i = 1:numel(objects)
    ONcount = 0;
    OFFcount = 0;
    for j = 1:numel(objects(i).obj)
        if objects(i).obj(j).data.logYFP > 1
            if objects(i).obj(j).data.logYFP > 4.1
                ONcount = ONcount + 1;
            else
                OFFcount = OFFcount + 1;
            end
        end
    end
    ON = [ON ONcount];
    OFF = [OFF OFFcount];
end
RealTime = Time * 0.5
figure
plot(RealTime,(ON./(ON+OFF)))
axis([0*0.5 numel(objects)*0.5 0 1])
xlabel('Time (hours)')
ylabel('Fraction ON')

%%%%%Get Distribution Function
S = smooth(func,100)
figure
plot(RealTime,S)

func = ON./(ON+OFF);
Derivative = [];
for i = 2:numel(func)
    d = (S(i)-S(i-1))/0.5;
    Derivative = [Derivative d];
end

DerivTime = linspace(2,numel(objects),numel(objects)-1);
RealDerivTime = DerivTime*0.5
figure
plot(RealDerivTime,Derivative)
figure
hold on

plotyy(RealTime,(ON./(ON+OFF)),RealDerivTime,Derivative)
hold off
%%%%%%%%%%%%
figure
plot(RealTime,(OFF./(ON+OFF)))



