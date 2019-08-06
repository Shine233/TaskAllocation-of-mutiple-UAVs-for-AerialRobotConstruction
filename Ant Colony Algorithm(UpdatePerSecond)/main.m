clc;
clear;
%% initialization

% Define the position of the robots
% % Robot_position=[1,2;1,4;1,6;1,8;1,10];
% Robot_position=[5,7;3,2;7,13;6,9;5,5];
% % Define the target positions
% Target_position=[3,6;5,4;5,6;5,8;8,6];

% Random position
UAV_number=3; % The number of UAVs
task_number=8; % The number of Target positions
SizeofMap = [1 100];
size_UAV = 0;
size_task = 0;

while (size_UAV<UAV_number && size_task < task_number)
    UAV_position = randi(SizeofMap,UAV_number,2);
    Target_position = randi(SizeofMap,task_number,2);
    % UAV_position = unique(UAV_position,'rows');
    % Target_position = unique(Target_position,'rows');
    size_UAV = size(unique(UAV_position,'rows'),1);
    size_task = size(unique(Target_position,'rows'),1);
end

% Initial the speed of UAVs
UAV_speed=ones(UAV_number,1)*50;


% UAV_position = randi([1,15],10,2);
% Target_position = randi([1,15],10,2);

% UAV_number=5; % The number of UAVs
% task_number=5; % The number of Target positions
maxT=10; % The maximum tasks can be done by a single worker
task_fixed_number=1; % The number of workers are required for a single task
% unfinishtask_number=task_number;

ant_num=100; % The numbder of ants
iteratornum=200; % The iteration times


% pheromoneMatrix = [];% The matrix to store the pheromone
% maxPheromoneMatrix = []; % The assigned workers based on the pheromone matrix
% criticalPointMatrix = [];% This matrix is used to decide allocation by
% % using pheromone matrix or randomly
%
% % Initialize the last 3 matrix
% % The pheromone are initialized as all '1'
% pheromoneMatrix = ones(task_number,UAV_number);
% for i=1:task_number
%     % From beginning, assign the workers randomly
%     maxPheromoneMatrix(i) =unidrnd(UAV_number) ;
%     % Once the value less or equal to 1, the allocation is based on the
%     % pheromone matrix; otherwise, it is allocated randomly. For
%     % initialization, the tasks are allocated randomly.
%     criticalPointMatrix(i)=ceil(ant_num/task_number );
% end

%% The implementation of Ant Colony Algorithm
judge = 1;
while (isempty(Target_position) == 0)
    
    if (judge == 1)
        %task_number =  task_number_new;
        best_ant_path = AntColonyAlgorothm(UAV_position,Target_position,UAV_number,UAV_speed,task_number,...
            ant_num, iteratornum, maxT,task_fixed_number);
        [row,col]=find(best_ant_path==1);
        
        task_number_imme = task_number;
        for j = 1: UAV_number
            mid = find(col==j);
            if (isempty(mid) == 0)
            len = length(mid);
            allo=mid(randi(len));
            Best_Strategy(j)=allo;
            else
                Best_Strategy(j)= task_number + 1;
                task_number=task_number+1;
            end
        end
    end
    

            for j = 1:size(Best_Strategy,2)
                if(Best_Strategy(1,j) > task_number_imme)
                    %Best_Strategy_updated(i,j)=0;
                    Target_position(Best_Strategy(1,j),:) = UAV_position( j, :);
                    %task_number=task_number+1;
                end
            end

    
    
    for j =1: size(Best_Strategy,2)
        difference(j,:)=Target_position(Best_Strategy(j),:)-UAV_position(j,:);
        if (difference(j,1)==0)
            angle(j)= pi/2;
        else
            angle(j)= atan(difference(j,2)/difference(j,1));
        end
    end
    %end
    
    % for i= 1: size(Best_Strategy,1)
    for j= 1: size(Best_Strategy,2)
        if (difference(j,1) > 0)
            UAV_step(j,1)= UAV_speed(j)*cos(angle(j));
            UAV_step(j,2)= UAV_speed(j)*sin(angle(j));
        elseif(difference(j,1) < 0)
            UAV_step(j,1)= -UAV_speed(j)*cos(angle(j));
            UAV_step(j,2)= -UAV_speed(j)*sin(angle(j));
        elseif ((difference(j,1) == 0)&& (difference(j,2) > 0))
            UAV_step(j,1)= UAV_speed(j)*cos(angle(j));
            UAV_step(j,2)= UAV_speed(j)*sin(angle(j));
        elseif ((difference(j,1) == 0)&& (difference(j,2) < 0))
            UAV_step(j,1)= - UAV_speed(j)*cos(angle(j));
            UAV_step(j,2)= - UAV_speed(j)*sin(angle(j));
        end
    end
    
    [UAV_position_new,Target_position_new,task_number] = Draw_Strategy(UAV_position,Target_position,Best_Strategy, SizeofMap, UAV_step, UAV_speed, task_number);
    if (isempty(Target_position_new) == 1)
        break;
    end
    UAV_position = UAV_position_new;
    if (size(Target_position,1) > size(Target_position_new,1))
        Target_position = Target_position_new;
        judge =1;
    else
        judge = 0;
    end
    
%     task_number_imme = task_number;
%     if (task_number_imme<UAV_number)
%         for i = 1:size(Best_Strategy,1)
%             for j = 1:size(Best_Strategy,2)
%                 if(Best_Strategy(i,j) > task_number_imme)
%                     %Best_Strategy_updated(i,j)=0;
%                     Target_position(Best_Strategy(i,j),:) = UAV_position( j, :);
%                     task_number=task_number+1;
%                 end
%             end
%         end
% %     elseif (task_number==UAV_number)
% %         
% %         if (Target_position == UAV_position)
% %             Target_position =[];
% %         end
%     end
end
%     % Start iteration
%     for i=1:iteratornum
%         best_ant_path=[]; % To find the best task allocation results in each iteration
%         all_ant_path=[]; % To store the whole task allocation results in each iteration
%
%         % For each ant
%         for j=1:ant_num
%             % To count how many tasks can be accomplished
%             for p=1:UAV_number
%                 worker_quality(p)=maxT;
%             end
%
%             oneant_path=zeros(task_number,UAV_number);
%             worker_task=ones(task_number,UAV_number);
%             % Assign workers for each task
%             for k=1:task_number
%                 % Some tasks need more than 1 workers
%                 for n=1:task_fixed_number
%                     record_assign_worker=assignonetask(j,k,criticalPointMatrix,maxPheromoneMatrix,UAV_number,worker_quality);
%                     oneant_path(k,record_assign_worker)=1;
%                     worker_task(k,record_assign_worker)=0;
%                     worker_quality(record_assign_worker)=worker_quality(record_assign_worker)-1;
%
%                     % Once the worker has approached its maximum task capacity,
%                     % then, this worker cannot be assigned any task any more
%                     if worker_quality(record_assign_worker)==0
%                         worker_task(:,record_assign_worker)=0;
%                     end
%                     maxPheromoneMatrix=updatemaxPheromoneMatrix_special(pheromoneMatrix,maxPheromoneMatrix,k,record_assign_worker,worker_quality,worker_task,UAV_number,task_number);
%                 end
%             end
%             % Record all ant paths in each iteration
%             all_ant_path=[all_ant_path;oneant_path];
%         end
%         % Find the best ant path in the stored information previously, and
%         % record the corresponded travel distance of all UAVs
%         [best_ant_path, min_dist(i)]=find_best_ant_path(all_ant_path,UAV_number,task_number,ant_num,UAV_position,Target_position);
%
%         % Update the pheromone matrix and others based on the best ant path
%         pheromoneMatrix=updatePheromoneMatrix(best_ant_path, pheromoneMatrix,UAV_number,task_number);
%         maxPheromoneMatrix=updatemaxPheromoneMatrix(pheromoneMatrix,UAV_number,task_number);
%         criticalPointMatrix=updatecriticalPointMatrix(pheromoneMatrix,UAV_number,task_number,ant_num);
%     end

%% Display the task allcocation strategy
% Draw_Strategy(UAV_position,Target_position,best_ant_path, min_dist);
%end
