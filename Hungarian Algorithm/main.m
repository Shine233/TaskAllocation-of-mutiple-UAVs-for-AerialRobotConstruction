clc;
clear;
%% initialization

% Define the position of the robots
% % Robot_position=[1,2;1,4;1,6;1,8;1,10];
% UAV_position=[5,7;3,2;7,13;6,9;5,5];
UAV_position = [70,69;89,25;86,45];
% % Define the target positions
% Target_position=[3,6;5,4;5,6;5,8;8,6];
Target_position = [80,63;22,49;61,40];

% Random position
UAV_number=3; % The number of UAVs
task_number=3; % The number of Target positions
SizeofMap = [1 100];
size_UAV = 0;
size_task = 0;
 
% while (size_UAV<UAV_number && size_task < task_number)
%     UAV_position = randi(SizeofMap,UAV_number,2);
%     Target_position = randi(SizeofMap,task_number,2);
%     % UAV_position = unique(UAV_position,'rows');
%     % Target_position = unique(Target_position,'rows');
%     size_UAV = size(unique(UAV_position,'rows'),1);
%     size_task = size(unique(Target_position,'rows'),1);
% end


% Initial the speed of UAVs
UAV_speed=ones(UAV_number,1)*50;

%% Construct the cost matrix
% while( task_number >= UAV_number)
judge = 1;
while (isempty(Target_position) == 0)
    
    if (judge == 1)
        Cost=CostMatrixConstruction(UAV_position,Target_position,UAV_number,UAV_speed,task_number);
        
        %% Hungarian Algorithm
        Best_Strategy = HungarianAlgorithm(Cost);
        % find the allocation method for at that moment
        Best_Strategy=Best_Strategy(:,1:UAV_number);
        Best_Strategy = unique(Best_Strategy,'rows');
        if (size(Best_Strategy,1)>1)
            Best_Strategy = Best_Strategy( randi(size(Best_Strategy,1)) ,:);
        end
    end
    
    %Target_position_new = Target_position;
    
    [Target_position,task_number] = Update_Strategy(Best_Strategy,UAV_number,task_number, UAV_position,...
        Target_position);%, Target_position_new);
    
    % Calculate the step distance between per second
    %for i= 1: size(Best_Strategy,1)
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
    % end
    
    
    
    % task_number = task_number - UAV_number;
    
    
    %% 多种分配策略，需要三维矩阵
    % for i = 1: size(Best_Strategy,1)
    %         Target_position_new(:,:,i) = Target_position;
    % end
    % Best_Strategy = Update_Strategy(Best_Strategy,UAV_number,task_number, UAV_position,...
    %     Target_position, Target_position_new);
    
    % Calculate the step distance between per second
    % for i= 1: size(Best_Strategy,1)
    %     for j =1: size(Best_Strategy,2)
    %         difference(j,:,i)=Target_position(Best_Strategy(i,j),:)-UAV_position(j,:);
    %         if (difference(j,1,i)==0)
    %             angle(j,i)= pi/2;
    %         else
    %             angle(j,i)= atan(difference(j,2,i)/difference(j,1,i));
    %         end
    %     end
    % end
    %
    % for i= 1: size(Best_Strategy,1)
    %     for j= 1: size(Best_Strategy,2)
    %         if (difference(j,1,i) > 0)
    %             UAV_step(j,1,i)= UAV_speed(j)*cos(angle(j,i));
    %             UAV_step(j,2,i)= UAV_speed(j)*sin(angle(j,i));
    %         elseif(difference(j,1,i) < 0)
    %             UAV_step(j,1,i)= -UAV_speed(j)*cos(angle(j,i));
    %             UAV_step(j,2,i)= -UAV_speed(j)*sin(angle(j,i));
    %         elseif ((difference(j,1,i) == 0)&& (difference(j,2,i) > 0))
    %             UAV_step(j,1,i)= UAV_speed(j)*cos(angle(j,i));
    %             UAV_step(j,2,i)= UAV_speed(j)*sin(angle(j,i));
    %         elseif ((difference(j,1,i) == 0)&& (difference(j,2,i) < 0))
    %             UAV_step(j,1,i)= - UAV_speed(j)*cos(angle(j,i));
    %             UAV_step(j,2,i)= - UAV_speed(j)*sin(angle(j,i));
    %         end
    %     end
    % end
    
    %% Display the task allcocation strategy
    % test=zeros(3,2);
    [UAV_position_new,Target_position_new,task_number] = Draw_Strategy(UAV_position,Target_position,Best_Strategy, SizeofMap, UAV_step, UAV_speed, task_number);
    UAV_position = UAV_position_new;
    %Target_position = Target_position_new;
    
    if (isempty(Target_position_new) == 1)
        break;
    end
    
    if (size(Target_position,1) > size(Target_position_new,1))
        Target_position = Target_position_new;
        judge =1;
    else
        judge = 0;
    end
    
end