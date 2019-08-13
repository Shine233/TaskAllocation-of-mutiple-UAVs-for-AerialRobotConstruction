function [RowCoverNum, ColCoverNum, TotalCoverNum] = ZeroCoverMethod(Cost)

% RowCoverNum is the minimum numder covered by '0's;
% ColCoverNum is the minimum numder covered by '0's ;
% TotalCoverNum = RowCoverNum + ColCoverNum;

[ind_row, ind_col] = find(Cost == 0);
row=unique(ind_row);
col=unique(ind_col);
minRandC = min(length(row),length(col));

RowCoverNum=[];
ColCoverNum=[];

for i= 1: minRandC
    judge1 = 0;
    
    for j = 0 : i
        judge2=0;
        
        comb_row=nchoosek(row,j);
        [num_comb_row,~]=size(comb_row);
        
        j=i-j;
        comb_col=nchoosek(col,j);
        [num_comb_col,~]=size(comb_col);
        
        % Delete rows or columns or both and check if there are zeros
        % remaining. If yes, which means not all the zeros are coverd, the
        % covered rows and columns need to be re-determined
        if j ==0
            for d = 1:num_comb_col
                Temp_Cost=Cost;
                
                Temp_Cost(:,comb_col(d,:))=[];
                if min(min(Temp_Cost))~=0
                    RowCoverNum=[];
                    ColCoverNum=comb_col(d,:);
                    judge2=1;
                    break;
                end
            end
        else 
            for c = 1 : num_comb_row
                judge3 = 0;
                if min(size(comb_col))==0 
                    Temp_Cost=Cost;
                    Temp_Cost(comb_row(c,:),:)=[];
                    if min(min(Temp_Cost))~=0
                        RowCoverNum=comb_row(c,:);
                        ColCoverNum=[];
                        judge2=1;
                        break;
                    end
                else
                    for d = 1:num_comb_col
                        Temp_Cost=Cost;
                        Temp_Cost(comb_row(c,:),:)=[];
                        Temp_Cost(:,comb_col(d,:))=[];
                        if min(min(Temp_Cost))~=0
                            RowCoverNum=comb_row(c,:);
                            ColCoverNum=comb_col(d,:);
                            judge3=1;
                            break;
                        end
                    end
                end
                if judge3 ==1
                    judge2 = 1;
                    break;
                end
            end
        end
        if judge2 == 1
            judge1 = 1;
            break;
        end
    end
    if judge1 ==1
        break;
    end
    
end

TotalCoverNum = length(RowCoverNum)+length(ColCoverNum);

end

