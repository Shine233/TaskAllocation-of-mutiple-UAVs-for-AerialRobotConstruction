function [Target_position, task_number] = Update_Strategy(Best_Strategy, UAV_number,task_number,...
    UAV_position, Target_position)%, Target_position_new)
Best_Strategy_updated=Best_Strategy;

if(UAV_number > task_number)
    for i = 1:size(Best_Strategy,1)
        task_number_imme = task_number;
        for j = 1:size(Best_Strategy,2)
            if(Best_Strategy(i,j) > task_number_imme)
                %Best_Strategy_updated(i,j)=0;
                Target_position(Best_Strategy(i,j),:) = UAV_position( j, :);
                task_number=task_number+1;
            end
        end
    end
    
% elseif (UAV_number < task_number)
%     midd=zeros(size(Target_position_new,1), size(Target_position_new,2)-UAV_number, size(Target_position_new,3));
%     for i = 1: size(Best_Strategy,1)
%         mid = Target_position_new(:,:,i) ;
%         for j = 1: UAV_number
%             UAV_position(j,:,i)= Target_position( Best_Strategy(i,j),:);
%             mid(Best_Strategy(i,j)-j+1,:)=[];
%         end
%         midd(:,:,i) = mid;
%         
%     end
      
end