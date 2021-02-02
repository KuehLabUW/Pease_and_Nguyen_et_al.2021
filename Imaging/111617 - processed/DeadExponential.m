function y = DeadExponential(x,S,A,d,yo,kd)
y = ((kd*A)/(S+d))*exp(S*x)+(yo-(kd*A)/(S+d))*exp(-d*x);


