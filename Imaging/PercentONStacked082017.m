cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\082117 - processed')
load('RoundCells_Julyp21082117.mat')

Time =struct();
TimeStack =struct();
%%%%%%%%%%%%
GateNumber = 1;
for i= 1:numel(objects)
    a = [];
    b = [];
    for j= 1:numel(objects(i).obj)
        if objects(i).obj(j).gate == GateNumber
            if objects(i).obj(j).data.logYFP > 1
                a = [a objects(i).obj(j).data.logYFP];
                b = [b objects(i).obj(j).data.logRFP];
            end

        end
    Time(i).logYFP = a;
    Time(i).logRFP = b;
    
    end
end
%%%%%%%%%%%%%%
S = linspace(1,9,9);
for i= 1:numel(S)
    c = [];
    d = [];
    for j = (i*10-9):(i*10)
        c = [c Time(j).logYFP];
        d = [d Time(j).logRFP];
    end
    TimeStack(i).logYFP = c;
    TimeStack(i).logRFP = d;
end

for i= 1:9
   figure 
   scatter(TimeStack(i).logYFP,TimeStack(i).logRFP)
   xlim([0,5])
   ylim([0,5])
       
end











