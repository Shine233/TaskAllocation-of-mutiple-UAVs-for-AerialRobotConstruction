function [All_Best_Strategy] = HungarianAlgorithm(Cost)

% Check if the cost matrix is eligible
[m,n]=size(Cost);

if (m ~= n)
    error('HUNGARIAN: Cost matrix must be square!');
end

Size_Cost = m;
% Save original cost matrix.
orig=Cost;

%% Pre-process the cost matrix
minOfRow = min(Cost');
Row = repmat(minOfRow',1, Size_Cost);
Cost = Cost - Row;
minOfCol = min(Cost);
column = repmat(minOfCol, Size_Cost, 1);
Cost = Cost - column;

% Fine the minimum  number of lines to cover all '0's
[RowCoverNum, ColCoverNum, TotalCoverNum] = ZeroCoverMethod(Cost);

%% Test for optimality
% If the minimum number of covering lines is the sames the size of cost
% matrix which is 'Size_Cost', an optimal assignment of zeros is possible
% and the algorithm is completed. Otherwise, Run the following loop until
% reach optimal situation.
while TotalCoverNum ~= Size_Cost
    Temp_Cost=Cost;
    Temp_Cost(RowCoverNum,:)=[];
    Temp_Cost(:,ColCoverNum)=[];
    
    % Determine the smallest entry not covered by any line
    m=min(min(Temp_Cost));
    
    % Add the minimum uncovered element to every covered element. If an
    % element is covered twice, add the minimum element to it twice.
    Cost(RowCoverNum,:)=Cost(RowCoverNum,:)+m;
    Cost(:,ColCoverNum)=Cost(:,ColCoverNum)+m;
    
    % Subtract this entry from every element in the matrix.
    m_all=min(min(Cost));
    Cost=Cost-m_all;
    
    % Cover the zero elements again
    [RowCoverNum, ColCoverNum, TotalCoverNum] = ZeroCoverMethod(Cost);
end


%% Find the best allocation strategy
% Store all possible allocation strategy
[ind_row, ind_col] = find(Cost == 0);

valueofCol = zeros(Size_Cost, Size_Cost);
for i= 1 : Size_Cost
    % Store the number of zeros in each row
    numofzeroRow(i) =  length(find(ind_row == i));
    % Store the column index of zeros in each row
    valueofCol(i,[1:numofzeroRow(i)])= ind_col(find(ind_row == i))';
end


% Store all possible allocation strategy
All_strategy = fullfact(numofzeroRow);
Size_All = size(All_strategy,1);

for i = 1: Size_All
    for j = 1: Size_Cost
        All_strategy(i,j) = valueofCol(j, All_strategy(i,j));
    end
end

% Find the rational solutions
n = 1;
for i = 1: Size_All
    if (length(All_strategy(i,:))-length(unique(All_strategy(i,:)))) == 0
        All_Best_Strategy(n,:) = All_strategy(i,:);
        n = n + 1;
    end
end

end