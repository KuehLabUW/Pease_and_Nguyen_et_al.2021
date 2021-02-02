function [fitresult, gof] = fitInverseExponential(xData, yData)

eq{1} = '-a*exp(k*x)+b';
%eq{1} = sprintf(eq{1},cutoff,cutoff);


equation = [eq{1}];    % full equation with four terms


ft = fittype(equation, 'independent', {'x'}, 'dependent', 'y' );
% equation has form:  ft(lambda)


StartPoint = [1,1,0.5];
opts = fitoptions( 'Method', 'NonlinearLeastSquares','StartPoint',StartPoint);
opts.Display = 'Off';


% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
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
