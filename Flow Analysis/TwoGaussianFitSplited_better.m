filename = 'Day3_EV_YFP072517.csv';
M = csvread(filename);
x = M(:,1)
y = M(:,2)
x = log(x)
%figure
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

a2 = para(4)
b2 = para(5)
c2 = para(6)
F2 = a2*exp(-((x-b2)/c2).^2)
plot(x,F1)
hold on
plot(x,F2)
hold off
figure
%%%%%%%%%%
syms s
root = solve(a1*exp(-((s-b1)/c1).^2)-a2*exp(-((s-b2)/c2).^2),s)
root = vpa(root)

x1 = linspace(root(1),10,5000)
F1new = a1*exp(-((x1-b1)/c1).^2)

x2 = linspace(0,root(1),5000)
F2new = a2*exp(-((x2-b2)/c2).^2)
plot(x1,F1new)
figure
plot(x2,F2new)
%%%%%%%%%%%%%
fun = @(x,a,b,c) a*exp(-((x-b)/c).^2)
A1 = integral(@(x)fun(x,a1,b1,c1),double(root(1)),14.8)
A2 = integral(@(x)fun(x,a2,b2,c2),0,double(root(1)))





