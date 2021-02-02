%cMycDiv = [0.0768,0.0941,0.0683];
cMycDiv = [0.0868,0.0660,0.0689];
CIcMycDiv = [0.0019,8.5299e-04,0.0011];
%cMycSwitch = [0.069,0.066,0.083];
cMycSwitch = [0.0069,0.0066,0.0083];
CIcMycSwitch = [6.7873e-04,0.0019,4.7845e-04];
%EVDiv = [0.0448,0.0567,0.0302];
EVDiv = [0.0660,0.0337,0.0472];
CIEVDiv = [0.0013,0.0016,0.0018];
%EVSwitch = [0.067,0.054,0.095];
EVSwitch = [0.0067,0.0054,0.0095];
CIEVSwitch = [8.4333e-04,0.0015,0.0011];


%scatter(EVDiv,EVSwitch,'r','filled');
%hold on;
%scatter(cMycDiv,cMycSwitch,'b','filled');
%legend('EV','cMyc');ylim([0,0.2]);
%xlim([0,0.12]);
%ylim([0,0.015]);
%xlabel('Division Rate (per hour)');
%ylabel('Switching Rate (per hour)');

errorbar(EVDiv,EVSwitch,CIEVSwitch,CIEVSwitch,CIEVDiv,CIEVDiv,'s','MarkerFaceColor','r','color','r','LineWidth',1)
hold on
errorbar(cMycDiv,cMycSwitch,CIcMycSwitch,CIcMycSwitch,CIcMycDiv,CIcMycDiv,'s','MarkerFaceColor','b','color','b','LineWidth',1)
legend('EV','cMyc');
xlim([0,0.12]);
ylim([0,0.015]);
xlabel('Division Rate (per hour)');
ylabel('Switching Rate (per hour)');
