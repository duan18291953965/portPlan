function [abledGates,indInsert]=selection(i1,arrTime,depTime)
%%�жϵ�i1����������Щ�ǻ��ڿ���ʹ�ã�����ʱ�����أ�
%%���ؿ��õǻ��ڼ����Ӧ�ĺ���ʱ������0-t,t+1-~

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