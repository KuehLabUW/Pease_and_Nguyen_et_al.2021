function [fitresult, gof] = fitDeadExpo(xData, yData,S,A)

eq{1} = '((a*kd*%f)/(%f+d))*exp(%f*x)+(yo-(a*kd*%f)/(%f+d))*exp(-d*x)';
eq{1} = sprintf(eq{1},A,S,S,A,S);


equation = [eq{1}];    % full equation with four terms


ft = fittype(equation, 'independent', {'x'}, 'dependent', 'y' );
% equation has form:  ft(lambda)

%Awiggle = 100;
%parameters: a,d,kd,yo
StartPoint = [0.3,0.5,0.0005,100];
Upper      = [1,1,100,100];
Lower      = [0,0,0,0];
opts = fitoptions( 'Method', 'NonlinearLeastSquares','StartPoint',StartPoint,'Upper',Upper,'Lower',Lower);
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
