cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\072017 - processed')
load('segtracksint_ALL072017.mat')

Time =struct();
%%%%%%%%%%%%
GateNumber = 1;
for i= 1:numel(objects)
    a = [];
    b = [];
    t = [];
    p = [];
    for j= 1:numel(objects(i).obj)
        if objects(i).obj(j).gate == GateNumber
            if objects(i).obj(j).data.logYFP > 1
                a = [a objects(i).obj(j).data.logYFP];
                b = [b objects(i).obj(j).data.logRFP];
                p = [p objects(i).obj(j).data.p];
                t = [t i];
            end

        end
    Time(i).logYFP = a;
    Time(i).logRFP = b;
    Time(i).time = t;
    Time(i).position = p;
    
    end
end
YFPtotal = [];
RFPtotal = [];
Timetotal = [];
Ptotal = [];

for i= 1:numel(objects)
    YFPtotal = [YFPtotal  Time(i).logYFP];
    RFPtotal = [RFPtotal  Time(i).logRFP];
    Timetotal = [Timetotal Time(i).time];
    Ptotal = [Ptotal Time(i).position];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%5
pt = 0.5;
eps = 0;

%tbinlow = [0 10 20 30 40 50 60 70 80];   % these are the well positions

tbinlow = linspace(0,90,16);
tbinhigh = tbinlow+5-eps;   % these are the well positions

tmean = (tbinlow + tbinhigh)./2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% obtain the peak location and width for OFF and ON populations of the two colors
fity = fitgauss2(YFPtotal,pt);   % call custom generated function to automatically determined threshold value for getting population dynamics
fitr = fitgauss2(RFPtotal,pt);

if (fity.b1 < fity.b2)
    param.ylow_m = fity.b1;
    param.yhi_m = fity.b2;
    param.ylow_s = fity.c1;
    param.yhi_s = fity.c2;
else
    param.ylow_m = fity.b2;
    param.yhi_m = fity.b1;
    param.ylow_s = fity.c2;
    param.yhi_s = fity.c1;
end

if (fitr.b1 < fitr.b2)
    param.rlow_m = fitr.b1;
    param.rhi_m = fitr.b2;
    param.rlow_s = fitr.c1;
    param.rhi_s = fitr.c2;
else
    param.rlow_m = fitr.b2;
    param.rhi_m = fitr.b1;
    param.rlow_s = fitr.c2;
    param.rhi_s = fitr.c1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P = 113;  % the total number of well positions
pmin = 143;   
pmax = 255;
pt = 0.5;
% the range of log intensity values for bcl11b-yfp and rfp histograms
xrange = 2.6:0.05:5.5;
yrange = 2.8:0.05:5.5;
%% Fit data to two-dimensional gaussian to obtain population fractions

%% Choose only tracks for analysis p - the tracks that don't have the 
pind = find((p >= pmin) & (p <= pmax))

param.mwiggle = 0.10;
param.swiggle = 0.1;

f = [];

for i = 1:length(tbinlow)
    inds = find((Timetotal >= tbinlow(i)) & (Timetotal <= tbinhigh(i))); 
    %inds = intersect(tind, pind);
    nry = hist3([RFPtotal(inds)' YFPtotal(inds)'], {yrange, xrange});
    [fitresult gof] = gauss2_2Dfixedpoint(xrange, yrange, nry, param);
    fdata(i).fitresult = fitresult;
    figure(i); 
    subplot(1,2,1);  plot(fitresult); set(gca,'LineWidth', 0.3); xlabel('log(Bcl11b-YFP)','FontSize',16); ylabel('log(Bcl11b-RFP)','FontSize',16); title(['Fit, time=' num2str(tmean(i)) 'hrs']); view(2); axis square;
    subplot(1,2,2);  surf(xrange, yrange, nry,'LineWidth', 0.3); axis([xrange(1) xrange(end) yrange(1) yrange(end)]);  xlabel('log(Bcl11b-YFP)','FontSize',16); ylabel('log(Bcl11b-RFP)','FontSize',16); title(['Data, time=' num2str(tmean(i)) 'hrs']); view(2); axis square;
    
    
    
    
    %caxis([0 20]);  no need to scale the color axis 
    print(['ON-OFF-Time_' num2str(i) '.jpg'],'-djpeg');   
    print(['ON-OFF-Time_' num2str(i) '.pdf'],'-dpdf'); 
    f(i).fitresult = fitresult;
    % why are the error bounds so dramatic?
    fdata(i).A1 = fitresult.A1; 
    fdata(i).A2 = fitresult.A2;
    %fdata(i).A3 = fitresult.A3;
    %fdata(i).A4 = fitresult.A4;
end

figure(20);
fA1 = [fdata.A1];  % red
fA2 = [fdata.A2];  % both

ftotal = fA1+fA2
plot(tmean, fA1./ftotal,'ko'); hold on;
plot(tmean, fA2./ftotal,'go');


% fit the four curves

legend({'RED', 'BOTH'});
xlabel('time (hours)');
ylabel('fraction')
title('Time evolution of population fractions, starting from OFF-OFF cells');

save('pop_fractions_013017.mat','tmean','fA1','fA2','ftotal');

    
    
    
    










