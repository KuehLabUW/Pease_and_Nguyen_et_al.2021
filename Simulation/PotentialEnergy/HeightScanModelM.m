% Scan energy barrier
clear
alpha = 1:1:60;
beta = 1;
N = 100;
const = 10;
Vheight = [];
SteadyX = [];
for i = 1:1:numel(alpha)
%for i = 5
    
    %find approximate zero crossings
    ScanX = 0.5:0.1:N;
    for s = 1:1:numel(ScanX)-1
        %disp(s)
        S1 = getVprime_Model(ScanX(s),alpha(i),beta,N);
        %disp(S1)
        S2 = getVprime_Model(ScanX(s+1),alpha(i),beta,N);
        if S1*S2 < 0
            Scan_avg = 0.5*(ScanX(s)+ScanX(s+1));
            height = getV_Model(0,alpha(i),beta,N,0) - getV_Model(Scan_avg,alpha(i),beta,N,0);
            Vheight = [Vheight height];
            SteadyX = [SteadyX Scan_avg];
            %keyboard
            break
        elseif S1 == 0
            Scan_avg = ScanX(s);
            height = getV_Model(0,alpha(i),beta,N,0) - getV_Model(Scan_avg,alpha(i),beta,N,0);
            Vheight = [Vheight height];
            SteadyX = [SteadyX Scan_avg];
            %keyboard
            break
        elseif S2 == 0
            Scan_avg = ScanX(s+1);
            height = getV_Model(0,alpha(i),beta,N,0) - getV_Model(Scan_avg,alpha(i),beta,N,0);
            Vheight = [Vheight height];
            SteadyX = [SteadyX Scan_avg];
            %keyboard
            break  
        end
    end
%keyboard    
end
kb = 1.38e-23;
T = 310;
Ks = exp(-Vheight./(kb*T*6.0221409e+23));
norm_Ks = Ks./Ks(1);
ratios = beta./alpha;
figure(3)
plot(ratios,norm_Ks)
xlabel('beta/alpha')
hold on
plot(ratios,SteadyX);