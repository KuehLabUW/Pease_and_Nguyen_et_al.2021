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
bar([1,2],[mean(EVSwitch),mean(cMycSwitch)]);
errorbar([1,2],[mean(EVSwitch),mean(cMycSwitch)],[std(EVSwitch),std(cMycSwitch)],'.')
scatter([1,1,1],EVSwitch);
scatter([2,2,2],cMycSwitch);
hold off

figure(2)
hold on
bar([1,2],[mean(EVDiv),mean(cMycDiv)]);
errorbar([1,2],[mean(EVDiv),mean(cMycDiv)],[std(EVDiv),std(cMycDiv)],'.')
scatter([1,1,1],EVDiv);
scatter([2,2,2],cMycDiv);
hold off