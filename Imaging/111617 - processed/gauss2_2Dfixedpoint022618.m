function [fitresult, gof] = gauss2_2D(xrange, yrange, nry, param)
% Four-component 2-dimensional Gaussian fit with means and standard
% deviations constrained by the one-dimensional fitting of the data.
%  Create a fit.
%
%  Data for 'gauss2d' fit:
%      X Input : xrange
%      Y Input : yrange
%      Z Output: nry
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.

%% Fit: 'gauss2d'.
[xData, yData, zData] = prepareSurfaceData( xrange, yrange, nry );

% Set up fittype and options.

% 2-dimensional four component gaussian fit
eq{1} = 'A1/(2*pi*sx1*sy1*(1-r1^2))*exp(-1/(2*pi*sx1*sy1*(1-r1^2))*(((x-mx1)/sx1)^2 + ((y-my1)/sy1)^2 + 2*r1*(x-mx1)*(y-my1)/(sx1*sy1)))'
eq{2} = 'A2/(2*pi*sx2*sy2*(1-r2^2))*exp(-1/(2*pi*sx2*sy2*(1-r2^2))*(((x-mx2)/sx2)^2 + ((y-my2)/sy2)^2 + 2*r1*(x-mx2)*(y-my2)/(sx2*sy2)))'
%eq{3} = 'A3/(2*pi*sx3*sy3*(1-r3^2))*exp(-1/(2*pi*sx3*sy3*(1-r3^2))*(((x-mx3)/sx3)^2 + ((y-my3)/sy3)^2 + 2*r1*(x-mx3)*(y-my3)/(sx3*sy3)))'
%eq{4} = 'A4/(2*pi*sx4*sy4*(1-r4^2))*exp(-1/(2*pi*sx4*sy4*(1-r4^2))*(((x-mx4)/sx4)^2 + ((y-my4)/sy4)^2 + 2*r1*(x-mx4)*(y-my4)/(sx4*sy4)))'
equation = [eq{1} '+' eq{2}];    % full equation with four terms


mwiggle = param.mwiggle;
swiggle = param.swiggle;
%mwiggleR = 0.2;
%swiggleR = 0.15; 
param.ylow_m = 3.9; %was at 3.665|3.6
param.yhi_m = 4.5;  %was at 4.323|4.5323
param.ylow_s = 0.34; %was at 3.892
param.yhi_s = 0.10;  %was at 0.233|0.15
%ft(A1,A2,mx1,mx2,my1,my2,r1,r2,sx1,sx2,sy1,sy2,x,y)
StartPoint = [500 500 
    param.ylow_m param.yhi_m 
    param.rhi_m param.rhi_m 
    0 0
    param.ylow_s, param.yhi_s
    param.rhi_s param.rhi_s]';

Upper = [5000 5000
    param.ylow_m+mwiggle param.yhi_m+mwiggle 
    param.rhi_m+mwiggle param.rhi_m+mwiggle 
    0.8 0.8
    param.ylow_s+swiggle param.yhi_s+swiggle  
    param.rhi_s+swiggle param.rhi_s+swiggle]';

Lower = [0 0
    param.ylow_m-mwiggle param.yhi_m-mwiggle 
    param.rhi_m-mwiggle param.rhi_m-mwiggle 
    -0.8 -0.8
    param.ylow_s-swiggle param.yhi_s-swiggle  
    param.rhi_s-swiggle param.rhi_s-swiggle]';

ft = fittype(equation, 'independent', {'x', 'y'}, 'dependent', 'z' );
% equation has form:  ft(A1,A2,A3,A4,r1,r2,r3,r4,x,y)



opts = fitoptions( 'Method', 'NonlinearLeastSquares', 'Lower',Lower(:), 'Upper',Upper(:),'StartPoint',StartPoint(:));
opts.Display = 'Off';


% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );
% Plot fit with data.
%subplot(1,2,1);  plot(fitresult); xlabel('log(Bcl11b-YFP)','FontSize',16); ylabel('log(Bcl11b-RFP)','FontSize',16); title('fit'); view(2);
%axis square
%subplot(1,2,2);  surf(xrange, yrange, nry); xlabel('log(Bcl11b-YFP)','FontSize',16); ylabel('log(Bcl11b-RFP)','FontSize',16); title('data'); view(2); caxis([0 20])
%legend( h, 'gauss2d', 'nry vs. xrange, yrange', 'Location', 'NorthEast' );
% Label axes
%xlabel xrange
%ylabel yrange
%zlabel nry
%grid on
%view( 0.5, 90.0 );


