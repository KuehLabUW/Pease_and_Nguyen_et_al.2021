function fitresult = bimodalthresh(X,pt)
%CREATEFIT(XR,NR)
%  Create a fit.
%
%  Data for 'gauss2' fit:
%      X Input : xR
%      Y Output: nR
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%% 
% generate histogram
[nR,xR] = hist(X,500);

%% Fit: 'gauss2'.
[xData, yData] = prepareCurveData( xR, nR );

% Set up fittype and options.
ft = fittype( 'gauss2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0 -Inf -Inf 0];
opts.StartPoint = [278 3.34161442173722 0.171057660223845 258.999806947124 3.98575878177883 0.146469480409251];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
% 
% m1 = fitresult.b1;
% m2 = fitresult.b2;
% s1 = fitresult.c1; % standard deviations
% s2 = fitresult.c2; % standard deviation
% a1 = fitresult.a1;
% a2 = fitresult.a2;
% 
% f = 1/pt - 1;
% 
% a = 1/s1^2 - 1/s2^2;
% b = 2*(m2/s2^2 - m1/s1^2);
% c = m1^2/s1^2 - m2^2/s2^2 + log(a2/a1) - log(f);
% 
% threshold = (-b + sqrt(b^2 - 4*a*c))/(2*a);   % the larger root seems to be the solution to this equation!
% 
% % Plot fit with data.
% figure( 'Name', 'gauss2' );
% h = plot( fitresult, xData, yData );
% legend( h, 'nR vs. xR', 'gauss2', 'Location', 'NorthEast' );
% % Label axes
% xlabel xR
% ylabel nR
% grid on
% hold on; plot([threshold threshold], [0 300]);
% 
% 
