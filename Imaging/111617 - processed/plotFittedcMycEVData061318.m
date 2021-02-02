cd('C:\Users\samng\Documents\MATLAB\Imaging\111617 - processed')
load('CellNumber_EV111617Raw.mat')
load('CellNumber_cMyc111617Raw.mat')
load('pop_fractions_cMyc111617Model022518Test.mat')
load('pop_fractions_EV111617Model022518Test.mat')

tmean = tmean(1:5);
fA2e  = fA2e(1:5);
ftotale = ftotale(1:5);
fA2c = fA2c(1:5);
ftotalc = ftotalc(1:5);

traw = traw(1:100);
CelltotalEVLive = CelltotalEVLive(1:100);
CelltotalcMycLive = CelltotalcMycLive(1:100);


[fitResultEVnumber,gofEVn] = fitExpoDown(traw'.*0.5, CelltotalEVLive');
[fitResultcMycnumber,gofcMycn] = fitExpoDown(traw'.*0.5, CelltotalcMycLive');

CIEVnumber = 0.02427 - fitResultEVnumber.k;
CIcMycnumber = 0.03581 - fitResultcMycnumber.k;

EVDead = 0.0190;
cMycDead =  0.0270;
EVDeadCI= 6.3637e-04;
cMycDeadCI =  6.7225e-04;
%%
%%%%%%%%
figure(1)
hold on
plot(traw.*0.5,CelltotalEVLive,'bo',traw.*0.5,CelltotalcMycLive,'ro')
h3= plot(fitResultEVnumber,'b');
h4= plot(fitResultcMycnumber,'r');
legend([h3,h4],'EV','cMyc')
xlabel('time (hours)')
ylabel('Cell Number')
hold off

%%%%%%%%%%%%
%fitResultcMycDead
%fitResultEVDead
%%
divEV = fitResultEVnumber.k + EVDead; %it can be shown mathematically
divcMyc = fitResultcMycnumber.k + cMycDead;%that live & death rate doesn't change
CIdivEV = sqrt(CIEVnumber^2+EVDeadCI^2);
CIdivcMyc = sqrt(CIcMycnumber^2+cMycDeadCI^2);

display(divEV)
display(divcMyc)
display(CIdivEV)
display(CIdivcMyc)
%%
delay = -12; %delay is negative because remember when t= 0, T = 12, so t = T-12!
[fitResultEV,gofe] = fitExpoStep((tmean'*0.5-delay), (fA2e./ftotale)', 12);
[fitResultcMyc,gofc] = fitExpoStep((tmean'*0.5-delay), (fA2c./ftotalc)', 16);
CISwitchEV = 0.01062 -  fitResultEV.k;
CISwitchcMyc = 0.008794 -  fitResultcMyc.k;
figure(3)
hold on
plot(tmean.*0.5-delay,(fA2e./ftotale),'ro',tmean.*0.5-delay,(fA2c./ftotalc),'bo')
h1= plot(fitResultEV,'r');
h2= plot(fitResultcMyc,'b');
legend([h1,h2],'EV','cMyc')
display('Switching rate EV')
display(fitResultEV.k)
display('Switching rate cMyc')
display(fitResultcMyc.k)
display(CISwitchEV)
display(CISwitchcMyc)
hold off
xlabel('time (hours)')
ylabel('Switching rate (per hour)')
%%


figure(4)
hold on
plot(traw.*0.5-delay,CelltotalEVDead,'bo',traw.*0.5-delay,CelltotalcMycDead,'ro');
plot(delayedtime,DeadExponential(delayedtime,S(1),A(1)*exp(delay*S(1)),d(1),YoEV,fitResultEVDead.kd),'b')
plot(delayedtime,DeadExponential(delayedtime,S(2),A(2)*exp(delay*S(2)),d(2),YocMyc,fitResultcMycDead.kd),'r')
legend('EV','cMyc')
xlabel('time (hours)')
ylabel('Cell Number')
xlim([10,70]);
hold off
figure(5)
hold on
plot(traw.*0.5-delay,CelltotalEVLive,'bo',traw.*0.5-delay,CelltotalcMycLive,'ro');
plot(delayedtime,Exponential(delayedtime,A(1)*exp(delay*S(1)),S(1)),'b')
plot(delayedtime,Exponential(delayedtime,A(2)*exp(delay*S(2)),S(2)),'r')
legend('EV','cMyc')
xlabel('time (hours)')
ylabel('Cell Number')
xlim([10,70]);
hold off

