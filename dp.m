function res=dp(i1,res,singleRes)
%处理第i
%i为第i个航班
global pucks;
global gates;
global usedGates;
global minGates;
global tempGates;
global gatesTime;
global match;

if(i1>=size(pucks,1))%返回条件
    minGates=min(minGates,sum(usedGates));
    res=[res;singleRes];
    return;
end
arriveTime=pucks(i1,3);%%记录到达时间，可能需修改
departTime=pucks(i1,4)+45;%%记录离开时间，可能需修改
indUsed=find(usedGates==1);%%寻找使用过的登机口
if(size(indUsed,1)>=1)
    clear abledGates;clear indInsert;
    [abledGates,indInsert]=selection(i1,arriveTime,departTime);
    indAbledUsedGates=indUsed(abledGates);%%寻找使用过的且在时间上合适的登机口，需修改，加上其它条件
    
    for j=1:min(size(indAbledUsedGates,1),1)%%循环可行的已使用的登机口
%     for j=1:size(indAbledUsedGates,1)%%循环可行的已使用的登机口
        lastTime=gates(indUsed(j),4);%保存变量
        gates(indAbledUsedGates(j),4)=departTime;
        singleRes=[singleRes,indAbledUsedGates(j)];
        res=dp(i1+1,res,singleRes);
        singleRes(size(singleRes,2))=[];
        gates(indAbledUsedGates(j),4)=lastTime;%%返回以前的登机口状态
    end
end
indUnused=find(usedGates==0);%%寻找未使用过的登机口
if(size(indUnused,1)>=1)
    clear abledGates;clear indInsert;
    [abledGates,indInsert]=selection(i1,arriveTime,departTime);
    indAbledUnusedGates=indUnused(abledGates);%%寻找使用过的且在时间上合适的登机口，需修改，加上其它条件
    
    for j=1:min(size(indAbledUnusedGates,1),1)
%     for j=1:size(indAbledUnusedGates,1)%%循环可行的未使用的登机口
        gatesTime{indAbledUnusedGates(j)}=sort([gatesTime{indAbledUnusedGates(j)};arriveTime;departTime]);
        usedGates(indAbledUnusedGates(j))=1;
        gates(indAbledUnusedGates(j),4)=departTime;
        singleRes=[singleRes,indAbledUnusedGates(j)];
        res=dp(i1+1,res,singleRes);
        gatesTime{indAbledUnusedGates(j)}(gatesTime{indAbledUnusedGates(j)}==arriveTime)=[];
        gatesTime{indAbledUnusedGates(j)}(gatesTime{indAbledUnusedGates(j)}==departTime)=[];
        singleRes(size(singleRes,2))=[];
        gates(indAbledUnusedGates(j),4)=lastTime;
        usedGates(indAbledUnusedGates(j))=0;%%返回以前的已使用登机口记录的状态
    end
end


end

    