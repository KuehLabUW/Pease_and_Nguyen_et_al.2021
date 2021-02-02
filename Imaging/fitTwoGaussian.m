function fitTwoGaussian(Data,s)

[C,edges] = histcounts(Data,100)
histogram(Data,100)
%C(10000) = 0
CC = smooth(C,s)


x = linspace(1,100,100)
figure
plot(x,CC)

f2 = fit(x.',CC,'gauss2','StartPoint', [18.89,60,9.8,10.43,85,11.63])
figure
plot(f2,x,CC)
para = coeffvalues(f2)

%%%%%%%%%%
a1 = para(1)
b1 = para(2)
c1 = para(3)
F1 = a1*exp(-((x-b1)/c1).^2)

a2 = para(4)
b2 = para(5)
c2 = para(6)
F2 = a2*exp(-((x-b2)/c2).^2)

figure
plot(x,F1)
hold on
plot(x,F2)
hold off

%%%%%%%%%%

end
