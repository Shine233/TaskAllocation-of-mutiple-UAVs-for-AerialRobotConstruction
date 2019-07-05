function [maxPheromoneMatrix]=updatemaxPheromoneMatrix_special(pheromoneMatrix,maxPheromoneMatrix,current_task,record_assign_worker,worker_quality,worker_task,worker_number,task_number)

% The task capacity should also be updated, once the task has already
% already be completed, then the pheromone matrix has to be updated
for j=1:task_number
    for i=1:worker_number
        if worker_task(j,i)==0
            pheromoneMatrix(j,i)=0;
        end
    end
end
% Find the column index of the maximum value in each row
[C,I]=max(pheromoneMatrix(current_task,:));
maxPheromoneMatrix(current_task)=I;

%对下面的影响进行操作
if worker_quality(record_assign_worker)==0
    for i=current_task+1:task_number
        % If the best allocation of the task is this worker, then find the 
        % next best worker
        if maxPheromoneMatrix(i)==record_assign_worker
            % Find the column index of the maximum value in each row
            [C,I]=max(pheromoneMatrix(i,:)); 
            maxPheromoneMatrix(i)=I;
        end
    end
end
end
