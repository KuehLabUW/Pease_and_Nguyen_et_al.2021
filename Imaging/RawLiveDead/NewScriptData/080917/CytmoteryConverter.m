cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData')
outdir = 'C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\080917\';
TimePoints = [20 40 60 80 100 120 140 160 200];
Positions  = [140 156 145 240 255 194 293 367 314 277 323];

%Positions  = [140 156 145 240 255 194];



for j = 1:numel(TimePoints)
    a = [];
    for i = 1:numel(Positions)
        load(['080917Pos' num2str(Positions(i)) 'T' num2str(TimePoints(j)) '.mat'])
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
cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\080917')