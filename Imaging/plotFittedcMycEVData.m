cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\082117 - processed')
load('pop_fractions_cMyc.mat')
load('pop_fractions_EV.mat')
load('pop_fractions_p21.mat')
load('CellNumber_EV072017.mat')
load('CellNumber_cMyc072017.mat')
[fitResultEV,gofe] = fitExpoStep(tmean', (fA2e./ftotale)', 12);
[fitResultcMyc,gofc] = fitExpoStep(tmean', (fA2c./ftotalc)', 16);

[fitResultEVnumber,gofEVn] = fitExpoDown(tmean', numcellEV');
[fitResultcMycnumber,gofcMycn] = fitExpoDown(tmean', numcellcMyc');
%%%%%%%%%
figure(1)
hold on
plot(tmean,(fA2e./ftotale),'ro',tmean,(fA2c./ftotalc),'bo')
h1= plot(fitResultEV,'r');
h2= plot(fitResultcMyc,'b');

legend([h1,h2],'EV','cMyc')
ylim([0,1])
xlabel('time (hours)')
ylabel('Fraction ON')
hold off
%%%%%%%%
figure(2)
hold on
plot(tmean,numcellEV,'ro',tmean,numcellcMyc,'bo')
h3= plot(fitResultEVnumber,'r');
h4= plot(fitResultcMycnumber,'b');
legend([h3,h4],'EV','cMyc')
xlabel('time (hours)')
ylabel('Cell Number')
hold off