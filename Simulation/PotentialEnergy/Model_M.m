%% plot the energy landscape of M model
%alpha = 30;
alpha = 20;
beta = 4;
N = 100;
const = 100;

X = 0:1:N;
V = getV_Model(X,alpha,beta,N,const);

figure(1)
plot(X,V)
xlabel('Number of methylated nucleosome')
ylabel(' V ')
xlim([0,100])
hold on
