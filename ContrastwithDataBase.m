function [Score,SmallScore,LargeScore] = ContrastwithDataBase(TempDatabase,FindingTable,Order)
l=length(FindingTable);
for i=1:l
    NumofFigure=find(strcmp({TempDatabase.Figure},FindingTable{i,1})==1);
    NumofCondition=find(cell2mat({TempDatabase.Condition})==FindingTable{i,2});
    NumforCondition=intersect(NumofFigure,NumofCondition);
    if(~isempty(NumforCondition))
        Result=cell2mat({TempDatabase(NumforCondition).Result});
        FR=find(cell2mat(Order(i).Table(1,:))>Result);
        if(isempty(FR))
            if(Result>Order(i).TopL)
                Score(i)=1;
            elseif(Result>Order(i).UpperL)
                Score(i)=0.75;
            elseif(Result>Order(i).MedianL)
                Score(i)=0.5;
            elseif(Result>Order(i).LowerL)
                Score(i)=0.25;
            end
        else
            if(FR(end)~=length(Order(i).Table))
                Score(i)=(cell2mat(Order(i).Table(3,FR(end)))+cell2mat(Order(i).Table(3,FR(end)+1)))/2;
            else
                Score(i)=0;
            end
        end
    else
        Score(i)=-1;
    end
    if((~isempty(NumforCondition))&&(FindingTable{i,4}==1))
        
        Result=cell2mat({TempDatabase(NumforCondition).Result});
        FR=find(cell2mat(Order(i).Table(1,:))>Result);
        if(isempty(FR))
            if(Result>Order(i).TopL)
                SmallScore(i)=1;
            elseif(Result>Order(i).UpperL)
                SmallScore(i)=0.75;
            elseif(Result>Order(i).MedianL)
                SmallScore(i)=0.5;
            elseif(Result>Order(i).LowerL)
                SmallScore(i)=0.25;
            end
        else
            if(FR(end)~=length(Order(i).Table))
                SmallScore(i)=(cell2mat(Order(i).Table(3,FR(end)))+cell2mat(Order(i).Table(3,FR(end)+1)))/2;
            else
                SmallScore(i)=0;
            end
        end
    else
        SmallScore(i)=-1;
    end
    if((~isempty(NumforCondition))&&(FindingTable{i,4}==3))
        
        Result=cell2mat({TempDatabase(NumforCondition).Result});
        FR=find(cell2mat(Order(i).Table(1,:))>Result);
        if(isempty(FR))
            if(Result>Order(i).TopL)
                LargeScore(i)=1;
            elseif(Result>Order(i).UpperL)
                LargeScore(i)=0.75;
            elseif(Result>Order(i).MedianL)
                LargeScore(i)=0.5;
            elseif(Result>Order(i).LowerL)
                LargeScore(i)=0.25;
            end
        else
            if(FR(end)~=length(Order(i).Table))
                LargeScore(i)=(cell2mat(Order(i).Table(3,FR(end)))+cell2mat(Order(i).Table(3,FR(end)+1)))/2;
            else
                LargeScore(i)=0;
            end
        end
    else
        LargeScore(i)=-1;
    end
    
end
Score=sum(double(Score~=-1).*Score)/(sum(Score~=-1));
SmallScore=sum(double(SmallScore~=-1).*SmallScore)/(sum(SmallScore~=-1));
LargeScore=sum(double(LargeScore~=-1).*LargeScore)/(sum(LargeScore~=-1));



end

