clc;
clear

stored_data = csvread('UAV_4-Task_5.csv',3,0);
%% 
% meanvalue = mean(stored_data,1);
% a_live = meanvalue(1:3);
% % a_live = mean(stored_data,1);
% % a_tid = [0.6090, 0.6663, 0.7170, 0.7165];
% a_tid = meanvalue(4:6);
% a_aa = meanvalue(7:9);
% % a_tid = std(stored_data,0,1);   
% a = [a_live; a_tid; a_aa];
% bar(a, 'grouped')
% set(gca, 'XTickLabel',{'Hungarian', 'Ant Colony', 'Ant Colony Real-time'}, 'FontSize', 18);
% ylabel('The meansured data used to appraise algorithm performance','FontSize', 18);
%  xlabel('Algorithms','FontSize',18)
% set(gca, 'ygrid','on','GridLineStyle','-');
% % legend('Algorithm Run Time','UAV Traveled Distance','UAV Traveled Time');
% % legend('boxoff');
% 
% error = std(stored_data,0,1);
% e = [error(1:3); error(4:6);error(7:9)];
% hold on
% numgroups = size(a, 1);
% numbars = size(a, 2);
% groupwidth = min(0.8, numbars/(numbars+1.5));
% 
% for i = 1:numbars
% % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
% x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars); % Aligning error bar with individual bar
% errorbar(x, a(:,i), e(:,i),'k',  'linestyle', 'none', 'lineWidth', 1);
% end
% legend('Computational time (s)','Sum of UAVs Traveled Distance (m)','Sum of UAVs Traveled Time (s)','FontSize', 18);
% legend('boxoff');
% title('The performance data after 4 UAVs executing 5 tasks 10 times using 3 algorithms','FontSize', 18);

%%
stored_data = csvread('hugarian_UAV_fixed_task_4.csv',0,0);
stored_data1 = csvread('hugarian_UAV_fixed_task_6.csv',0,0);
stored_data2 = csvread('hugarian_UAV_fixed_task_8.csv',0,0);
stored_data3 = csvread('hugarian_UAV_fixed_task_10.csv',0,0);


stored_data6 = csvread('antcolony_UAV_fixed_task_4.csv',0,0);
stored_data7 = csvread('antcolony_UAV_fixed_task_6.csv',0,0);
stored_data8 = csvread('antcolony_UAV_fixed_task_8.csv',0,0);
stored_data9 = csvread('antcolony_UAV_fixed_task_10.csv',0,0);
stored_data10 = csvread('antcolony_UAV_fixed_task_12.csv',0,0);


stored_data11 = csvread('antcolony_realtime_UAV_fixed_task_4.csv',0,0);
stored_data12 = csvread('antcolony_realtime_UAV_fixed_task_6.csv',0,0);
stored_data13 = csvread('antcolony_realtime_UAV_fixed_task_8.csv',0,0);
stored_data14 = csvread('antcolony_realtime_UAV_fixed_task_10.csv',0,0);
stored_data15 = csvread('antcolony_realtime_UAV_fixed_task_12.csv',0,0);

%%
% hungarian = [stored_data(1:10,1),stored_data1(1:10,1),stored_data2(1:10,1),stored_data3(1:10,1)];
% hungarian_mean = mean(hungarian,1);
% antcolony= [stored_data6(1:10,1),stored_data7(1:10,1),stored_data8(1:10,1),stored_data9(1:10,1),stored_data10(1:10,1)];
% antcolony_mean = mean(antcolony,1);
% antcolony_realtime= [stored_data11(1:10,1),stored_data12(1:10,1),stored_data13(1:10,1),stored_data14(1:10,1),stored_data15(1:10,1)];
% antcolony_realtime_mean = mean(antcolony_realtime,1);
% 
% 
% plot(4:2:10,hungarian_mean,'-x','LineWidth', 1.5);
% hold on;
% plot(4:2:12,antcolony_mean,'-d','LineWidth', 1.5);
% plot(4:2:12,antcolony_realtime_mean,'-o','LineWidth', 1.5);
% legend('Hungarian Algorithm','Antcolony Algorithm','Antcolony Algorithm in real-time', 'FontSize', 24);
% xlabel('Number of tasks (N)', 'FontSize', 24);
% ylabel('Computation Time (s)', 'FontSize', 24);
% title('The comparision on computation time of 3 algorithms while the number of tasks grows (3 UAVs)','FontSize', 24)
%%
hungarian = [stored_data(1:10,2),stored_data1(1:10,2),stored_data2(1:10,2),stored_data3(1:10,2)];
hungarian_mean = mean(hungarian,1);
antcolony= [stored_data6(1:10,2),stored_data7(1:10,2),stored_data8(1:10,2),stored_data9(1:10,2),stored_data10(1:10,2)];
antcolony_mean = mean(antcolony,1);
antcolony_realtime= [stored_data11(1:10,2),stored_data12(1:10,2),stored_data13(1:10,2),stored_data14(1:10,2),stored_data15(1:10,2)];
antcolony_realtime_mean = mean(antcolony_realtime,1);


plot(4:2:10,hungarian_mean,'-x','LineWidth', 1.5);
hold on;
plot(4:2:12,antcolony_mean,'-d','LineWidth', 1.5);
plot(4:2:12,antcolony_realtime_mean,'-o','LineWidth', 1.5);
legend('Hungarian Algorithm','Antcolony Algorithm','Antcolony Algorithm in real-time', 'FontSize', 24);
xlabel('Number of tasks (N)', 'FontSize', 24);

ylabel('Sum of UAVs Traveled Distance (m)', 'FontSize', 24);
title('The comparision on UAVs traveled distance of 3 algorithms while the number of tasks grows (3 UAVs)','FontSize', 24)

%%
% hungarian = [stored_data(1:10,3),stored_data1(1:10,3),stored_data2(1:10,3),stored_data3(1:10,3)];
% hungarian_mean = mean(hungarian,1);
% antcolony= [stored_data6(1:10,3),stored_data7(1:10,3),stored_data8(1:10,3),stored_data9(1:10,3),stored_data10(1:10,3)];
% antcolony_mean = mean(antcolony,1);
% antcolony_realtime= [stored_data11(1:10,3),stored_data12(1:10,3),stored_data13(1:10,3),stored_data14(1:10,3),stored_data15(1:10,3)];
% antcolony_realtime_mean = mean(antcolony_realtime,1);
% 
% 
% plot(4:2:10,hungarian_mean,'-x','LineWidth', 1.5);
% hold on;
% plot(4:2:12,antcolony_mean,'-d','LineWidth', 1.5);
% plot(4:2:12,antcolony_realtime_mean,'-o','LineWidth', 1.5);
% legend('Hungarian Algorithm','Antcolony Algorithm','Antcolony Algorithm in real-time', 'FontSize', 24);
% xlabel('Number of tasks (N)', 'FontSize', 24);
% 
% 
% ylabel('Sum of UAVs Traveled Time (s)', 'FontSize', 24);
% title('The comparision on UAVs traveled time of 3 algorithms while the number of tasks grows (3 UAVs)','FontSize', 24)

%%
% meanvalue = mean(stored_data,1);
% a_live = meanvalue(3);
% a_tid = meanvalue(6);
% a_aa = meanvalue(9);
% % a_tid = std(stored_data,0,1);   
% a = [a_live; a_tid; a_aa];
% bar(a, 'grouped')
% set(gca, 'XTickLabel',{'Hungarian', 'Ant Colony', 'Ant Colony Real-time'}, 'FontSize', 18);
% % ylabel('Computation time (s)','FontSize', 18);
% % ylabel('Sum of UAVs Traveled Distance (m)','FontSize', 18);
% ylabel('Sum of UAVs Traveled Time (s)','FontSize', 18);
% xlabel('Algorithms','FontSize',18)
% set(gca, 'ygrid','on','GridLineStyle','-');
% 
% error = std(stored_data,0,1);
% e = [error(3); error(6);error(9)];
% hold on
% numgroups = size(a, 1);
% numbars = size(a, 2);
% groupwidth = min(0.8, numbars/(numbars+1.5));
% 
% for i = 1:numbars
% % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
% x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars); % Aligning error bar with individual bar
% errorbar(x, a(:,i), e(:,i),'k',  'linestyle', 'none', 'lineWidth', 1);
% end
% %legend('Computational time','Sum of UAVs Traveled Distance','Sum of UAVs Traveled Time','FontSize', 18);
% %legend('boxoff');
% % title('The comparison of computation time while 4 UAVs executing 5 tasks 10 times using 3 algorithms','FontSize', 18)
% % title('The comparison of Sum of UAVs traveled distances while 4 UAVs executing 5 tasks 10 times using 3 algorithms','FontSize', 18)
% title('The comparison of Sum of UAVs traveled time while 4 UAVs executing 5 tasks 10 times using 3 algorithms','FontSize', 18)
