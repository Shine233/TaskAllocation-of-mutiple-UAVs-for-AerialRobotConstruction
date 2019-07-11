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

%% Construct the cost matrix
Cost=CostMatrixConstruction(Robot_position,Target_position,worker_number,task_number);

%% Hungarian Algorithm
Best_Strategy = HungarianAlgorithm(Cost);

%% Display the task allcocation strategy
Draw_Strategy(Robot_position,Target_position,Best_Strategy);
