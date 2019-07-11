function Draw_Strategy(Robot_position,Target_position,best_path)

for n = 1: size(best_path,1)
figure(n);

plot(Robot_position(:,1), Robot_position(:,2),'bd');
axis([0 15 0 15]);
hold on;

plot(Target_position(:,1), Target_position(:,2),'rx');

for i=1:size(best_path,2)
    
    plot([Robot_position(i,1), Target_position(best_path(n,i),1)], ...
            [Robot_position(i,2), Target_position(best_path(n,i),2)],'g');
end

title("Multi-robot Task Allocation Based on Hungarian Algorithm");
xlabel("X-direction of the map");
ylabel("Y-direction of the map");
legend("Robots","Target positions", "Allocation Strategy");
hold off;

end 

end