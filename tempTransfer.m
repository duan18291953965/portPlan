clc,clear
res=load('Plane_Port.mat');
res=res.Plane_Port;
global pucks;
pucks=load('orgAdj.mat');
pucks=pucks.a;%�����˺�������
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
% �õ���pucksΪ��
% ��һ���ǵ������ͣ�1ΪI��2ΪD��3ΪI��D
% �ڶ����ǳ�������
% �������ǵ���ʱ�䣬�Դ�Ϊ˳���С��������
% �������ǳ���ʱ��
% �������ǻ������1ΪN��2ΪW
global gates;
gates=load('Gates.mat');
gates=gates.b;%�����˵ǻ��ڵ�����

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
% �õ���gatesΪ��
% ��һ���ǵ������ͣ�1ΪI��2ΪD��3ΪI��D
% �ڶ����ǳ�������
% �������ǻ������1ΪN��2ΪW

% gatesTimeΪcell���飬ÿһ�е�һ���洢��ʱ����Ϣ
% ʱ����Ϣÿ������һ�飬������������֮���ʱ��ο���
global gatesTime;
for i=1:size(gates,1)
    gatesTime{i}=[0;4000];
end

global match;
match=load('match.mat');
match=match.Match;%%���溽����ǻ��ڵ�ƥ����Ϣ�����ڹ��ʣ����ͣ���1Ϊƥ�䣬0��ƥ��
nFlightsOfGates=sum(match,1);
[gatesRank,indRankGates]=sort(nFlightsOfGates);%indRankGatesΪ�ǻ��ڴӻ�����

global usedGates;
usedGates=zeros(size(gates,1),1);%%����ʹ�õĵǻ��ڱ�ţ�0Ϊδʹ�ã�1Ϊʹ��
global minGates;
minGates=size(gates,1);

global tempGates;
tempGates=0;


right=0;
testRight=0;

for i=1:size(res,1)
    curGate=res(i);
    if(curGate~=0)
        arriveTime=pucks(i,3);%%��¼����ʱ�䣬�������޸�
        departTime=pucks(i,4)+45;%%��¼�뿪ʱ�䣬�������޸�
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
        for j=1:size(indGates,2)%�ǻ������ΪindGates(j)
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
        
        
        
        