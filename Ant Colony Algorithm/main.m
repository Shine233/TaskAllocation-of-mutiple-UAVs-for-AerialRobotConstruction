clc;
clear;
%% initialization

% Define the position of the robots
% Robot_position=[1,2;1,4;1,6;1,8;1,10];
Robot_position=[5,7;3,2;7,13;6,9;5,5];
% Define the target positions
Target_position=[3,6;5,4;5,6;5,8;8,6];


worker_number=5; % The number of UAVs
task_number=5; % The number of Target positions
maxT=1; % The maximum tasks can be done by a single worker
task_fixed_number=1; % The number of workers are required for a single task
unfinishtask_number=task_number;

ant_num=50; % The numbder of ants
iteratornum=100; % The iteration times
pheromoneMatrix = [];% The matrix to store the pheromone
maxPheromoneMatrix = []; % The assigned workers based on the pheromone matrix
criticalPointMatrix = [];% This matrix is used to decide allocation by
% using pheromone matrix or randomly

% Initialize the last 3 matrix
% The pheromone are initialized as all '1'
pheromoneMatrix = ones(task_number,worker_number);
for i=1:task_number
    % From beginning, assign the workers randomly
    maxPheromoneMatrix(i) =unidrnd(worker_number) ;
    % Once the value less or equal to 1, the allocation is based on the 
    % pheromone matrix; otherwise, it is allocated randomly. For
    % initialization, the tasks are allocated randomly.
    criticalPointMatrix(i)=ceil(ant_num/task_number );
end

%% The implementation of Ant Colony Algorithm

% Start iteration
for i=1:iteratornum
    best_ant_path=[]; % To find the best task allocation results in each iteration
    all_ant_path=[]; % To store the whole task allocation results in each iteration
    
    % For each ant
    for j=1:ant_num
        % To count how many tasks can be accomplished 
        for p=1:worker_number
            worker_quality(p)=maxT;
        end
        
        oneant_path=zeros(task_number,worker_number);
        worker_task=ones(task_number,worker_number);
        % Assign workers for each task
        for k=1:task_number
            % Some tasks need more than 1 workers
            for n=1:task_fixed_number 
                record_assign_worker=assignonetask(j,k,criticalPointMatrix,maxPheromoneMatrix,worker_number,worker_quality);
                oneant_path(k,record_assign_worker)=1;
                worker_task(k,record_assign_worker)=0;
                worker_quality(record_assign_worker)=worker_quality(record_assign_worker)-1;
               
                % Once the worker has approached its maximum task capacity,
                % then, this worker cannot be assigned any task any more
                if worker_quality(record_assign_worker)==0
                    worker_task(:,record_assign_worker)=0;
                end
                maxPheromoneMatrix=updatemaxPheromoneMatrix_special(pheromoneMatrix,maxPheromoneMatrix,k,record_assign_worker,worker_quality,worker_task,worker_number,task_number);
            end
        end
        % Record all ant paths in each iteration
        all_ant_path=[all_ant_path;oneant_path];
    end
    % Find the best ant path in the stored information previously, and
    % record the corresponded travel distance of all UAVs
    [best_ant_path, min_dist(i)]=find_best_ant_path(all_ant_path,worker_number,task_number,ant_num,Robot_position,Target_position);
    
    % Update the pheromone matrix and others based on the best ant path
    pheromoneMatrix=updatePheromoneMatrix(best_ant_path, pheromoneMatrix,worker_number,task_number);
    maxPheromoneMatrix=updatemaxPheromoneMatrix(pheromoneMatrix,worker_number,task_number);
    criticalPointMatrix=updatecriticalPointMatrix(pheromoneMatrix,worker_number,task_number,ant_num);
end

%% Display the task allcocation strategy
Draw_Strategy(Robot_position,Target_position,best_ant_path, min_dist);
