clear
%%Raw EV data
A(1).EV = [0 19];
A(2).EV = [38 8 0.5 5.5];
A(3).EV = [33 0.5 0.5 2 2 1 1 7.5];
A(4).EV = [40 7 0.5 4.5];
A(5).EV = [46.5 0.5 0.5 7 1 10 0.5 7];
A(6).EV = [37.5 0.5 0.5 1 0.5 6];
A(7).EV = [3 12 0.5 0.5 0.5 1 0.5 1.5 0.5 3];
A(8).EV = [21.5 17];
A(9).EV = [45 5 0.5 12.5 0.5 0.5 0.5 1 0.5 0.5 2.5 1.5];
A(10).EV = [63 9.5];
A(11).EV = [11.5 2.5];
A(12).EV = [68.5 31.49 0.5 0.5 0.5 0.5];
A(13).EV = [72.5 8.5 0.5 22.5];
A(14).EV = [0 0.5 1 0.5 0.5 4 0.5 10];
A(15).EV = [20.5 1.5 0.5 11];
A(16).EV = [27 1 0.5 3.5 0.5 3.5 0.5 0.5 0.5 4.5 0.5 2.5 0.5 0.5 0.5];
A(17).EV = [24.5 9.5 0.5 1.5 0.5 1 0.5 1 0.5 11.5 11];
A(18).EV = [34 3.5 0.5 3 0.5 2.5];
A(19).EV = [4 1];
A(20).EV = [52.5 5.5];
A(21).EV = [0 3.5];
A(22).EV = [15 3.5];
A(23).EV = [0 3 0.5 0.5 8.5 0.5 1];
A(24).EV = [26.5 12];
A(25).EV = [28.5 6.5 0.5 3 1.5 2 1 14 0.5 7];
A(26).EV = [30 5 0.5 3 1.5 2 1 2];
A(27).EV = [38.5 1.5 1.5 1.5 2 0.5 11 1.5 4.5];
A(28).EV = [20.5 19.5 0.5 0.5 0.5 22 0.5 1];
A(29).EV = [21 8.5 0.5 3.5 0.5 1 0.5 1 0.5 7];
A(30).EV = [7 11 0.5 10.5];
%% Unpack EV data into time course
for i= 1:numel(A)
    s = zeros(1,100);
    currentpos = 0;
    a = A(i).EV(2:end);
    a = a.*2; % convert time into frame
    for k = 1:numel(a)
        if rem(k,2) == 1 % this is detected case
            s(currentpos+1:currentpos+a(k)) = 1;
        elseif rem(k,2) == 0 %this is undetected case
            s(currentpos+1:currentpos+a(k)) = 0;
        end
        currentpos = currentpos + a(k);
    end
    Unpacked(i).EV = s;
end
%% ok sum these time course matrices element by element
EVDetection = zeros(1,100);
for i= 1:numel(Unpacked)
   EVDetection = EVDetection + Unpacked(i).EV;
end
[Prob gof] = fitExpo060818((1:1:100)',(EVDetection./30)'); %normalized by total cell (30)
figure(1)
scatter(1:1:100,EVDetection./30);
hold on
plot(Prob)
hold off
%% write an sse fitting algorithm to find kd
load('CellNumber_EV080917Raw.mat')
load('CellNumberDead_EV080917Raw.mat')
Kdlist = 0.0:0.0005:0.00;
CelltotalEVDead = CelltotalEVDead(1:100);
CelltotalEVLive = CelltotalEVLive(1:100);
XData = 1:1:numel(CelltotalEVDead);
for j = 1:numel(Kdlist) %loop through candidate kd
    DeadCellModel = zeros(0,numel(XData));
    for l = 1:numel(XData) %start at each x value - generate list of model dead cell
        SUM = 72*Prob(XData(l)); %this is to account for the initial number of dead cells;
        for x = 1:XData(l) %summation
           SUM = SUM + Kdlist(j)*CelltotalEVLive(x)*Prob(XData(l)-x); 
        end
        DeadCellModel(l) = SUM;
    end
    %calculate sse
    Subsse = (DeadCellModel-CelltotalEVDead).^2;
    Sumsse = sum(Subsse);
    disp(Kdlist(j));
    disp(Sumsse);
    SSE(j) = Sumsse;
end
%% seems Kd = 0.0140 is best here plot model vs real data
DeadCellModel = zeros(0,numel(XData));
    for l = 1:numel(XData) %start at each x value - generate list of model dead cell
        SUM = 72*Prob(XData(l)); %this is to account for the initial number of dead cells
        for x = 1:XData(l) %summation
           SUM = SUM + 0.0140*CelltotalEVLive(x)*Prob(XData(l)-x); 
        end
        DeadCellModel(l) = SUM;
    end
figure(2)
XData = XData(1:2:end);
CelltotalEVDead = CelltotalEVDead(1:2:end);
DeadCellModel = DeadCellModel(1:2:end);
scatter(XData*0.5,CelltotalEVDead);
hold on
plot(XData*0.5,DeadCellModel);
%hold off
%% Attempts to generate 95% CI
%first calculate the residue
residue = (DeadCellModel-CelltotalEVDead);
%then calculate the jacobian which is the derivative of the Obj function
%wrt kd
Jacobian = zeros(0,numel(XData));
for l = 1:numel(XData) %start at each x value - generate list of model dead cell
     SUM = 0;
     for x = 1:XData(l) %summation
          SUM = SUM + CelltotalEVLive(x)*Prob(XData(l)-x); 
     end
     Jacobian(l) = SUM;
end
% get the best Kd fit value from the above section
kdbestev = [0.0140];
%put into CI calculation function for non linear regression
ciev = nlparci(kdbestev',residue','jacobian',Jacobian');

disp('rate in per hours and CI')
disp(kdbestev*2)
disp((ciev(2)-kdbestev)*2)






