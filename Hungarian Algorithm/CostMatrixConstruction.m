function [Cost]=CostMatrixConstruction(Robot_position,Target_position,worker_number,task_number)

Cost=zeros(worker_number, task_number);

for i=1:size(Robot_position,1)
    for j=1:size(Target_position,1)
        % Since the HungarianAlgorithm is Mixed-Integer Linear Programming,
        % so the cost is the square of the distance in this case.
        Cost(i,j)= (Robot_position(i,1)-Target_position(j,1))^2 ...
            + (Robot_position(i,2)-Target_position(j,2))^2;       
    end 
end

end