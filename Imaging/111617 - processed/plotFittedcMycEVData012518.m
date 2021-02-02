cd('C:\Users\samng\Documents\MATLAB\Imaging\111617 - processed')
load('CellNumber_EV111617Raw.mat')
load('CellNumber_cMyc111617Raw.mat')
load('CellNumberDead_cMyc111617Raw.mat')
load('CellNumberDead_EV111617Raw.mat')
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
CelltotalEVDead = CelltotalEVDead(1:100);
CelltotalcMycDead = CelltotalcMycDead(1:100);

[fitResultEVnumber,gofEVn] = fitExpoDown(traw'.*0.5, CelltotalEVLive');
[fitResultcMycnumber,gofcMycn] = fitExpoDown(traw'.*0.5, CelltotalcMycLive');

CIEVnumber = 0.02427 - fitResultEVnumber.k;
CIcMycnumber = 0.03581 - fitResultcMycnumber.k;

S = [fitResultEVnumber.k,fitResultcMycnumber.k]; %this is fitted net proliferation rate
A = [fitResultEVnumber.a,fitResultcMycnumber.a]; %This is started live cells
%%
pr = [0.3481 0.5212];

d = [0.3,0.31];
d(1) = d(1)*pr(1);
d(2) = d(2)*pr(2);


yo =[64,27];% This is started dead cells
[fitResultcMycDead,gofcMycd] = fitDeadExpo010518(traw'*0.5, CelltotalcMycDead',S(2),A(2),d(2),yo(2));
[fitResultEVDead,gofEVd] = fitDeadExpo010518(traw'*0.5, CelltotalEVDead',S(1),A(1),d(1),yo(1));
CIEVDead = 0.02185 - fitResultEVDead.kd;
CIcMycDead = 0.04275 - fitResultcMycDead.kd;
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
%%%%%%%%
figure(2)
hold on
plot(traw.*0.5,CelltotalcMycDead,'bo');
h5= plot(fitResultcMycDead,'b');
plot(traw*0.5,CelltotalEVDead,'ro');
h6= plot(fitResultEVDead,'r');
legend([h5,h6],'cMyc','EV')
xlabel('time (hours)')
ylabel('Cell Number')
hold off
%%%%%%%%%%%%
%fitResultcMycDead
%fitResultEVDead
%%
divEV = fitResultEVnumber.k + fitResultEVDead.kd; %it can be shown mathematically
divcMyc = fitResultcMycnumber.k + fitResultcMycDead.kd;%that live & death rate doesn't change
CIdivEV = sqrt(CIEVnumber^2+CIEVDead^2);
CIdivcMyc = sqrt(CIcMycnumber^2+CIcMycDead^2);

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
YoEV = getAdjustYo(delay,A(1),S(1),d(1),fitResultEVDead.kd,yo(1));
YocMyc = getAdjustYo(delay,A(2),S(2),d(2),fitResultcMycDead.kd,yo(2));
delayedtime = 0:max(traw.*0.5-delay)/1000:max(traw.*0.5-delay);

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

