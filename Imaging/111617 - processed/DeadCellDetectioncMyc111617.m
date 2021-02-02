%Well 215 175 176 245 170 165 147 256 245 182
%Time recorded, each frame is 0.5 hr
A(1).cMyc = [7 1 1 0.5 0.5];
A(2).cMyc = [49.5 3.5 0.5 6];
A(3).cMyc = [0 3.5];
A(4).cMyc = [15 2];
A(5).cMyc = [13.5 5.5 0.5 0.5 0.5 1 0.5 2.5];
A(6).cMyc = [20 9 0.5 2.5];
A(7).cMyc = [21 6 0.5 9.5];
A(8).cMyc = [29.5 10];
A(9).cMyc = [29 11 1 1 0.5 0.5 0.5 1 0.5 1];
A(10).cMyc = [32 3 1 4.5];
A(11).cMyc = [0 9];
A(12).cMyc = [33 3.5 0.5 1];
A(13).cMyc = [36.5 4 1 4 0.5 2];
A(14).cMyc = [48.5 1.5 2.5 1 0.5 2.5 0.5 2];
A(15).cMyc = [11 1.5 0.5 5];
A(16).cMyc = [21 8];
A(17).cMyc = [22 9];
A(18).cMyc = [34.5 1.5];
A(19).cMyc = [39.5 19.5];
A(20).cMyc = [36 5.5 2 0.5 1 6.5]; 
A(21).cMyc = [51 1.5];
A(22).cMyc = [38.5 8 0.5 3.5];
A(23).cMyc = [27.5 1.5 2.5 0.5 0.5 2];
A(24).cMyc = [41 1.5 1.5 0.5 0.5 0.5 1.5 0.5 1 5.5];
A(25).cMyc = [20 0.5 0.5 1.5 0.5 5.5];
A(26).cMyc = [26 9];
A(27).cMyc = [30 5 0.5 5.5 0.5 1 1.5 0.5 2.5];
A(28).cMyc = [39.5 3.5 1 6 1 1.5 0.5 1 1 1 0.5 0.5];
A(29).cMyc = [18.5 20];
A(30).cMyc = [22 5 1 2 0.5 6.5 0.5 1];
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
load('CellNumber_cMyc111617Raw.mat')
load('CellNumberDead_cMyc111617Raw.mat')
Kdlist = 0.0:0.0005:0.02;
CelltotalcMycDead = CelltotalcMycDead(1:100);
CelltotalcMycLive = CelltotalcMycLive(1:100);
XData = 1:1:numel(CelltotalcMycDead);
for j = 1:numel(Kdlist) %loop through candidate kd
    DeadCellModel = zeros(0,numel(XData));
    for l = 1:numel(XData) %start at each x value - generate list of model dead cell
        SUM = 27*Prob(XData(l)); %this is to account for the initial number of dead cells;
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
%% seems Kd = 0.0135 is best here plot model vs real data
DeadCellModel = zeros(0,numel(XData));
    for l = 1:numel(XData) %start at each x value - generate list of model dead cell
        SUM = 27*Prob(XData(l)); %this is to account for the initial number of dead cells
        for x = 1:XData(l) %summation
           SUM = SUM + 0.0135*CelltotalcMycLive(x)*Prob(XData(l)-x); 
        end
        DeadCellModel(l) = SUM;
    end
figure(2)
scatter(XData,CelltotalcMycDead);
hold on
scatter(XData,DeadCellModel);
hold off
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
kdbestcMyc = [0.0135];
%put into CI calculation function for non linear regression
cicmyc = nlparci(kdbestcMyc',residue','jacobian',Jacobian');

disp('rate in per hours and CI')
disp(kdbestcMyc*2)
disp((cicmyc(2)-kdbestcMyc)*2)
