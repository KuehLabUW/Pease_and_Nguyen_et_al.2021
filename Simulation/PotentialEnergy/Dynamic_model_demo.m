clear
%plot a demo of how energy landscape is traversed over time
rootdir = 'C:\Users\samng\Documents\MATLAB\Simulation\';
filename = '50Tr50RawDivideCompCompacAlphaON1AlphaOFF8LambdaON310DeltaOFF5300Cycle20.csv';

compact_sequence = csvread(strcat(rootdir,filename));
Time = 0:1:numel(compact_sequence)-1;%
%%%
filter = 1%20000;
T = Time(1:filter:end)*0.00001;
Compact = compact_sequence(1:filter:end);
%%%
alpha = 1%20;
beta =8 %4;
N = 50;
lambda = 310 %100%31;
delta = 5300%530;
Fx = 0.85;

const = 10;
CN = 5;

Y = getV_ModelCompactRight(Compact,alpha,beta,N,...
                                    lambda,delta,Fx,const);
Ylinear = getV_ModelCompactRight(0:0.1:50,alpha,beta,N,...
                                    lambda,delta,Fx,const);

loops = numel(Compact);
F = struct('cdata',[],'colormap',[]);
Fcount = 0;
Lcount = 0;

%%
for j = 0:20:loops
    plot(0:0.1:50,Ylinear,'b','LineWidth',2)
    Fcount = Fcount +1;
    Lcount = Lcount +1;
    hold on
    %get turn a different color when cell division
    if rem(j,200)==0 && j > 0
        %keyboard
        %%
        scatter(Compact(j),Y(j)+0.1e5,150,'k','filled')
        xlim([0,50])
        xlabel('compacted nucleosome number')
        ylabel('Potential Energy (V)')
        hold off
        drawnow
        F(Fcount) = getframe;
        %%
        Fcount = Fcount + 1;
        plot(0:0.1:50,Ylinear,'b','LineWidth',2)
        hold on
        scatter(Compact(j+1),Y(j+1)+0.1e5,300,'r','filled')
        xlim([0,50])
        xlabel('compacted nucleosome number')
        ylabel('Potential Energy (V)')
        hold off
        drawnow
        
        F(Fcount) = getframe;
        if Compact(j) == 0
            break
        end
    elseif j > 0
        scatter(Compact(j),Y(j)+0.1e5,100,'k','filled')
        xlim([0,50])
        xlabel('compacted nucleosome number')
        ylabel('Potential Energy (V)')
        hold off
        drawnow
        F(Fcount) = getframe;
        
        F(Fcount) = getframe;
        if Compact(j) == 0
            break
        end
    else
        Fcount = Fcount - 1;
    end
    
end

%%
% create the video writer with 1 fps
writerObj = VideoWriter('PotentialEnergy.avi');
writerObj.FrameRate = 5;
% set the seconds per image
% open the video writer
open(writerObj);
% write the frames to the video
for i=1:length(F)
    % convert the image to a frame
    %if rem(i,200000) == 0
    %    writerObj.FrameRate = 5;
    %else
        
    %end
    %writerObj.FrameRate = 20;
    frame = F(i).cdata ;    
    writeVideo(writerObj, frame);
end
% close the writer object
close(writerObj);