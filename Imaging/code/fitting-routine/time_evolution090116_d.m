%% here try two-dimensional gaussian fitting, use means and standard deviations constrained by the one-dimensional fits

load('segtracksint_gatedALL081716.mat');   % load the single cell time traces
load('acq.mat');   % load the acq.mat file
thr = gettime(acq,2);    % load the time vector 
fcs = Fcs(timepoints, thr, [], fieldinfo, gates); 

P = 214;  % the total number of well positions
pmin = 1;   % these are the well positions for OFF cells
pmax = 145;
pt = 0.5;

% the range of log intensity values for bcl11b-yfp and rfp histograms
xrange = 2.6:0.05:4.8;
yrange = 2.8:0.05:4.6;

ingate = fcs.ingate(2);   % these are all the cells that are alive!
data = fcs.data;   % get all the data;
data(~ingate) = [];  % delete all the cells that are not in the live gate

tbinlow = [0 10 20 30 40 50 60 70 80 90 100];   % these are the well positions
tbinhigh = tbinlow+10-eps;   % these are the well positions
tmean = (tbinlow + tbinhigh)./2;

% these are the vectors of cell data points - contaminated somewhat
logYFP = [data.logYFP];
logRFP = [data.logRFP];
t = [data.t];
p = [data.p];

% filter out removing outlier cells
 ind = [find(logYFP < min(xrange)) find(logYFP > max(xrange)) find(logRFP < min(yrange)) find(logRFP > max(yrange))];
 ind = unique(ind);
 fprintf(['Filtering out ' num2str(length(ind)) ' outlying data points.\n'])
 logYFP(ind) = [];
 logRFP(ind) = [];
 t(ind) = [];
 p(ind) = [];

 
%% obtain the peak location and width for OFF and ON populations of the two colors
fity = fitgauss2(logYFP,pt);   % call custom generated function to automatically determined threshold value for getting population dynamics
fitr = fitgauss2(logRFP,pt);

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

%% Fit data to two-dimensional gaussian to obtain population fractions

%% Choose only tracks for analysis p - the tracks that don't have the 
pind = find((p >= pmin) & (p <= pmax))

param.mwiggle = 0.15;
param.swiggle = 0.2;

f = [];

for i = 1:length(tbinlow)
    tind = find((t >= tbinlow(i)) & (t <= tbinhigh(i))); 
    inds = intersect(tind, pind);
    nry = hist3([logRFP(inds)' logYFP(inds)'], {yrange, xrange});
    [fitresult gof] = gauss4_2D(xrange, yrange, nry, param);
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
    fdata(i).A3 = fitresult.A3;
    fdata(i).A4 = fitresult.A4;
end

figure(20);
fA1 = [fdata.A1];  % off-off
fA2 = [fdata.A2];  % yellow
fA3 = [fdata.A3];  % red
fA4 = [fdata.A4];  % both
ftotal = fA1+fA2+fA3+fA4;
plot(tmean, fA1./ftotal,'ko'); hold on;
plot(tmean, fA2./ftotal,'go');
plot(tmean, fA3./ftotal,'ro');
plot(tmean, fA4./ftotal,'bo');

% fit the four curves

legend({'OFF', 'YELLOW', 'RED', 'BOTH'});
xlabel('time (hours)');
ylabel('fraction')
title('Time evolution of population fractions, starting from OFF-OFF cells');

save('pop_fractions_013017.mat','tmean','fA1','fA2','fA3','fA4','ftotal');



