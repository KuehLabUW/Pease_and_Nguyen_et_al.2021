%cMycDiv = [0.0768,0.0941,0.0683];
cMycDiv = [0.0941,0.0683,0.0768];
CIcMycDiv = [0.0022,8.9368e-04,0.0012];
%cMycSwitch = [0.069,0.066,0.083];
cMycSwitch = [0.0069,0.0066,0.0083];
CIcMycSwitch = [6.7873e-04,0.0019,4.7845e-04];
%EVDiv = [0.0448,0.0567,0.0302];
EVDiv = [0.0567,0.0302,0.0448];
CIEVDiv = [0.0011,0.0014,9.5947e-04];
%EVSwitch = [0.067,0.054,0.095];
EVSwitch = [0.0067,0.0054,0.0095];
CIEVSwitch = [8.4333e-04,0.0015,0.0011];

XData = [0.0567,0.0302,0.0448,0.0941,0.0683,0.0768];
YData = [0.0067,0.0054,0.0095,0.0069,0.0066,0.0083];

[lin goflin] = fitlinear(XData',YData');
[const gofconst] = fitconstant(XData',YData');

%figure(1)
%hold on
%plot(lin,'b--')
%plot(const,'b')
%errorbar(EVDiv,EVSwitch,CIEVSwitch,CIEVSwitch,CIEVDiv,CIEVDiv,'s','MarkerFaceColor','r','color','r','LineWidth',1)
%errorbar(cMycDiv,cMycSwitch,CIcMycSwitch,CIcMycSwitch,CIcMycDiv,CIcMycDiv,'s','MarkerFaceColor','y','color','y','LineWidth',1)

%legend('y = a*x fit','y = constant fit','EV','cMyc');
%xlim([0,0.12]);
%ylim([0,0.015]);
%xlabel('Division Rate (per hour)');
%ylabel('Switching Rate (per hour)');
%hold off

%%

MeancMycDiv = mean(cMycDiv);
ErrorcMycDiv = std(cMycDiv);
MeancMycSwitch = mean(cMycSwitch);
ErrorcMycSwitch = std(cMycSwitch);

MeanEVDiv = mean(EVDiv);
ErrorEVDiv = std(EVDiv);
MeanEVSwitch = mean(EVSwitch);
ErrorEVSwitch = std(EVSwitch);

MeanXData = [MeanEVDiv,MeancMycDiv];
MeanYData = [MeanEVSwitch,MeancMycSwitch];

[Meanlin Meangoflin] = fitlinear(MeanXData',MeanYData');
[Meanconst Meangofconst] = fitconstant(MeanXData',MeanYData');

figure(2)
hold on
plot(Meanlin,'b--')
plot(Meanconst,'b')
errorbar(MeanEVDiv,MeanEVSwitch,ErrorEVSwitch,ErrorEVSwitch,ErrorEVDiv,ErrorEVDiv,'s','MarkerFaceColor','r','color','r','LineWidth',1)
errorbar(MeancMycDiv,MeancMycSwitch,ErrorcMycSwitch,ErrorcMycSwitch,ErrorcMycDiv,ErrorcMycDiv,'s','MarkerFaceColor','y','color','y','LineWidth',1)
legend('y = a*x fit','y = constant fit','EV','cMyc');
xlim([0,0.12]);
ylim([0,0.015]);
xlabel('Division Rate (per hour)');
ylabel('Switching Rate (per hour)');
hold off


