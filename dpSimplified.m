function res=dpSimplified(i1,res,singleRes)
%�����i
%iΪ��i������
global pucks;
global gates;
global usedGates;
global minGates;
global tempGates;
global gatesTime;
global match;

if(i1>=size(pucks,1))%��������
    minGates=min(minGates,sum(usedGates));
    res=[res;singleRes];
    return;
end
arriveTime=pucks(i1,3);%%��¼����ʱ�䣬�������޸�
departTime=pucks(i1,4)+45;%%��¼�뿪ʱ�䣬�������޸�
clear abledGates;clear indInsert;
[abledGates,indInsert]=selection(i1,arriveTime,departTime);%%Ѱ��ʹ�ù�������ʱ���Ϻ��ʵĵǻ��ڣ����޸ģ�������������
if(size(abledGates,1)==0)
    tempGates=tempGates+1;
    singleRes=[singleRes,0];
    res=dpSimplified(i1+1,res,singleRes);
    tempGates=tempGates-1;
    singleRes(size(singleRes,1))=[];
end
for j=1:min(size(abledGates,1),1)
%     for j=1:size(indAbledUnusedGates,1)%%ѭ�����е�δʹ�õĵǻ���
    gatesTime{abledGates(j)}=sort([gatesTime{abledGates(j)};arriveTime;departTime]);
    singleRes=[singleRes,abledGates(j)];
    res=dpSimplified(i1+1,res,singleRes);
    gatesTime{abledGates(j)}(gatesTime{abledGates(j)}==arriveTime)=[];
    gatesTime{abledGates(j)}(gatesTime{abledGates(j)}==departTime)=[];
    singleRes(size(singleRes,2))=[];
    %%������ǰ����ʹ�õǻ��ڼ�¼��״̬
end



end