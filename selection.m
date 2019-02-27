function [abledGates,indInsert]=selection(i1,arrTime,depTime)
%%判断第i1个航班有哪些登机口可以使用（考虑时间因素）
%%返回可用登机口及其对应的航班时间插入点0-t,t+1-~

global match;
global gatesTime;
indSame=find(match(i1,:)==1);
indInsert=[];abledGates=[];
for j=1:size(indSame,2)
    for k=1:2:size(gatesTime{indSame(j)},1)
        try
        if(gatesTime{indSame(j)}(k)<=arrTime&&gatesTime{indSame(j)}(k+1)>=depTime)
            indInsert=[indInsert;k+1];
            abledGates=[abledGates;indSame(j)];
            break;
        end
        catch
            j
        end
    end
end