filename = 'Day3_p21_YFP072517.csv';
M = csvread(filename);
x = M(:,1)
y = M(:,2)
x = log(x)
figure
CC = smooth(y,10)
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
A1 = trapz(x,F1)

a2 = para(4)
b2 = para(5)
c2 = para(6)
F2 = a2*exp(-((x-b2)/c2).^2)
A2 = trapz(x,F2)
plot(x,F1)
hold on
plot(x,F2)
hold off
figure
%%%%%%%%%%
A1
A2

