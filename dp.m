function res=dp(i1,res,singleRes)
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
indUsed=find(usedGates==1);%%Ѱ��ʹ�ù��ĵǻ���
if(size(indUsed,1)>=1)
    clear abledGates;clear indInsert;
    [abledGates,indInsert]=selection(i1,arriveTime,departTime);
    indAbledUsedGates=indUsed(abledGates);%%Ѱ��ʹ�ù�������ʱ���Ϻ��ʵĵǻ��ڣ����޸ģ�������������
    
    for j=1:min(size(indAbledUsedGates,1),1)%%ѭ�����е���ʹ�õĵǻ���
%     for j=1:size(indAbledUsedGates,1)%%ѭ�����е���ʹ�õĵǻ���
        lastTime=gates(indUsed(j),4);%�������
        gates(indAbledUsedGates(j),4)=departTime;
        singleRes=[singleRes,indAbledUsedGates(j)];
        res=dp(i1+1,res,singleRes);
        singleRes(size(singleRes,2))=[];
        gates(indAbledUsedGates(j),4)=lastTime;%%������ǰ�ĵǻ���״̬
    end
end
indUnused=find(usedGates==0);%%Ѱ��δʹ�ù��ĵǻ���
if(size(indUnused,1)>=1)
    clear abledGates;clear indInsert;
    [abledGates,indInsert]=selection(i1,arriveTime,departTime);
    indAbledUnusedGates=indUnused(abledGates);%%Ѱ��ʹ�ù�������ʱ���Ϻ��ʵĵǻ��ڣ����޸ģ�������������
    
    for j=1:min(size(indAbledUnusedGates,1),1)
%     for j=1:size(indAbledUnusedGates,1)%%ѭ�����е�δʹ�õĵǻ���
        gatesTime{indAbledUnusedGates(j)}=sort([gatesTime{indAbledUnusedGates(j)};arriveTime;departTime]);
        usedGates(indAbledUnusedGates(j))=1;
        gates(indAbledUnusedGates(j),4)=departTime;
        singleRes=[singleRes,indAbledUnusedGates(j)];
        res=dp(i1+1,res,singleRes);
        gatesTime{indAbledUnusedGates(j)}(gatesTime{indAbledUnusedGates(j)}==arriveTime)=[];
        gatesTime{indAbledUnusedGates(j)}(gatesTime{indAbledUnusedGates(j)}==departTime)=[];
        singleRes(size(singleRes,2))=[];
        gates(indAbledUnusedGates(j),4)=lastTime;
        usedGates(indAbledUnusedGates(j))=0;%%������ǰ����ʹ�õǻ��ڼ�¼��״̬
    end
end


end

    