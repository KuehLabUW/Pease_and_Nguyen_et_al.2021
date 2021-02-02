filename = 'Day3_p21_YFP082417_Batch2.csv';
M = csvread(filename);
x = M(:,1)
y = M(:,2)
x = log(x)
%figure
CC = smooth(y,60)
plot(x,CC)
figure
f1 = fit(x,CC,'gauss1')
f2 = fit(x,CC,'gauss2')
plot(f1,x,CC)
figure
plot(f2,x,CC)
para = coeffvalues(f2)
figure
%%%%%%%%%%
a1 = para(1)
b1 = para(2)
c1 = para(3)
F1 = a1*exp(-((x-b1)/c1).^2)

a2 = para(4)
b2 = para(5)
c2 = para(6)
F2 = a2*exp(-((x-b2)/c2).^2)
plot(x,F1)
hold on
plot(x,F2)
hold off

%%%%%%%%%%%%
fun = @(x,a,b,c,d,e,f) a*exp(-((x-b)/c).^2)+d*exp(-((x-e)/f).^2)
Atotal = integral(@(x)fun(x,a1,b1,c1,a2,b2,c2),0,50)
sigma1 = sqrt(c1^2/2)
sigma2 = sqrt(c2^2/2)
Aoff = a1*sigma1/0.3989
Aon = a2*sigma2/0.3989
A1 = integral(@(x)fun(x,a1,b1,c1,0,0,0),0,50)
A2 = integral(@(x)fun(x,0,0,0,a2,b2,c2),0,50)




