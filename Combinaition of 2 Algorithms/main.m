............;1,8;1,10];
% UAV_position=[5,7;3,2;7,13;6,9;5,5];
% % Define the target positions
% Target_position=[3,6;5,4;5,6;5,8;8,6];

% Random position
UAV_number=4; % The number of UAVs
task_number=5; % The number of Target positions
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

maxT=10; % The maximum tasks can be done by a single worker
task_fixed_number=1; % The number of workers are required for a single task
% unfinishtask_number=task_number;

ant_num_TA=30; % The numbder of ants in Task Allocation
ant_num_PP=30; % The numbder of ants in Path Planning
iteratornum_TA=30; % The iteration times in Task Allocation
iteratornum_PP=30; % The iteration times in Path Planning


%% The implementation of Ant Colony Algorithm
[time_cost_ant,distance_cost_ant]=AntColonyAlgorithmMethod(UAV_position,Target_position,UAV_number,UAV_speed,task_number,...
    ant_num_TA, iteratornum_TA, maxT,task_fixed_number, ant_num_PP, iteratornum_PP,SizeofMap);

%% The implementation of Hungrain Algorithm
    [time_cost_Hungrain] = HungrainAlgorithmMethod(UAV_position,Target_position,UAV_number,UAV_speed,task_number,...
    SizeofMap);
%% The implementation of Hungrain Algorithm
    [time_cost_ant_realtime] = AntColonyAlgorithmMethod_realtime(UAV_position,Target_position,UAV_number,UAV_speed,task_number,...
    ant_num_TA, iteratornum_TA, maxT,task_fixed_number, SizeofMap);

%% Comparision
figure;
type = categorical({'AntColony','Hungrain','AntColonyRT'});
time_cost = [time_cost_ant,distance_cost_ant; time_cost_ant_realtime, distance_cost_ant; time_cost_Hungrain,distance_cost_ant];

bar(type, time_cost)
xlabel('Algorithms')
ylabel('Costs')
title('Comparision between different Algorithms applied on Task Allocation')
legend('Time Cost', 'Mission Cost');
