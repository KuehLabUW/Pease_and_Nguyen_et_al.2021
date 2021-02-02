cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\082117 - processed')
load('RoundCells_FebcMyc082117.mat')

tree =struct();
GateNumber = 1;
for i= 1:numel(objects)
    a = [];
    for j= 1:numel(objects(i).obj)
        if objects(i).obj(j).gate == GateNumber
            a = [a objects(i).obj(j).data.logYFP];            
        end
    tree(i).cell = a;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%
ON = [];
OFF = [];
Time = linspace(1,numel(tree),numel(tree));
for i = 1:numel(tree)
    ONcount = 0;
    OFFcount = 0;
    for j = 1:numel(tree(i).cell)
        if tree(i).cell(j) > 1
            if tree(i).cell(j) > 3.9
                ONcount = ONcount + 1;
            else
                OFFcount = OFFcount + 1;
            end
        end
    end
    ON = [ON ONcount];
    OFF = [OFF OFFcount];
end
RealTime = Time * 1.03;
%figure
cMyc1 = ON./(ON+OFF);
%plot(RealTime,a)
%axis([0*1.03 numel(objects)*1.03 0 1])
%xlabel('Time (hours)')
%ylabel('Fraction ON')

        
