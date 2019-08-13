function [maxPheromoneMatrix]=updatemaxPheromoneMatrix(pheromoneMatrix,worker_number,task_number)

for i=1:task_number
    % Find the column index of the maximum value in each row
    [C,I]=max(pheromoneMatrix(i,:)); 
    maxPheromoneMatrix(i)=I;  
end

end
