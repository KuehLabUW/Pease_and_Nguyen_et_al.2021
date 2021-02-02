clear
filename = '%dMCu%dCompTF1500Trun446F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON315DeltaOFF5300Cycle20.csv';
                                                                                         
%get the rest TF
TFmeanTotal = [];
for MCu = 0:1:5
    TFtotal = [];
    for rep = 1:1:20
        tffilename = sprintf(filename,rep,MCu);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end
mean_total = [TFmeanTotal];
TF_list = 0:1:5;

plot(TF_list,1./mean_total)
hold on
%[fitresult, gof] = fitMM(TF_list', 1./mean_total');
%plot(fitresult)