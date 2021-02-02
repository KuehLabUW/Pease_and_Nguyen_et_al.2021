%This script tabulated all clearing and return rate for the 3 cell cycle
%experiments
load('FrameClearcMyc')
load('FrameClearEV')
%Plot return fraction - see 'Dead Cell Count_excel.xlsx' for detail
ReMeanEV = 0.538239538;
ReStdEV = 0.300301155;
ReNEV = 110;
ReMeancMyc = 0.618591618;
ReStdcMyc = 0.330994154;
ReNcMyc = 114;
ReZValue = 0.028;
figure(1)
hold on
c = categorical({'EV','cMyc'});
%bar(c,[ReMeanEV,ReMeancMyc])
%errorbar(c,[ReMeanEV,ReMeancMyc],[ReStdEV,ReStdcMyc],'.')
hold off

%Now fit and the clearance data
%Go to 'Dead Cell Count_excel.xlsx' and add the value for FrameClearEV and
%FrameClearcMyc

ClearEV = FrameClearEV*(30/60); % since each frame is per 30 min, convert to per hr
ClearcMyc = FrameClearcMyc*(30/60);
figure(2)
hold on
EV = histogram(ClearEV,5);
bincenterEV = ((EV.BinEdges(2)-EV.BinEdges(1))/2):EV.BinWidth:(EV.BinEdges(end));
ValueEV = EV.Values;
[EV gofev] = fitExponential(bincenterEV',ValueEV');
plot(EV)
xlim([0,45]);
hold off

figure(3)
hold on
cMyc = histogram(ClearcMyc,5);
bincentercMyc = ((cMyc.BinEdges(2)-cMyc.BinEdges(1))/2):cMyc.BinWidth:(cMyc.BinEdges(end));
ValuecMyc = cMyc.Values;
[cMyc gofcMyc] = fitExponential(bincentercMyc',ValuecMyc');
plot(cMyc)
xlim([0,45])
hold off

disp('EV apparent clearance rate per hour')
%disp(EV.k*(-1)*2)
disp(EV)
disp('cMyc apparent clearance rate per hour')
%disp(cMyc.k*(-1)*2)
disp(cMyc)

figure(4)
hold on
RateEV = EV.k*(-1);
ConfidentEV = 0.2434 - RateEV; 
RatecMyc = cMyc.k*(-1);
ConfidentcMyc = 0.2175 - RatecMyc;
bar(c,[RateEV,RatecMyc]);
errorbar(c,[RateEV,RatecMyc],[ConfidentEV,ConfidentcMyc],'.')
hold off


