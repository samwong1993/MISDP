clf
load 100_M6_d3
area(mean(UB)-mean(LB),'facecolor',[0.3,1,1])
hold on
title('Range of n_i')
xlabel('Sensors')
ylabel('Value of n_i')
area(mean(error),'facecolor','r')
ylim([0,25])
legend('Range of n_i','Error')
xticks([1:6])