function [time_cost, traveled_dis,min_time_travelled] = HungrainAlgorithmMethod(UAV_position,Target_position,UAV_number,UAV_speed,task_number,...
    SizeofMap, Color)

judge = 1;
traveled_dis=0;
travelled_time = zeros(1,UAV_number);
Target_position_original = Target_position;
tic
while (isempty(Target_position) == 0)
    
    if (judge == 1)
        Cost=CostMatrixConstruction(UAV_position,Target_position,UAV_number,UAV_speed,task_number);
        
        %% Hungarian Algorithm
        Best_Strategy = HungarianAlgorithm(Cost);
        % find the allocation method for at that moment
        Best_Strategy=Best_Strategy(:,1:UAV_number);
        Best_Strategy = unique(Best_Strategy,'rows');
        if (size(Best_Strategy,1)>1)
            Best_Strategy = Best_Strategy( randi(size(Best_Strategy,1)) ,:);
        end
    end
    
    %Target_position_new = Target_position;
    
    [Target_position,task_number] = Update_Strategy(Best_Strategy,UAV_number,task_number, UAV_position,...
        Target_position);%, Target_position_new);
    
    % Calculate the step distance between per second
    %for i= 1: size(Best_Strategy,1)
    for j =1: size(Best_Strategy,2)
        difference(j,:)=Target_position(Best_Strategy(j),:)-UAV_position(j,:);
        UAV_step(j,:)= (UAV_speed(j)/norm(difference(j,:))) * difference(j,:);
    end
    %end
    
    % for i= 1: size(Best_Strategy,1)
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
   
    %% Display the task allcocation strategy
    % test=zeros(3,2);
    [UAV_position_new,Target_position_new,task_number,traveled_dis,travelled_time] = Draw_Strategy_Hungrain(...
        UAV_position,Target_position,Best_Strategy, SizeofMap, UAV_step, UAV_speed, task_number,...
        traveled_dis,travelled_time,Color,Target_position_original);
    UAV_position = UAV_position_new;
    %Target_position = Target_position_new;
    
    if (isempty(Target_position_new) == 1)
        break;
    end
    
    if (size(Target_position,1) > size(Target_position_new,1))
        Target_position = Target_position_new;
        judge =1;
    else
        judge = 0;
    end
    
end
min_time_travelled = max(travelled_time);
toc
time_cost=toc;