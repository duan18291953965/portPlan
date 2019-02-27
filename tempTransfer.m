clc,clear
res=load('Plane_Port.mat');
res=res.Plane_Port;
global pucks;
pucks=load('orgAdj.mat');
pucks=pucks.a;%保存了航班类型
for i=1:size(pucks,1)
    if strcmp(pucks(i,1),'I')
        pucks(i,1)={1};
    elseif strcmp(pucks(i,1),'D')
        pucks(i,1)={2};
    else
        pucks(i,1)={3};
    end
    if strcmp(pucks(i,2),'I')
        pucks(i,2)={1};
    elseif strcmp(pucks(i,2),'D')
        pucks(i,2)={2};
    else
        pucks(i,2)={3};
    end
end
pucks=cell2mat(pucks);
[~,indSort]=sort(pucks(:,3));
pucks=pucks(indSort,:);
airtype=load('airtype.mat');
airtype=airtype.A;
airtype=airtype+1;
pucks=[pucks,airtype];
% 得到的pucks为：
% 第一列是到达类型，1为I，2为D，3为I和D
% 第二列是出发类型
% 第三列是到达时间，以此为顺序从小到大排列
% 第四列是出发时间
% 第五列是机体类别，1为N，2为W
global gates;
gates=load('Gates.mat');
gates=gates.b;%保存了登机口的类型

for i=1:size(gates,1)
    if strcmp(gates(i,4),'I')
        gates(i,4)={1};
    elseif strcmp(gates(i,4),'D')
        gates(i,4)={2};
    else
        gates(i,4)={3};
    end
    
    if strcmp(gates(i,5),'I')
        gates(i,5)={1};
    elseif strcmp(gates(i,5),'D')
        gates(i,5)={2};
    else
        gates(i,5)={3};
    end
    
    if strcmp(gates(i,6),'N')
        gates(i,6)={1};
    else
        gates(i,6)={2};
    end
end
gates(:,1)=[];
gates(:,2)=[];
gates(:,1)=[];
gates=cell2mat(gates);
% 得到的gates为：
% 第一列是到达类型，1为I，2为D，3为I和D
% 第二列是出发类型
% 第三列是机体类别，1为N，2为W

% gatesTime为cell数组，每一行第一个存储了时间信息
% 时间信息每两个数一组，代表这两个数之间的时间段可用
global gatesTime;
for i=1:size(gates,1)
    gatesTime{i}=[0;4000];
end

global match;
match=load('match.mat');
match=match.Match;%%保存航班与登机口的匹配信息（国内国际，机型），1为匹配，0不匹配
nFlightsOfGates=sum(match,1);
[gatesRank,indRankGates]=sort(nFlightsOfGates);%indRankGates为登机口从坏到好

global usedGates;
usedGates=zeros(size(gates,1),1);%%保存使用的登机口编号，0为未使用，1为使用
global minGates;
minGates=size(gates,1);

global tempGates;
tempGates=0;


right=0;
testRight=0;

for i=1:size(res,1)
    curGate=res(i);
    if(curGate~=0)
        arriveTime=pucks(i,3);%%记录到达时间，可能需修改
        departTime=pucks(i,4)+45;%%记录离开时间，可能需修改
        for k=1:2:size(gatesTime{curGate},1)
            if(gatesTime{curGate}(k)<=arriveTime&&gatesTime{curGate}(k+1)>=departTime)
                right=right+1;
            end
        end
        gatesTime{res(i)}=sort([gatesTime{curGate};arriveTime;departTime]);
        testRight=testRight+1;
    end  
end

optionalFlight=[];optionalGates=[];
indWithoutConsider=find(res==0);
for i=1:size(pucks,1)
    if(size(find(indWithoutConsider==i),1)==0)
        indGates=find(match(i,:)==1);
        arriveTime=pucks(i,3);
        departTime=pucks(i,4)+45;
        for j=1:size(indGates,2)%登机口序号为indGates(j)
            curGate=indGates(j);
            for k=1:2:size(gatesTime{curGate},1)
                if(gatesTime{curGate}(k)<=arriveTime&&gatesTime{curGate}(k+1)>=departTime)
                    optionalFlight=[optionalFlight;i];
                    optionalGates=[optionalGates;curGate];
                end
            end
        end
    end
end

abandonPucks=[];
abandonMatch=[];
for i=1:size(indWithoutConsider,1)
    curFlightInd=indWithoutConsider(i);
    abandonPucks=[abandonPucks;pucks(curFlightInd,:)];
    abandonMatch=[abandonMatch;sum(match(curFlightInd,:))];
end

indConsider=find(res~=0);
considerPucks=[];
considerMatch=[];
for i=1:size(indConsider,1)
    curFlightInd=indConsider(i);
    considerPucks=[considerPucks;pucks(curFlightInd,:)];
    considerMatch=[considerMatch;sum(match(curFlightInd,:))];
end

tempRes=[];
for i=1:size(indConsider,1)
    for j=1:size(indWithoutConsider,1)
        tempRes=res;
        curGates=tempRes(indConsider(i));
        tempRes(indConsider(i))=0;
        tempRes(indWithoutConsider(j))=curGates;
        exchangeAble=[];
        if(check(tempRes)==1)
            exchangeAble=[exchangeAble;[indConsider(i),indWithoutConsider(j)]];
        end
    end
end
        
        
        
        