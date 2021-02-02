function Vprime = getVprime_ModelCompactRight(X,alpha,beta,N,...
                                    lambda,delta,F)

G = delta*X.^(2/3);

F = (beta/alpha + F)*lambda*X.^(2/3)*((N-X)/(1+beta/alpha));

Vprime = G - F;

end