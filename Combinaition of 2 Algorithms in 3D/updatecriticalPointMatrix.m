function [criticalPointMatrix]=updatecriticalPointMatrix(pheromoneMatrix,worker_number,task_number,ant_num)

for i=1:task_number
    max_number=max(pheromoneMatrix(i,:));
    total=sum(pheromoneMatrix(i,:));
    k=max_number/total;
    criticalPointMatrix(i)=ceil(k*ant_num);
end

end
