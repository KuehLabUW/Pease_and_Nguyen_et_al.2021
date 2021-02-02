cd('C:\Users\samng\Documents\MATLAB\Imaging\080917 - processedNew')
load('CellNumber_EV080917Raw.mat')
load('CellNumber_cMyc080917Raw.mat')
load('CellNumberDead_cMyc080917Raw.mat')
load('CellNumberDead_EV080917Raw.mat')
load('pop_fractions_cMyc080917Model022518.mat')
load('pop_fractions_EV080917Model022518.mat')

tmean = tmean(1:6);
fA2e  = fA2e(1:6);
ftotale = ftotale(1:6);
fA2c = fA2c(1:6);
ftotalc = ftotalc(1:6);

traw = traw(1:100);
CelltotalEVLive = CelltotalEVLive(1:100);
CelltotalcMycLive = CelltotalcMycLive(1:100);
CelltotalEVDead = CelltotalEVDead(1:100);
CelltotalcMycDead = CelltotalcMycDead(1:100);

[fitResultEVnumber,gofEVn] = fitExpoDown(traw'.*0.5, CelltotalEVLive');
[fitResultcMycnumber,gofcMycn] = fitExpoDown(traw'.*0.5, CelltotalcMycLive');
CIEVnumber = 0.01795 - fitResultEVnumber.k;
CIcMycnumber = 0.03238 - fitResultcMycnumber.k;


S = [fitResultEVnumber.k,fitResultcMycnumber.k]; %this is fitted net proliferation rate
A = [fitResultEVnumber.a,fitResultcMycnumber.a]; %This is started live cells

%d = [0.6269,0.5871]; %see 'TabulatedDeadCellCount.m'; apparent death rate
d = [0.22,0.20]; 
pr = [0.54, 0.62]; 

yo =[73,25];% This is started dead cells
[fitResultcMycDead,gofcMycd] = fitDeadExpo010518(traw'*0.5, CelltotalcMycDead',S(2),A(2),d(2)*pr(2),yo(2));
[fitResultEVDead,gofEVd] = fitDeadExpo010518(traw'*0.5, CelltotalEVDead',S(1),A(1),d(1)*pr(1),yo(1));
CIEVDead = 0.0499 - fitResultEVDead.kd;
CIcMycDead = 0.05708 - fitResultcMycDead.kd;
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

cMycDead = fitResultcMycDead.kd;
EVDead   = fitResultEVDead.kd;
CIEVDead = CIEVDead;
CIcMycDead = CIcMycDead;
display(cMycDead)
display(EVDead)
%%
divEV = fitResultEVnumber.k + EVDead;
divcMyc = fitResultcMycnumber.k + cMycDead;
display(divEV)
display(divcMyc)

CIdivEV = sqrt(CIEVnumber^2+CIEVDead^2);
CIdivcMyc = sqrt(CIcMycnumber^2+CIcMycDead^2);
display(CIdivEV)
display(CIdivcMyc)
%%
[fitResultEV,gofe] = fitExpoStep((tmean'*0.5), (fA2e./ftotale)', 12);
[fitResultcMyc,gofc] = fitExpoStep((tmean'*0.5), (fA2c./ftotalc)', 16);
CISwitchEV = 0.007501 -  fitResultEV.k;
CISwitchcMyc = 0.007547 -  fitResultcMyc.k;


figure(3)
hold on
%plot(tmean.*0.5,(fA2e./ftotale),'ro',tmean.*0.5,(fA2c./ftotalc),'bo')
plot(tmean.*0.5,(fA2e./ftotale),'ro','MarkerFace','r');
plot(tmean.*0.5,(fA2c./ftotalc),'bo','MarkerFace','b');
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
ylabel('Fraction ON Cells')
