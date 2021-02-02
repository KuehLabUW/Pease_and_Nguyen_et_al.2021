clear

zerofilename = '%dMCu0MethylTF1500Trun50F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON295DeltaOFF5300Cycle20.csv';
TF1filename = '%dMCu5MethylTF%dTrun50F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON295DeltaOFF5300Cycle20.csv';
TF2filename ='%dMCu10MethylTF%dTrun50F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON295DeltaOFF5300Cycle20.csv';
TF3filename = '%dMCu15MethylTF%dTrun50F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON295DeltaOFF5300Cycle20.csv';
TF4filename = '%dMCu20MethylTF%dTrun50F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON295DeltaOFF5300Cycle20.csv';
TF5filename = '%dMCu25MethylTF%dTrun50F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON295DeltaOFF5300Cycle20.csv';
%get the 'zero' TF
total_zero = [];
for i = 1:8
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
        tffilename = sprintf(TF1filename,rep,tf);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end
mean_total = [mean_zero TFmeanTotal];
TF_list = [0,5:5:40,50,60,70,80,100];

scatter(TF_list,1./mean_total)
[fitresult1, gof] = fitMMnonzero(TF_list', 1./mean_total');
hold on
plot(fitresult1)

%keyboard
%get the rest TF MCu = 10
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
[fitresult2, gof1] = fitMMnonzero(TF_list', 1./mean_total');
hold on
plot(fitresult2)

%get the rest TF MCu = 15
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
[fitresult3, gof2] = fitMMnonzero(TF_list', 1./mean_total');
hold on
plot(fitresult3)

%get the rest TF MCu = 20
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
[fitresult4, gof] = fitMMnonzero(TF_list', 1./mean_total');
hold on
plot(fitresult4)
legend off

%get the rest TF MCu = 25
TFmeanTotal = [];
for tf = [5:5:40,50,60,70,80,100]
    TFtotal = [];
    for rep = 1:1:8
        tffilename = sprintf(TF5filename,rep,tf);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end
mean_total = [mean_zero TFmeanTotal];
TF_list = [0,5:5:40,50,60,70,80,100];

scatter(TF_list,1./mean_total)
[fitresult5, gof] = fitMMnonzero(TF_list', 1./mean_total');
hold on
plot(fitresult5)
legend off

%% plot K 1/2 Vmax
figure()
plot([5,10,15,20,25],[fitresult1.Kt,fitresult2.Kt,fitresult3.Kt,fitresult4.Kt,fitresult5.Kt])
figure()
plot([5,10,15,20,25],[fitresult1.Vmax,fitresult2.Vmax,fitresult3.Vmax,fitresult4.Vmax,fitresult5.Vmax]+0.006)