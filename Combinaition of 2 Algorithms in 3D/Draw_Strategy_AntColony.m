function [ UAV_position_new, Target_position_new, task_number, count]= Draw_Strategy_AntColony(UAV_position,...
    Target_position,best_path, SizeofMap, UAV_step,UAV_speed, task_number, count,Color)

UAV_position_original = UAV_position;
Target_position_new = Target_position;
for n = 1: size(best_path,1)
    figure(2);
    
    for i = 1:size(UAV_position,1)
        plot3(UAV_position(i,1), UAV_position(i,2), UAV_position(i,3),'d','Color',Color(i,:));
        hold on;
    end
    axis([SizeofMap SizeofMap SizeofMap]);
    title("Multiple UAVs Task Allocation Based on Ant Colony Algorithm");
    xlabel("X-direction of the map (m)");
    ylabel("Y-direction of the map (m)");
    zlabel("Z-direction of the map (m)");
    %legend("Robots","Target positions", "Allocation Strategy");
    
    for i = 1:size(Target_position,1)
        plot3(Target_position(i,1), Target_position(i,2), Target_position(i,3), 'rx');
    end
    pause(1)
    
    % judge=ones(size(best_path,2),1);
    % while (sum(judge~=0))
    for j =1:size(UAV_position,1)
        if (UAV_step(j,1)~= 0 || UAV_step(j,2)~=0)
            dist= sqrt((UAV_position(j,1)-Target_position(best_path(n,j),1))^2 ...
                + (UAV_position(j,2)-Target_position(best_path(n,j),2))^2 +...
                (UAV_position(j,3)-Target_position(best_path(n,j),3))^2);
            if (dist <= UAV_speed(j))
                plot3([UAV_position(j,1), Target_position(best_path(n,j),1)], ...
                    [UAV_position(j,2), Target_position(best_path(n,j),2)],...
                    [UAV_position(j,3), Target_position(best_path(n,j),3)],'--','Color',Color(j,:));
                UAV_position(j,:)=Target_position(best_path(n,j),:);
                UAV_position_new(j,:)=Target_position(best_path(n,j),:);
                
                [Lia, Locb]=ismember(UAV_position(j,:), Target_position_new,'rows');
                Target_position_new(Locb,:) = [];
                task_number = task_number - 1;
                
                count(1,j)=count(1,j)+1;
                
            else
                UAV_position_new(j,:)=UAV_position(j,:)+UAV_step(j,:,n);
                task_number = task_number;
            end
        else
            UAV_position_new(j,:)=UAV_position(j,:);
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


