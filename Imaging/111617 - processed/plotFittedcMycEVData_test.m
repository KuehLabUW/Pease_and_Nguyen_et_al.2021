cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\111617 - processed')
load('pop_fractions_cMyc111617.mat')
load('pop_fractions_EV111617.mat')

load('CellNumber_EV111617.mat')
load('CellNumber_cMyc111617.mat')
load('CellNumberDead_cMyc111617.mat')
load('CellNumberDead_EV111617.mat')



[fitResultEV,gofe] = fitExpoStep((tmean'*0.5+12), (fA2e./ftotale)', 12);
[fitResultcMyc,gofc] = fitExpoStep((tmean'*0.5+12), (fA2c./ftotalc)', 16);

[fitResultEVnumber,gofEVn] = fitExpoDown(tmean'.*0.5+12, numcellEV');
[fitResultcMycnumber,gofcMycn] = fitExpoDown(tmean'.*0.5+12, numcellcMyc');

S = [0.02277,0.03405]; %this is fitted net proliferation rate
A = [5439,3816]; %This is started live cells
yo = [5,3]; % This is started dead cells

[fitResultcMycDead,gofcMycd] = fitDeadExpo_test(tmean'*0.5+12, numcellDeadcMyc',S(2),A(2));
[fitResultEVDead,gofEVd] = fitDeadExpo_test(tmean'*0.5+12, numcellDeadEV',S(1),A(1));


%%%%%%%%%
figure(1)
hold on
plot(tmean.*0.5+12,(fA2e./ftotale),'ro',tmean.*0.5+12,(fA2c./ftotalc),'bo')
h1= plot(fitResultEV,'r');
h2= plot(fitResultcMyc,'b');

legend([h1,h2],'EV','cMyc')
ylim([0,1])
xlim([10,70])
xlabel('time (hours)')
ylabel('Fraction ON')
hold off
%%%%%%%%
figure(2)
hold on
plot(tmean.*0.5+12,numcellEV,'ro',tmean.*0.5+12,numcellcMyc,'bo')
h3= plot(fitResultEVnumber,'r');
h4= plot(fitResultcMycnumber,'b');
legend([h3,h4],'EV','cMyc')
xlabel('time (hours)')
ylabel('Cell Number')
hold off
%%%%%%%%
figure(3)
hold on
plot(tmean.*0.5+12,numcellDeadcMyc,'ro');
h5= plot(fitResultcMycDead,'r');
plot(tmean.*0.5+12,numcellDeadEV,'bo');
h6= plot(fitResultEVDead,'b');
legend([h5,h6],'cMyc','EV')
xlabel('time (hours)')
ylabel('Cell Number')
hold off
%%%%%%%%%%%%
fitResultcMycDead
fitResultEVDead


