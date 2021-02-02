function V = getV_Model(X,alpha,beta,N,const)

V = 1/3*beta*X.^3 + 1/2*(alpha-beta*N)*X.^2 + const;

end