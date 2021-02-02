filename = 'Day3_EVExtra_YFP072517.csv';
M = csvread(filename);
N = M(2:4096,:);
X = [];
for i = 1:4095
    for j = 1:N(i,2)
        N(i,2)
        X = [X N(i,1)];
    end
end
Y = log(X)
[C,edges] = histcounts(Y,10000)
histogram(Y,10000)
%C(10000) = 0
CC = smooth(C,50)


x = linspace(0,10000,10000)
plot(x,CC)
figure
f1 = fit(x.',CC,'gauss1')
f2 = fit(x.',CC,'gauss2')
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
syms s
root = solve(a1*exp(-((s-b1)/c1).^2)-a2*exp(-((s-b2)/c2).^2),s)
root = vpa(root)

x1 = linspace(root(1),10000,5000)
F1new = a1*exp(-((x1-b1)/c1).^2)
%a1 = trapz(x1,F1new)

x2 = linspace(0,root(1),5000)
F2new = a2*exp(-((x2-b2)/c2).^2)
%a2 = trapz(x2,F2new)
plot(x1,F1new)
figure
plot(x2,F2new)





