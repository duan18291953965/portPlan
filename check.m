function checkRes=check(res)
%检查一个匹配序列是否符合约束
%匹配序列为a（i），第i个航班的登机口为a（i）
%返回1为符合，0不符合
global pucks;
global gates;
global gatesTime;
global match;
for i=1:size(gates,1)
    gatesTimeTemp{i}=[0;4000];
end
right=0;
testRight=0;

for i=1:size(res,1)
    curGate=res(i);
    if(curGate~=0&&match(i,res(i))==1)
        arriveTime=pucks(i,3);%%记录到达时间，可能需修改
        departTime=pucks(i,4)+45;%%记录离开时间，可能需修改
        for k=1:2:size(gatesTimeTemp{curGate},1)
            if(gatesTimeTemp{curGate}(k)<=arriveTime&&gatesTimeTemp{curGate}(k+1)>=departTime)
                right=right+1;
            end
        end
        gatesTimeTemp{res(i)}=sort([gatesTimeTemp{curGate};arriveTime;departTime]);
        testRight=testRight+1;
    end  
end
if(testRight==right)
    checkRes=1;
else
    checkRes=0;
end
