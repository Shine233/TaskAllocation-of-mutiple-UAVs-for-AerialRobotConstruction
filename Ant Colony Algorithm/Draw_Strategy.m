function Draw_Strategy(Robot_position,Target_position,best_ant_path,min_dist)
    
figure(1);

plot(Robot_position(:,1), Robot_position(:,2),'bd');
axis([0 15 0 15]);
hold on;

plot(Target_position(:,1), Target_position(:,2),'rx');

[row,col]=find(best_ant_path==1);

for i=1:size(best_ant_path,1)
    %display (Robot_position(i,:))
    %display(Target_position(row(i),:))
    %plot(Robot_position(i,:),Target_position(row(i),:),'g');
    
    plot([Robot_position(i,1), Target_position(row(i),1)], ...
            [Robot_position(i,2), Target_position(row(i),2)],'g');
end

title("Multi-robot Task Allocation Based on Ant Colony Algorithm");
xlabel("X-direction of the map");
ylabel("Y-direction of the map");
legend("Robots","Target positions", "Allocation Strategy");
hold off;

figure(2);
plot(min_dist);
title("The distance that UAVs travelled based on the best allocation strategy in each iteration");
xlabel("The iteration times");
ylabel("The min distance in each iteration");

end