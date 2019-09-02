function [best_ant_path,min_distance,min_time,Best_path] = find_best_ant_path(all_ant_path,worker_number,task_number,...
    ant_num,Robot_position,Target_position, UAV_speed, ant_num_PP, iteratornum_PP)

% Define the calculated distance
SumOfDistance=zeros(ant_num,1);
SumOfTimeUsed = zeros(ant_num,worker_number);

% Calculate the distance between robots and targets positions, and then
% compare them to find the best task allocation strategy
%ite = 1;
All_strategy_path = zeros(task_number,worker_number,ant_num);
for i=1:ant_num
    
    OneOfPath=all_ant_path((i-1)*task_number+1:(i-1)*task_number+task_number,:);
    [row,col]=find(OneOfPath==1);
    for j=1:worker_number
        
        %         display(OneOfPath)
        %         display(col)
        %         display(row)
        
        SizeOfSubMap = length (find(col==j));
        UAV_contained = find(col==j);
        Map(1,:) = Robot_position (j,:);
        Map_index(1)=0;
        for k = 2 : (SizeOfSubMap+1)
            Map(k,:) = Target_position( row(UAV_contained(k-1)),:);
            Map_index(k-1)= row(UAV_contained(k-1));
        end
        [Shortest_Route, Shortest_Length,travelled_time] = AntColonyPathPlanning (Map, ...
            ant_num_PP, iteratornum_PP, UAV_speed(j), Map_index);
        if (isempty(Shortest_Route) == 0)
            All_strategy_path(1:length(Shortest_Route),j,i)=Shortest_Route';
        end
        SumOfDistance(i) = SumOfDistance(i) + Shortest_Length;
        SumOfTimeUsed(i,j) = SumOfTimeUsed(i,j) + travelled_time;
        Map = [];
    end
    %ite= ite+1;
end

%display(SumOfDistance);
[min_distance,ind]=min(SumOfDistance(find(SumOfDistance~=0)));
if (isempty(min_distance) == 0)
    %min_distance = min(SumOfDistance);
    index=find(SumOfDistance==min_distance);
    %display(index)
    choice = index(unidrnd(size(index,1)));
    min_time = SumOfTimeUsed(choice,:);
    Best_path = All_strategy_path(:,:,choice);
    %display(choice);
    best_ant_path = all_ant_path((choice-1)*task_number+1:(choice-1)*task_number+task_number,:);
end
end