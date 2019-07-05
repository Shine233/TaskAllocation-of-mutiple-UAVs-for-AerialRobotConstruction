function [assign_worker]=assignonetask(antCount, taskCount,...
    criticalPointMatrix, maxPheromoneMatrix, worker_number, worker_quality)
% If the antCount is smaller or equal to 'criticalPointMatrix(taskCount)',
% then the task is allocated based on the pheoromone matrix; otherwise, the
% task is assigned randomly

if antCount<=criticalPointMatrix(taskCount)
    assign_worker=maxPheromoneMatrix(taskCount);
else
    
   while 1~=0
       k=unidrnd(worker_number);
       if worker_quality(k)~=0
        assign_worker=k;
        break;
       end
   end
   
end
end
