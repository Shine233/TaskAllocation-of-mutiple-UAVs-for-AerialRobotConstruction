function [time_cost,traveled_dis,min_time_travelled]=AntColonyAlgorithmMethod_realtime(UAV_position,Target_position,UAV_number,UAV_speed,task_number,...
    ant_num_TA, iteratornum_TA, maxT,task_fixed_number, SizeofMap, Color)
%% 
tic;
judge = 1;
traveled_dis = 0;
travelled_time = zeros(1,UAV_number);
Target_position_original = Target_position;
while (isempty(Target_position) == 0)
    
    if (judge == 1)
        %task_number =  task_number_new;
        best_ant_path = AntColonyAlgorothm(UAV_position,Target_position,UAV_number,UAV_speed,task_number,...
            ant_num_TA, iteratornum_TA, maxT,task_fixed_number);
        [row,col]=find(best_ant_path==1);
        
        task_number_imme = task_number;
        for j = 1: UAV_number
            mid = find(col==j);
            if (isempty(mid) == 0)
            len = length(mid);
            allo=mid(randi(len));
            Best_Strategy(j)=allo;
            else
                Best_Strategy(j)= task_number + 1;
                task_number=task_number+1;
            end
        end
    end
    

            for j = 1:size(Best_Strategy,2)
                if(Best_Strategy(1,j) > task_number_imme)
                    %Best_Strategy_updated(i,j)=0;
                    Target_position(Best_Strategy(1,j),:) = UAV_position( j, :);
                    %task_number=task_number+1;
                end
            end

    
    for j =1: size(Best_Strategy,2)
        difference(j,:)=Target_position(Best_Strategy(j),:)-UAV_position(j,:);
        UAV_step(j,:)= (UAV_speed(j)/norm(difference(j,:))) * difference(j,:);
    end
%     for j =1: size(Best_Strategy,2)
%         difference(j,:)=Target_position(Best_Strategy(j),:)-UAV_position(j,:);
%         if (difference(j,1)==0)
%             angle(j)= pi/2;
%         else
%             angle(j)= atan(difference(j,2)/difference(j,1));
%         end
%     end
%     %end
%     
%     % for i= 1: size(Best_Strategy,1)
%     for j= 1: size(Best_Strategy,2)
%         if (difference(j,1) > 0)
%             UAV_step(j,1)= UAV_speed(j)*cos(angle(j));
%             UAV_step(j,2)= UAV_speed(j)*sin(angle(j));
%         elseif(difference(j,1) < 0)
%             UAV_step(j,1)= -UAV_speed(j)*cos(angle(j));
%             UAV_step(j,2)= -UAV_speed(j)*sin(angle(j));
%         elseif ((difference(j,1) == 0)&& (difference(j,2) > 0))
%             UAV_step(j,1)= UAV_speed(j)*cos(angle(j));
%             UAV_step(j,2)= UAV_speed(j)*sin(angle(j));
%         elseif ((difference(j,1) == 0)&& (difference(j,2) < 0))
%             UAV_step(j,1)= - UAV_speed(j)*cos(angle(j));
%             UAV_step(j,2)= - UAV_speed(j)*sin(angle(j));
%         end
%     end
    
    [UAV_position_new,Target_position_new,task_number,traveled_dis,travelled_time] = Draw_Strategy_AntColony_realtime...
        (UAV_position,Target_position,Best_Strategy, SizeofMap, UAV_step, UAV_speed, task_number, traveled_dis, travelled_time,Color,Target_position_original);
    if (isempty(Target_position_new) == 1)
        break;
    end
    UAV_position = UAV_position_new;
    if (size(Target_position,1) > size(Target_position_new,1))
        Target_position = Target_position_new;
        judge =1;
    else
        judge = 0;
    end
end    
min_time_travelled = max(travelled_time);
toc;
time_cost = toc;