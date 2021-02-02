%% plot the energy landscape of MC model
alpha = 20;
beta = 4;
N = 50;
lambda = 100%31;
delta = 530;
F = 0.85;
%F = 0.2;
const = 10;
CN = 5;

X1 = 0:0.1:CN;
Y1 = getV_ModelCompactLeft(X1,delta,const);

X2 = CN:0.5:N;
Y2 = getV_ModelCompactRight(X2,alpha,beta,N,...
                                    lambda,delta,F,const);
                                
figure(2)
yyaxis left
plot(X1,Y1)
%ylim([-400,30])
ylabel(" V when C+C' < CN ")
hold on
yyaxis right
plot(X2,Y2)
ylabel(" V when C+C' > CN ")
xlabel("C+C'")
%ylim([-3e-5,-0.4e-5])
%%
figure(10)
plot(X1,Y1)
hold on
plot(X2,Y2)
%%
figure(1)
plot(0:0.1:N,getV_ModelCompactRight(0:0.1:N,alpha,beta,N,...
                                    lambda,delta,F,const))
hold on