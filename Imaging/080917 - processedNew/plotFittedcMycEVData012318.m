cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\080917 - processedNew')
load('pop_fractions_cMyc080917New.mat')
load('pop_fractions_EV080917New.mat')

load('CellNumber_EV080917New.mat')
load('CellNumber_cMyc080917New.mat')
load('CellNumberDead_cMyc080917New.mat')
load('CellNumberDead_EV080917New.mat')

tmean = tmean(1:7);
fA2e  = fA2e(1:7);
ftotale = ftotale(1:7);
fA2c = fA2c(1:7);
ftotalc = ftotalc(1:7);
numcellEV = numcellEV(1:7);
numcellcMyc = numcellcMyc(1:7);
numcellDeadcMyc = numcellDeadcMyc(1:7);
numcellDeadEV = numcellDeadEV(1:7);

[fitResultEV,gofe] = fitExpoStep((tmean'*0.5), (fA2e./ftotale)', 12);
[fitResultcMyc,gofc] = fitExpoStep((tmean'*0.5), (fA2c./ftotalc)', 16);

[fitResultEVnumber,gofEVn] = fitExpoDown(tmean'.*0.5, numcellEV');
[fitResultcMycnumber,gofcMycn] = fitExpoDown(tmean'.*0.5, numcellcMyc');

S = [0.01549,0.02298]; %this is fitted net proliferation rate
A = [4949,3860]; %This is started live cells
%S = [0.008895,0.01509]; %this is fitted net proliferation rate
%A = [7381,5755]; %This is started live cells
d = [0.2,0.2]; 
yo =[0,0];% This is started dead cells
[fitResultcMycDead,gofcMycd] = fitDeadExpo010518(tmean'*0.5, numcellDeadcMyc',S(2),A(2),d(2),yo(2));
[fitResultEVDead,gofEVd] = fitDeadExpo010518(tmean'*0.5, numcellDeadEV',S(1),A(1),d(1),yo(1));


%%%%%%%%%
figure(1)
hold on
plot(tmean.*0.5,(fA2e./ftotale),'ro',tmean.*0.5,(fA2c./ftotalc),'bo')
h1= plot(fitResultEV,'r');
h2= plot(fitResultcMyc,'b');

legend([h1,h2],'EV','cMyc')
ylim([0,1])
xlim([0,70])
xlabel('time (hours)')
ylabel('Fraction ON')
hold off
%%%%%%%%
figure(2)
hold on
plot(tmean.*0.5,numcellEV,'ro',tmean.*0.5,numcellcMyc,'bo')
h3= plot(fitResultEVnumber,'r');
h4= plot(fitResultcMycnumber,'b');
legend([h3,h4],'EV','cMyc')
xlabel('time (hours)')
ylabel('Cell Number')
hold off
%%%%%%%%
figure(3)
hold on
plot(tmean.*0.5,numcellDeadcMyc,'ro');
h5= plot(fitResultcMycDead,'r');
plot(tmean*0.5,numcellDeadEV,'bo');
h6= plot(fitResultEVDead,'b');
legend([h5,h6],'cMyc','EV')
xlabel('time (hours)')
ylabel('Cell Number')
hold off
%%%%%%%%%%%%
fitResultcMycDead
fitResultEVDead


