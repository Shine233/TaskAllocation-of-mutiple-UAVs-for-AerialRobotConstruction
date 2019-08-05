function [best_ant_path,min_distance] = find_best_ant_path(all_ant_path,worker_number,task_number,ant_num,Robot_position,Target_position, UAV_speed)

% Define the calculated distance
SumOfDistance=zeros(ant_num,1);

% Calculate the distance between robots and targets positions, and then
% compare them to find the best task allocation strategy
%ite = 1;
if (task_number >= worker_number)
    for i=1:ant_num
        
        OneOfPath=all_ant_path((i-1)*task_number+1:(i-1)*task_number+task_number,:);
        [Lia, Locb]=ismember(zeros(1,task_number), OneOfPath','rows');
        if (Lia == 0)
            [row,col]=find(OneOfPath==1);
            for j=1:worker_number
                
                %         display(OneOfPath)
                %         display(col)
                %         display(row)
                
                mid = find(col==j);
                len = length(mid);
                allo=mid(randi(len));
                
                SumOfDistance(i)=SumOfDistance(i)+sqrt( (Robot_position(j,1)-Target_position(row(allo),1))^2 ...
                    + (Robot_position(j,2)-Target_position(row(allo),2))^2) / UAV_speed(j);
            end
            %ite= ite+1;
        end
    end
else
    for i=1:ant_num
        OneOfPath=all_ant_path((i-1)*task_number+1:(i-1)*task_number+task_number,:);
        [row,col]=find(OneOfPath==1);
        if(length(col)-length(unique(col)) == 0)
            for j=1:length(row)
                
                
                SumOfDistance(i)=SumOfDistance(i)+sqrt( (Robot_position(j,1)-Target_position(row(j),1))^2 ...
                    + (Robot_position(j,2)-Target_position(row(j),2))^2) / UAV_speed(j);
            end
        end
        %ite= ite+1;
    end
end



%display(SumOfDistance);
[min_distance,ind]=min(SumOfDistance(find(SumOfDistance~=0)));
if (isempty(min_distance) ==0)
    %min_distance = min(SumOfDistance);
    index=find(SumOfDistance==min_distance);
    %display(index)
    choice = index(unidrnd(size(index,1)));
    %display(choice);
    best_ant_path = all_ant_path((choice-1)*task_number+1:(choice-1)*task_number+task_number,:);
end
end