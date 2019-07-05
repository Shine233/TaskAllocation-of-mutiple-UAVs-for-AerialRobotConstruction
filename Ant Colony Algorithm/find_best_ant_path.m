function [best_ant_path,min_distance] = find_best_ant_path(all_ant_path,worker_number,task_number,ant_num,Robot_position,Target_position)

% Define the calculated distance
SumOfDistance=zeros(ant_num,1);

% Calculate the distance between robots and targets positions, and then
% compare them to find the best task allocation strategy

for i=1:ant_num
    for j=1:worker_number
        OneOfPath=all_ant_path((i-1)*5+1:(i-1)*5+5,:);
        [row,col]=find(OneOfPath==1);
        %         display(OneOfPath)
        %         display(col)
        %         display(row)
        SumOfDistance(i)=SumOfDistance(i)+sqrt( (Robot_position(j,1)-Target_position(row(j),1))^2 ...
            + (Robot_position(j,2)-Target_position(row(j),2))^2);
    end
end
%display(SumOfDistance);
min_distance = min(SumOfDistance);
index=find(SumOfDistance==min(SumOfDistance));
display(index)
choice = index(unidrnd(size(index,1)));
display(choice);
best_ant_path = all_ant_path((choice-1)*5+1:(choice-1)*5+5,:);

end