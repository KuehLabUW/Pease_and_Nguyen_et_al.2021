function Yo = getAdjustYo(Delay,A,S,d,kd,yo)
% This function takes in parameter from the a given deadexpo function and 
% adjust them according to the delay
lambda2 = yo - kd*A/(S+d);
display(lambda2)
Yo = lambda2*exp(-1*Delay*S)+kd*A*exp(Delay*S)/(S+d);
