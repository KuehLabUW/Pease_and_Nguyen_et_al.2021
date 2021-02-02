cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\080917 - processedNew')
load('pop_fractions_cMyc080917New.mat')
load('pop_fractions_EV080917.mat')

load('CellNumber_EV080917.mat')
load('CellNumber_cMyc080917New.mat')
load('CellNumberDead_cMyc080917.mat')
load('CellNumberDead_EV080917.mat')

tmean = tmean(1:8);
fA2e  = fA2e(1:8);
ftotale = ftotale(1:8);
fA2c = fA2c(1:8);
ftotalc = ftotalc(1:8);
numcellEV = numcellEV(1:8);
numcellcMyc = numcellcMyc(1:8);
numcellDeadcMyc = numcellDeadcMyc(1:8);
numcellDeadEV = numcellDeadEV(1:8);

[fitResultEV,gofe] = fitExpoStep((tmean'*0.5), (fA2e./ftotale)', 12);
[fitResultcMyc,gofc] = fitExpoStep((tmean'*0.5), (fA2c./ftotalc)', 16);

[fitResultEVnumber,gofEVn] = fitExpoDown(tmean'.*0.5, numcellEV');
[fitResultcMycnumber,gofcMycn] = fitExpoDown(tmean'.*0.5, numcellcMyc');

S = [0.01402,0.02266]; %this is fitted net proliferation rate
A = [5367,2916]; %This is started live cells
yo = [100,50]; % This is started dead cells
[fitResultcMycDead,gofcMycd] = fitDeadExpo(tmean'*0.5, numcellDeadcMyc',S(2),A(2),yo(2));
[fitResultEVDead,gofEVd] = fitDeadExpo(tmean'*0.5, numcellDeadEV',S(1),A(1),yo(1));


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


