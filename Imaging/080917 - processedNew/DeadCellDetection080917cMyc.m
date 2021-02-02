A(1).cMyc = [0 3 1 5];
A(2).cMyc = [4 38];
A(3).cMyc = [30.5 31.5];
A(4).cMyc = [53 5.51 0.5 1 1 3 1 1 1.5 3.5 0.5 1];
A(5).cMyc = [77 2.5 0.5 0.5 9.5 7];
A(6).cMyc = [6.5 3.5 0.5 22];
A(7).cMyc = [21.5 2.5 0.5 13];
A(8).cMyc = [25.5 1 0.5 1];
A(9).cMyc = [26.5 10.5 0.5 1];
A(10).cMyc = [43.5 4];
A(11).cMyc = [51.5 20];
A(12).cMyc = [59.5 1 0.5 6];
A(13).cMyc = [34 12.5];
A(14).cMyc = [48 2 0.5 6 0.5 5.5 0.5 0.5];
A(15).cMyc = [65 1 8.5 0.5 2.5 2 1.5 0.5 1 0.5];
A(16).cMyc = [81.5 1 2 0.5 0.5 1];
A(17).cMyc = [82.5 9 0.5 1.5 0.5 1];
A(18).cMyc = [95 6.5 0.5 4.5];
A(19).cMyc = [17 0.5 0.5 0.5 1 0.5 1 1.5 0.5 5 0.5 2.2 0.5 1];
A(20).cMyc = [31 8 1 1 0.5 4]; 
A(21).cMyc = [31.5 70];
A(22).cMyc = [31 1 0.5 5 0.5 12.5];
A(23).cMyc = [41.5 0.5 1 1 1 1 2 0.5 1 2 1 1 0.5 0.5 0.5 1.5 1 0.5 1 1 0.5 0.5];
A(24).cMyc = [69.5 13];
A(25).cMyc = [63.5 6 0.5 4.5 1 1 3.5 0.5];
A(26).cMyc = [21.5 1.5 16 0.5 0.5 6];
A(27).cMyc = [31.5 2 0.5 2];
A(28).cMyc = [52.5 1.5 1.5 0.5 1.5 1 0.5 0.5 0.5 1 5 1 1 3 0.5 2.5];
A(29).cMyc = [64 14.5 1 0.5 0.5 2.5 1 0.5 3 7.5];
A(30).cMyc = [37 13.5];
%% Unpack EV data into time course
for i= 1:numel(A)
    s = zeros(1,200);
    currentpos = 0;
    a = A(i).cMyc(2:end);
    a = a.*2; % convert time into frame
    for k = 1:numel(a)
        if rem(k,2) == 1 % this is detected case
            s(currentpos+1:currentpos+a(k)) = 1;
        elseif rem(k,2) == 0 %this is undetected case
            s(currentpos+1:currentpos+a(k)) = 0;
        end
        currentpos = currentpos + a(k);
    end
    disp(i)
    Unpacked(i).cMyc = s;
end
%% ok sum these time course matrices element by element
cMycDetection = zeros(1,200);
for i= 1:numel(Unpacked)
   cMycDetection = cMycDetection + Unpacked(i).cMyc;
end
[Prob gof] = fitExpo060818((1:1:200)',(cMycDetection./30)');%normalized by total cell (30)
figure(1)
scatter(1:1:200,cMycDetection./30);
hold on
plot(Prob)
hold off
%% write an sse fitting algorithm to find kd
load('CellNumber_cMyc080917Raw.mat')
load('CellNumberDead_cMyc080917Raw.mat')
Kdlist = 0.0:0.0005:0.00;
CelltotalcMycDead = CelltotalcMycDead(1:100);
CelltotalcMycLive = CelltotalcMycLive(1:100);
XData = 1:1:numel(CelltotalcMycDead);
for j = 1:numel(Kdlist) %loop through candidate kd
    DeadCellModel = zeros(0,numel(XData));
    for l = 1:numel(XData) %start at each x value - generate list of model dead cell
        SUM = 25*Prob(XData(l)); %this is to account for the initial number of dead cells;
        for x = 1:XData(l) %summation
           SUM = SUM + Kdlist(j)*CelltotalcMycLive(x)*Prob(XData(l)-x); 
        end
        DeadCellModel(l) = SUM;
    end
    %calculate sse
    Subsse = (DeadCellModel-CelltotalcMycDead).^2;
    Sumsse = sum(Subsse);
    disp(Kdlist(j));
    disp(Sumsse);
    SSE(j) = Sumsse;
end
%% seems Kd = 0.0170 is best here plot model vs real data
DeadCellModel = zeros(0,numel(XData));
    for l = 1:numel(XData) %start at each x value - generate list of model dead cell
        SUM = 25*Prob(XData(l)); %this is to account for the initial number of dead cells
        for x = 1:XData(l) %summation
           SUM = SUM + 0.0170*CelltotalcMycLive(x)*Prob(XData(l)-x); 
        end
        DeadCellModel(l) = SUM;
    end
figure(2)
XData = XData(1:2:end);
CelltotalcMycDead = CelltotalcMycDead(1:2:end);
DeadCellModel = DeadCellModel(1:2:end);
scatter(XData*0.5,CelltotalcMycDead);
hold on
plot(XData*0.5,DeadCellModel);
%hold off
%% Attempts to generate 95% CI
%first calculate the residue
residue = (DeadCellModel-CelltotalcMycDead);
%then calculate the jacobian which is the derivative of the Obj function
%wrt kd
Jacobian = zeros(0,numel(XData));
for l = 1:numel(XData) %start at each x value - generate list of model dead cell
     SUM = 0;
     for x = 1:XData(l) %summation
          SUM = SUM + CelltotalcMycLive(x)*Prob(XData(l)-x); 
     end
     Jacobian(l) = SUM;
end
% get the best Kd fit value from the above section
kdbestcMyc = [0.0170];
%put into CI calculation function for non linear regression
cicmyc = nlparci(kdbestcMyc',residue','jacobian',Jacobian');

disp('rate in per hours and CI')
disp(kdbestcMyc*2)
disp((cicmyc(2)-kdbestcMyc)*2)


