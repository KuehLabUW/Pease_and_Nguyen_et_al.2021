clear
%% get methylation and switching rate for the Old Model
BetaON = 1;
AlphaOFF = ["16","17.0","17.5"];
alphasOFF = [16,17,17.5];

%get switching rate
SwitchRateOld = [];
AverageSwitchTimeOld = [];
for i = 1:numel(AlphaOFF)
    GoodM = [];
    filename = 'LifeTimeAlpha%sBeta1Cycle20.csv';
    filename = sprintf(filename,AlphaOFF(i));
    disp(filename)
    M = csvread(filename);
    for j = 1:numel(M)
        if M(j)< 19999.9
            GoodM = [GoodM M(j)];
        end
    end
    %histogram(GoodM)
    GoodM = 1/mean(GoodM);
    SwitchRateOld = [SwitchRateOld GoodM];
    AverageSwitchTimeOld = [AverageSwitchTimeOld 1/GoodM];
end
%get average methylation level
MethylStateOld = [];
for i = 1:numel(AlphaOFF)
    
    filename = 'HighResRawAlpha%sBeta1Cycle20short.csv';
    filename = sprintf(filename,AlphaOFF(i));
    disp(filename)
    M = csvread(filename);
    for k = 1:numel(M)
        if M(k) == 0
            break
        end
    end
    MethylStateOld = [MethylStateOld mean(M(1:k))];
end
%get all possible datapoint pairs
MethylOldpairs = nchoosek(MethylStateOld,2);
AverageSwitchTimeOldpairs = nchoosek(AverageSwitchTimeOld,2);
MeanSensOld = [];
for k = 1:length(MethylOldpairs)
    Methylratio = (MethylOldpairs(k,1) - MethylOldpairs(k,2))/MethylOldpairs(k,2);
    AverageSwitchTimeratio = (AverageSwitchTimeOldpairs(k,1) - AverageSwitchTimeOldpairs(k,2))/AverageSwitchTimeOldpairs(k,2);
    MeanSensOld = [MeanSensOld AverageSwitchTimeratio/Methylratio];
end

MeanSensOld = mean(MeanSensOld);

%% get methylation and switching rate for the New model
AlphaOFF = 8;
alphas = ["0.2","0.4","0.8","1.6","3.2","6.4"];
alphasN = [0.2,0.4,0.8,1.6,3.2,6.4];
AlphaRatio = alphasN./(AlphaOFF);
MeanFMethyl = (100./(1+AlphaOFF./alphasN))./100;
MeanMethyl = MeanFMethyl.*50;
SwitchRate = [];
AverageSwitchTime = [];
for i = 1:numel(alphas)
    GoodM = [];
    filename = 'TrunF0.9LifeTimePhaseAlphaON%sAlphaOFF8LambdaON102DeltaOFF5300Cycle20.csv';
    filename = sprintf(filename,alphas(i));
    disp(filename)
    M = csvread(filename);
    for j = 1:numel(M)
        if M(j)< 19999.9
            GoodM = [GoodM M(j)];
        end
    end
    %histogram(GoodM)
    GoodM = 1/mean(GoodM);
    SwitchRate = [SwitchRate GoodM];
    AverageSwitchTime = [AverageSwitchTime 1/GoodM];
end

%get all possible datapoint pairs
Methylpairs = nchoosek(MeanMethyl,2);
AverageSwitchTimepairs = nchoosek(AverageSwitchTime,2);
MeanSens = [];
%keyboard
for k = 1:length(Methylpairs)
    Methylratio = (Methylpairs(k,2) - Methylpairs(k,1))/Methylpairs(k,1);
    AverageSwitchTimeratio = (AverageSwitchTimepairs(k,2) - AverageSwitchTimepairs(k,1))/AverageSwitchTimepairs(k,1);
    MeanSens = [MeanSens AverageSwitchTimeratio/Methylratio];
end

MeanSens = mean(MeanSens);
%% plot scatterplot methylation fraction vs switching rate
MethylStateOldF = MethylStateOld/100;
MethylStateF = MeanMethyl/50;
figure(2)
plot(MethylStateOldF,AverageSwitchTimeOld)
hold on
plot(MethylStateF,AverageSwitchTime)

%% get sensitivity data from experiment
M_dmso = 1;
T_dmso = 1/0.021;
M_gskj4 = 1.38;
T_gskj4 = 1/0.017;
M_unc1999 = 0.399;
T_unc1999 = 1/0.031;

RM_gskj4 = (M_gskj4 - M_dmso)/M_dmso;
RT_gskj4 = (T_gskj4 - T_dmso)/T_dmso;
S_gskj4 = RT_gskj4/RM_gskj4;

RM_unc1999 = (M_dmso-M_unc1999)/M_unc1999;
RT_unc1999 = (T_dmso-T_unc1999)/T_unc1999;
S_unc1999 = RT_unc1999/RM_unc1999;



