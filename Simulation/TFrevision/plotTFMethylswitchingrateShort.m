clear

zerofilename = '%dMCu0MethylTF1500Trun50F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON295DeltaOFF5300Cycle20.csv';
TF1filename = '%dMCu5MethylTF%dTrun50F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON295DeltaOFF5300Cycle20.csv';
TF2filename ='%dMCu15MethylTF%dTrun50F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON295DeltaOFF5300Cycle20.csv';
TF3filename = '%dMCu25MethylTF%dTrun50F0.825LifeTimePhaseKon1Koff5AlphaON6.4AlphaOFF8LambdaON295DeltaOFF5300Cycle20.csv';

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
for tf = 5
    TFtotal = [];
    for rep = 1:1:16
        tffilename = sprintf(TF1filename,rep,tf);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end


for tf = [10:5:35]
    TFtotal = [];
    for rep = 1:1:24
        tffilename = sprintf(TF1filename,rep,tf);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end
mean_total = [mean_zero TFmeanTotal];
TF_list = [0,5:5:35];

scatter(TF_list,1./mean_total)
[fitresult1, gof1] = fitMMnonzero(TF_list', 1./mean_total');
hold on
plot(fitresult1)
ylim([0,0.03])

%keyboard
%get the rest TF MCu = 15
TFmeanTotal = [];
for tf = [5:5:35]
    TFtotal = [];
    for rep = 1:1:24
        tffilename = sprintf(TF2filename,rep,tf);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end
mean_total = [mean_zero TFmeanTotal];
TF_list = [0,5:5:35];

scatter(TF_list,1./mean_total)
[fitresult2, gof2] = fitMMnonzero(TF_list', 1./mean_total');
hold on
plot(fitresult2)

%get the rest TF MCu = 25
TFmeanTotal = [];
for tf = [5:5:35]
    TFtotal = [];
    for rep = 1:1:24
        tffilename = sprintf(TF3filename,rep,tf);
        A = csvread(tffilename);
        TFtotal = [TFtotal A];
    end
    TFmeanTotal = [TFmeanTotal mean(TFtotal)];
end
mean_total = [mean_zero TFmeanTotal];
TF_list = [0,5:5:35];

scatter(TF_list,1./mean_total)
[fitresult3, gof3] = fitMMnonzero(TF_list', 1./mean_total');
hold on
plot(fitresult3)



%% plot K 1/2 Vmax
figure()
bar([5,15,25],[fitresult1.Kt,fitresult2.Kt,fitresult3.Kt])
errhigh = [17.2-7.9,7.1-4.4,6.96-4.55];
errlow  = [7.9-(-1.5),4.4-1.7,4.55-2.14];
hold on
er = errorbar([5,15,25],[fitresult1.Kt,fitresult2.Kt,fitresult3.Kt],errhigh,errlow);
er.LineStyle = 'none'; 
hold off
figure()
bar([5,15,25],[fitresult1.Vmax,fitresult2.Vmax,fitresult3.Vmax])
errhigh = [0.0032-0.0024,0.010-0.00966,0.0243-0.022];
errlow  = [0.0024-0.0015,0.00966-0.008391,0.022-0.019];
hold on
er = errorbar([5,15,25],[fitresult1.Vmax,fitresult2.Vmax,fitresult3.Vmax],errhigh,errlow);
er.LineStyle = 'none'; 
hold off