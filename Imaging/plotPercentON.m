Time = linspace(1,98,98);
RealTime = Time * 1.03;

figure

hold on 
plot(RealTime,ev1)
plot(RealTime,ev2)
plot(RealTime,p211)
plot(RealTime,p212)
plot(RealTime,cMyc1)
plot(RealTime,cMyc2)
legend('Feb-ev', 'Jul-ev', 'Feb-p21', 'Jul-p21', 'Feb-cMyc', 'Jul-cMyc')
axis([0*1.03 numel(objects)*1.03 0 1])
xlabel('Time (hours)')
ylabel('Fraction ON')
xlim([0 65])