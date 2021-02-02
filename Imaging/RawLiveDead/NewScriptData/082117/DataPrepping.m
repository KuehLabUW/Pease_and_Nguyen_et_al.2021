clear
cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\082117')
load('NewScriptCellCFP.mat')
outdir = 'C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\082117\';
DataMatrix = [];
k = 1;
for i= 1:numel(objects)
    for j= 1:numel(objects(i).obj)
      DataMatrix(k,1) = objects(i).obj(j).data.LiveDead;
      DataMatrix(k,2) = objects(i).obj(j).data.GeneralArea;
      DataMatrix(k,3) = objects(i).obj(j).data.GeneralPerimeter;
      DataMatrix(k,4) = objects(i).obj(j).data.logCFP;
      DataMatrix(k,5) = objects(i).obj(j).data.Cutoffpunctaarea;
      DataMatrix(k,6) = objects(i).obj(j).data.LapacianPunctaNumber;
      DataMatrix(k,7) = objects(i).obj(j).data.LapacianMeanPunctaArea;
      DataMatrix(k,8) = objects(i).obj(j).data.LapacianMeanPunctaPerimeter;
      k = k+1;
    end
end
save([outdir '082117CellforTree.mat'],'DataMatrix')
      
      
      
      
      