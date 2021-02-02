%calculate the chi-square values for each fit
XData = [0.0567,0.0302,0.0448,0.0941,0.0683,0.0768];
YData = [0.0067,0.0054,0.0095,0.0069,0.0066,0.0083];
YError = [8.4333e-04,0.0015,0.0011,6.7873e-04,0.0019,4.7845e-04];
df = numel(XData) - 1;
%first fit y = 0.1059*x
YlinFit = 0.1059.*XData;
dYlin = YlinFit - YData;
Chi_Square_lin = sum((dYlin./YError).^2);
reducedChi_Square_lin = Chi_Square_lin/df;
%second fit y = 0.0007233
YconstFit = 0.007233.*ones(1,numel(XData));
dYconst = YconstFit - YData;
Chi_Square_const = sum((dYconst./YError).^2);
reducedChi_Square_const = Chi_Square_const/df;

disp(reducedChi_Square_lin)
disp(reducedChi_Square_const)

%%
MeanXData = [0.0439,0.0797];
MeanYData = [0.0072,0.0073];
StdYError = [0.0021,9.0738e-04];
Meandf = numel(MeanXData) - 1;

%first fit y = 0.1059*x
MeanYlinFit = 0.1081.*MeanXData;
MeandYlin = MeanYlinFit - MeanYData;
MeanChi_Square_lin = sum((MeandYlin./StdYError).^2);
MeanreducedChi_Square_lin = MeanChi_Square_lin/Meandf;
%second fit y = 0.0007233
MeanYconstFit = 0.007233.*ones(1,numel(MeanXData));
MeandYconst = MeanYconstFit - MeanYData;
MeanChi_Square_const = sum((MeandYconst./StdYError).^2);
MeanreducedChi_Square_const = MeanChi_Square_const/Meandf;

disp(MeanreducedChi_Square_lin)
disp(MeanreducedChi_Square_const)

bar(categorical({'y = a*x+b fit','y = b fit'}),[MeanreducedChi_Square_lin',MeanreducedChi_Square_const']);
ylabel('Reduced Chi-Squared')