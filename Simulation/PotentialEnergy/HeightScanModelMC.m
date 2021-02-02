% Scan energy barrier
clear
alpha = 8;
beta = 0.01:0.01:8;
N = 50;
delta = 530;
lambda = 31;
F = 0.2;
Ct = 0.6*50;
const = 0;
Vheight = [];
CN = 5;
SteadyX = [];
for i = 1:1:numel(beta)
%for i = 400
    
    %find approximate zero crossings
    ScanX = 0:0.1:N;
    for s = 1:1:numel(ScanX)-1
        %disp(s)
        S1 = getVprime_ModelCompactRight(ScanX(s),alpha,beta(i),N,...
                                          lambda,delta,F,Ct);

        %disp(S1)
        S2 = getVprime_ModelCompactRight(ScanX(s+1),alpha,beta(i),N,...
                                          lambda,delta,F,Ct);

        if S1*S2 < 0
            Scan_avg = 0.5*(ScanX(s)+ScanX(s+1));
            height = getV_ModelCompactLeft(CN,delta,Ct,const) - getV_ModelCompactRight(Scan_avg,alpha,beta(i),N,...
                                                                               lambda,delta,F,Ct,const);
            Vheight = [Vheight height];
            SteadyX = [SteadyX Scan_avg];
            %keyboard
            disp(Scan_avg)
            break
        elseif S1 == 0
            Scan_avg = ScanX(s);
            height = getV_ModelCompactLeft(CN,delta,Ct,const) - getV_ModelCompactRight(Scan_avg,alpha,beta(i),N,...
                                                                               lambda,delta,F,Ct,const);
            Vheight = [Vheight height];
            SteadyX = [SteadyX Scan_avg];
            %keyboard
            disp(Scan_avg)
            break
        elseif S2 == 0
            Scan_avg = ScanX(s+1);
            height = getV_ModelCompactLeft(CN,delta,Ct,const) - getV_ModelCompactRight(Scan_avg,alpha,beta(i),N,...
                                                                               lambda,delta,F,Ct,const);
            Vheight = [Vheight height];
            SteadyX = [SteadyX Scan_avg];
            %keyboard
            disp(Scan_avg)
            break  
        end
    end
    
end
kb = 1.38e-23;
T = 310;
Ks = exp(-Vheight./(kb*T*6.0221409e+23));
norm_Ks = Ks./Ks(end);
ratios = beta./alpha;
figure(3)
plot(ratios,norm_Ks)
xlabel('beta/alpha')
hold on
plot(ratios,SteadyX);