function res=dpSimplified(i1,res,singleRes)
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
clear abledGates;clear indInsert;
[abledGates,indInsert]=selection(i1,arriveTime,departTime);%%寻找使用过的且在时间上合适的登机口，需修改，加上其它条件
if(size(abledGates,1)==0)
    tempGates=tempGates+1;
    singleRes=[singleRes,0];
    res=dpSimplified(i1+1,res,singleRes);
    tempGates=tempGates-1;
    singleRes(size(singleRes,1))=[];
end
for j=1:min(size(abledGates,1),1)
%     for j=1:size(indAbledUnusedGates,1)%%循环可行的未使用的登机口
    gatesTime{abledGates(j)}=sort([gatesTime{abledGates(j)};arriveTime;departTime]);
    singleRes=[singleRes,abledGates(j)];
    res=dpSimplified(i1+1,res,singleRes);
    gatesTime{abledGates(j)}(gatesTime{abledGates(j)}==arriveTime)=[];
    gatesTime{abledGates(j)}(gatesTime{abledGates(j)}==departTime)=[];
    singleRes(size(singleRes,2))=[];
    %%返回以前的已使用登机口记录的状态
end



end