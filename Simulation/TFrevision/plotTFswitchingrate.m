clear
zerofilename = '%dMCu5CompTF0Trun446F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON315DeltaOFF5300Cycle20.csv';
TFfilename = '%dMCu5CompTF%dTrun446F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON315DeltaOFF5300Cycle20.csv';
TF1filename ='%dMCu1CompTF%dTrun446F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON315DeltaOFF5300Cycle20.csv';
TF2filename = '%dMCu2CompTF%dTrun446F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON315DeltaOFF5300Cycle20.csv';
TF3filename = '%dMCu3CompTF%dTrun446F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON315DeltaOFF5300Cycle20.csv';
TF4filename = '%dMCu4CompTF%dTrun446F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON315DeltaOFF5300Cycle20.csv';
%get the 'zero' TF
total_zero = [];
for i = 1:20
    zero = sprintf(zerofilename,i);
    A = csvread(zero);
    total_zero = [total_zero A];
    %keyboard
end
mean_zero = mean(total_zero);
                                                                                                                          
%get the rest TF MCu = 5
TFmeanTotal = [];
for tf = [5:5:40,50,60,70,80,100]
    TFtotal = [];
    for rep = 1:1:8
        tffilename = sprintf(TFfilename,rep,tf);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end
mean_total = [mean_zero TFmeanTotal];
TF_list = [0,5:5:40,50,60,70,80,100];

scatter(TF_list,1./mean_total)
[fitresult5, gof] = fitMM(TF_list', 1./mean_total');
hold on
plot(fitresult5)

%keyboard
%get the rest TF MCu = 1
TFmeanTotal = [];
for tf = [5:5:40,50,60,70,80,100]
    TFtotal = [];
    for rep = 1:1:8
        tffilename = sprintf(TF1filename,rep,tf);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end
mean_total = [mean_zero TFmeanTotal];
TF_list = [0,5:5:40,50,60,70,80,100];

scatter(TF_list,1./mean_total)
[fitresult1, gof1] = fitMM(TF_list', 1./mean_total');
hold on
plot(fitresult1)

%get the rest TF MCu = 2
TFmeanTotal = [];
for tf = [5:5:40,50,60,70,80,100]
    TFtotal = [];
    for rep = 1:1:8
        tffilename = sprintf(TF2filename,rep,tf);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end
mean_total = [mean_zero TFmeanTotal];
TF_list = [0,5:5:40,50,60,70,80,100];

scatter(TF_list,1./mean_total)
[fitresult2, gof2] = fitMM(TF_list', 1./mean_total');
hold on
plot(fitresult2)

%get the rest TF MCu = 3
TFmeanTotal = [];
for tf = [5:5:40,50,60,70,80,100]
    TFtotal = [];
    for rep = 1:1:8
        tffilename = sprintf(TF3filename,rep,tf);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end
mean_total = [mean_zero TFmeanTotal];
TF_list = [0,5:5:40,50,60,70,80,100];

scatter(TF_list,1./mean_total)
[fitresult3, gof] = fitMM(TF_list', 1./mean_total');
hold on
plot(fitresult3)
legend off

%get the rest TF MCu = 4
TFmeanTotal = [];
for tf = [5:5:40,50,60,70,80,100]
    TFtotal = [];
    for rep = 1:1:8
        tffilename = sprintf(TF4filename,rep,tf);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end
mean_total = [mean_zero TFmeanTotal];
TF_list = [0,5:5:40,50,60,70,80,100];

scatter(TF_list,1./mean_total)
[fitresult4, gof] = fitMM(TF_list', 1./mean_total');
hold on
plot(fitresult4)
legend off

%% plot K 1/2 Vmax
figure()
plot([1,2,3,4,5],[fitresult1.Kt,fitresult2.Kt,fitresult3.Kt,fitresult4.Kt,fitresult5.Kt])
figure()
plot([1,2,3,4,5],[fitresult1.Vmax,fitresult2.Vmax,fitresult3.Vmax,fitresult4.Vmax,fitresult5.Vmax])