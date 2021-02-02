clear
cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\111617')
load('NewScriptCellEV.mat')

LiveI = [];
DeadI = [];
LiveII = [];
DeadII = [];

for i= 1 : numel(objects)
    LI = 0;
    LII = 0;
    DI = 0;
    DII = 0;
    for j = 1 : numel(objects(i).obj)
        if objects(i).obj(j).data.LapacianMeanPunctaPerimeter < 75 && objects(i).obj(j).data.LapacianMeanPunctaArea < 200
            if objects(i).obj(j).data.LiveDead == 1
                LI = LI + 1;
            else
                DI = DI +1;
            end
        else
            if objects(i).obj(j).data.LiveDead == 1
                LII = LII + 1;
            else
                DII = DII +1;
            end
        end
    end
    LiveI = [LiveI LI];
    LiveII = [LiveII LII];
    DeadI = [DeadI DI];
    DeadII = [DeadII DII];
end

DeadFractionI = DeadI./(DeadI + DeadII);
LiveFractionI = LiveI./(LiveI + LiveII);

DeadFractionII = DeadII./(DeadI + DeadII);
LiveFractionII = LiveII./(LiveI + LiveII);

Time = 1:numel(objects);
figure(1)
scatter(Time,DeadFractionI,'b');
hold on
scatter(Time,LiveFractionI,'r');
scatter(Time,DeadI,'g');
hold off

figure(2)
scatter(Time,DeadFractionII,'b');
hold on
scatter(Time,LiveFractionII,'r');
hold off


    
            
                