function [pheromoneMatrix]=updatePheromoneMatrix(best_ant_path, pheromoneMatrix,worker_number,task_number)

p=0.5;

q=2;

% the whole pheromone decrease
for i=1:worker_number
      for j=1:task_number
            pheromoneMatrix(j,i)=pheromoneMatrix(j,i)*p;
      end
end

% The pheromone of best path increase
sizeOf_best_ant_path=size(best_ant_path);
[row,col]=find(best_ant_path==1);
for i=1:sizeOf_best_ant_path(1)
      %pheromoneMatrix(best_ant_path(i,2),best_ant_path(i,1))=pheromoneMatrix(best_ant_path(i,2),best_ant_path(i,1))*q;
      pheromoneMatrix(row(i),col(i))=pheromoneMatrix(row(i),col(i))*q;
end

end
