function [Cost]=CostMatrixConstruction(UAV_position,Target_position,UAV_number,UAV_speed,task_number)

matrix_order = max(UAV_number,task_number);

Cost=zeros(matrix_order, matrix_order);

for i=1:size(UAV_position,1)
    for j=1:size(Target_position,1)
        % Since the HungarianAlgorithm is Mixed-Integer Linear Programming,
        % so the cost is the square of the distance in this case.
%         Cost(i,j)= round( sqrt((UAV_position(i,1)-Target_position(j,1))^2 ...
%             + (UAV_position(i,2)-Target_position(j,2))^2) / UAV_speed(i) );   
        Cost(i,j)= sqrt( (UAV_position(i,1)-Target_position(j,1))^2 ...
            + (UAV_position(i,2)-Target_position(j,2))^2 )/ UAV_speed(i) ; % 找到除了0意外最小的数字，然后找出乘以多少可以让他变成整数，其他的都乘以这个数
    end 
end

% avoid UAV position is same as target position
if (min(min(Cost(Cost~=0))) < 1 )
    ratio_num = ceil( 1/ min(min(Cost(Cost~=0))));
    Cost = round ( Cost*ratio_num);
else
   Cost = round( Cost ); 
end

end