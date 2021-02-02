function Vprime = getVprime_Model(X,alpha,beta,N)

Vprime = beta*X.^2 + (alpha-beta*N).*X;

end