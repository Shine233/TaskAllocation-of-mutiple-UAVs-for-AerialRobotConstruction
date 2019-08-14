function [ UAV_position_new, Target_position_new, task_number, travelled_dis, travelled_time]= Draw_Strategy_AntColony_realtime...
    (UAV_position,Target_position,best_path, SizeofMap, UAV_step,UAV_speed, task_number,travelled_dis, travelled_time, Color)

UAV_position_original = UAV_position;
Target_position_new = Target_position;
for n = 1: size(best_path,1)
    figure(3);
    
    for i = 1:size(UAV_position,1)
        plot3(UAV_position(i,1), UAV_position(i,2), UAV_position(i,3),'d','Color',Color(i,:));
        hold on;
    end
    axis([SizeofMap SizeofMap SizeofMap]);
    title("Multi-robot Task Allocation Based on Ant Colony Algorithm in Real Time");
    xlabel("X-direction of the map");
    ylabel("Y-direction of the map");
    zlabel("Z-direction of the map");
    %legend("Robots","Target positions", "Allocation Strategy");
    hold on;
    
    for i = 1:size(Target_position,1)
        plot3(Target_position(i,1), Target_position(i,2), Target_position(i,3), 'gx');
    end
    pause(1)
    
    % judge=ones(size(best_path,2),1);
    % while (sum(judge~=0))
        for j =1:size(UAV_position,1)
            dist= sqrt((UAV_position(j,1)-Target_position(best_path(n,j),1))^2 ...
            + (UAV_position(j,2)-Target_position(best_path(n,j),2))^2);
            if (dist <= UAV_speed(j))
                plot3([UAV_position(j,1), Target_position(best_path(n,j),1)], ...
                         [UAV_position(j,2), Target_position(best_path(n,j),2)],...
                         [UAV_position(j,3), Target_position(best_path(n,j),3)],'--','Color',Color(j,:));
                UAV_position(j,:)=Target_position(best_path(n,j),:);
                UAV_position_new(j,:)=Target_position(best_path(n,j),:);
               
                [Lia, Locb]=ismember(UAV_position(j,:), Target_position_new,'rows'); 
                Target_position_new(Locb,:) = [];
                task_number = task_number - 1;
                % judge(j)=0;
                travelled_dis = travelled_dis + dist;
                travelled_time(j) = travelled_time(j) + dist/UAV_speed(j);
            else
                UAV_position_new(j,:)=UAV_position(j,:)+UAV_step(j,:,n);
                task_number = task_number;
                travelled_dis = travelled_dis + UAV_speed(j);
                travelled_time(j) = travelled_time(j) + 1;
            end
%             if (UAV_step(j,1) >0 && sign(Target_position(j,1)-UAV_position_new(j,1)) <= 0)
%                 UAV_position_new(j,:)=Target_position(j,:);
%                 judge(j)=0;
%             elseif (UAV_step(j,1) <0 && sign(Target_position(j,1)-UAV_position_new(j,1)) >= 0)
%                 UAV_position_new(j,:)=Target_position(j,:);
%                 judge(j)=0;
%             end
            
        end
        
         for i = 1:size(UAV_position,1)
            plot3(UAV_position_new(i,1), UAV_position_new(i,2), UAV_position_new(i,3),'d','Color',Color(i,:));
         end
        
        for i=1:size(best_path,2)
            plot3([UAV_position(i,1), UAV_position_new(i,1)], ...
                [UAV_position(i,2), UAV_position_new(i,2)],...
                [UAV_position(i,3), UAV_position_new(i,3)],'--','Color',Color(i,:));
            %     plot([UAV_position(i,1), Target_position(best_path(n,i),1)], ...
            %             [UAV_position(i,2), Target_position(best_path(n,i),2)],'g');
        end
        %plot(Target_position(:,1), Target_position(:,2),'rx');
        UAV_position = UAV_position_new;
        pause(0.1)
        
    % end
    % test= UAV_position;
    % UAV_position = UAV_position_original; 
    
    % title("Multi-robot Task Allocation Based on Hungarian Algorithm");
    % xlabel("X-direction of the map");
    % ylabel("Y-direction of the map");
    % legend("Robots","Target positions", "Allocation Strategy");
    % hold off;
    
end

end


