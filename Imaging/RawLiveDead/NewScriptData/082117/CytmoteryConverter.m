cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData')
outdir = 'C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\082117\';
TimePoints = [10 20 30 40 50 60 70 80 90 98];
Positions  = [71 215 63 219 247 456 598 567 548 447];


for j = 1:numel(TimePoints)
    a = [];
    for i = 1:numel(Positions)
        load(['082117Pos' num2str(Positions(i)) 'T' num2str(TimePoints(j)) '.mat'])
        a = [a Cell];
        %objects(j).obj.data = [objects(j).obj.data Cell];
        for k = 1: numel(a)
            obj(k).data = a(k);
            obj(k).data.logCFP = log(obj(k).data.GeneralMeanIntensity);
            obj(k).trno = 10;
            obj(k).x = 10;
            obj(k).y = 10;
            obj(k).gate = 0;
        end   
    end
    objects(j).obj = obj;
   
        
    
end

save([outdir 'NewScriptCellCFP.mat'],'objects') 
cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\082117')