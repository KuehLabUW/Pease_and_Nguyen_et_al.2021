clear
%cMycDiv = [0.0768,0.0941,0.0683];
cMycDiv = [0.0651,0.0565,0.0689];
CIcMycDiv = [0.0014,7.0464e-04,0.0011];
%cMycSwitch = [0.069,0.066,0.083];
cMycSwitch = [0.0069,0.0066,0.0083];
CIcMycSwitch = [6.7873e-04,0.0019,4.7845e-04];
%EVDiv = [0.0448,0.0567,0.0302];
EVDiv = [0.045,0.0207,0.0427];
CIEVDiv = [0.0011,0.0012,8.8424e-04];
%EVSwitch = [0.067,0.054,0.095];
EVSwitch = [0.0067,0.0054,0.0095];
CIEVSwitch = [8.4333e-04,0.0015,0.0011];

FoldDiv = cMycDiv./EVDiv;
FoldCIDiv = abs(FoldDiv).*sqrt((CIcMycDiv./cMycDiv).^2 + (CIEVDiv./EVDiv).^2);

FoldSwitch = cMycSwitch./EVSwitch;
FoldCISwitch = abs(FoldSwitch).*sqrt((CIcMycSwitch./cMycSwitch).^2 + (CIEVSwitch./EVSwitch).^2);

figure(1)
hold on
plot([1,FoldDiv(1)],[1,FoldSwitch(1)],'.-')
errorbar(FoldDiv(1),FoldSwitch(1),FoldCISwitch(1),FoldCISwitch(1),FoldCIDiv(1),FoldCIDiv(1))
plot([1,FoldDiv(2)],[1,FoldSwitch(2)],'.-')
errorbar(FoldDiv(2),FoldSwitch(2),FoldCISwitch(2),FoldCISwitch(2),FoldCIDiv(2),FoldCIDiv(2))
plot([1,FoldDiv(3)],[1,FoldSwitch(3)],'.-')
errorbar(FoldDiv(3),FoldSwitch(3),FoldCISwitch(3),FoldCISwitch(3),FoldCIDiv(3),FoldCIDiv(3))
plot(0:0.1:3,0:0.1:3)
plot(0:0.1:3,ones(1,numel(0:0.1:3)))
xlim([1,3])
%ylim([1,2])
hold off

figure(2)
hold on
c = categorical({'EV','cMyc'});
bar(c,[mean(EVDiv),mean(cMycDiv)]);
errorbar(c,[mean(EVDiv),mean(cMycDiv)],[std(EVDiv),std(cMycDiv)],'.')
hold off

figure(3)
hold on
bar(c,[mean(EVSwitch),mean(cMycSwitch)]);
errorbar(c,[mean(EVSwitch),mean(cMycSwitch)],[std(EVSwitch),std(cMycSwitch)],'.')
hold off

figure(4)
hold on
plot([1,FoldDiv(1)],[1,FoldSwitch(1)],'.-')
errorbar(FoldDiv(1),FoldSwitch(1),FoldCISwitch(1),FoldCISwitch(1),FoldCIDiv(1),FoldCIDiv(1))
plot([1,FoldDiv(2)],[1,FoldSwitch(2)],'.-')
errorbar(FoldDiv(2),FoldSwitch(2),FoldCISwitch(2),FoldCISwitch(2),FoldCIDiv(2),FoldCIDiv(2))
plot([1,FoldDiv(3)],[1,FoldSwitch(3)],'.-')
errorbar(FoldDiv(3),FoldSwitch(3),FoldCISwitch(3),FoldCISwitch(3),FoldCIDiv(3),FoldCIDiv(3))
%Simulation data
FoldChangeDivRate = [0.0333 0.0417 0.0500 0.0714]./0.0333;
FoldChangeSwitchCycle = [0.0041 0.0052 0.0062 0.0088]./0.0041;
FoldChangeSwitchEnzyme = [0.0114 0.0121 0.0121 0.0135]./0.0114;
[L1 gof] = fitLinear(FoldChangeDivRate',FoldChangeSwitchCycle');
[L2 gof] = fitLinear(FoldChangeDivRate',FoldChangeSwitchEnzyme');
plot(1:0.1:3,L1(1:0.1:3))
plot(1:0.1:3,L2(1:0.1:3))
xlim([1,3])
%ylim([1,2])
hold off
