cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData')
outdir = 'C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\111617\';
TimePoints = [15 25 35 45 55 65 75 85 95 105];
Positions  = [19 35 109 142 24 170 200 179 269 271];

%Positions  = [170 200 179 269 271];



for j = 1:numel(TimePoints)
    a = [];
    for i = 1:numel(Positions)
        load(['111617Pos' num2str(Positions(i)) 'T' num2str(TimePoints(j)) '.mat'])
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
cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\111617')