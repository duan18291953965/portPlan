function checkRes=check(res)
%���һ��ƥ�������Ƿ����Լ��
%ƥ������Ϊa��i������i������ĵǻ���Ϊa��i��
%����1Ϊ���ϣ�0������
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
        arriveTime=pucks(i,3);%%��¼����ʱ�䣬�������޸�
        departTime=pucks(i,4)+45;%%��¼�뿪ʱ�䣬�������޸�
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
