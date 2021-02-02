function V = getV_ModelCompactRight(X,alpha,beta,N,...
                                    lambda,delta,F,const)

V1 = 3/5*(delta - (N/(1+beta/alpha))*(beta/alpha + F)*lambda)*X.^(5/3);

V2 = 3/8*(1/(1+beta/alpha))*(beta/alpha + F)*lambda*X.^(8/3);

V = V1 + V2 + const;

end