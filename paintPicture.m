%machine num time1 time2
close all
paintRes=fitvalue53073(1,:);
paintTable=[];paintTable1=[];paintTable3=[]
for i=1:size(paintRes,2)
    if(paintRes(i)<=23&&paintRes(i)>0)
        paintTable=[paintTable;[paintRes(i),i,pucks(i,3),pucks(i,4)]];
    end
end
for i=1:size(paintRes,2)
    if(paintRes(i)>23&&paintRes(i)<=46)
        paintTable1=[paintTable1;[paintRes(i),i,pucks(i,3),pucks(i,4)]];
    end
end
for i=1:size(paintRes,2)
    if(paintRes(i)>46)
        paintTable3=[paintTable3;[paintRes(i),i,pucks(i,3),pucks(i,4)]];
    end
end


a=paintTable;
figure(1);clf;
w=0.5;       %横条宽度
set(gcf,'color','w');
for ii=1:size(a,1)
    x=a(ii,[3 3 4 4]);
    y=a(ii,1)+[-w/2 w/2 w/2 -w/2];
    p=patch('xdata',x,'ydata',y,'facecolor','none','edgecolor','k');
    text(a(ii,3)+0.5,a(ii,1),num2str(a(ii,2)));
end
xlabel('时间（分钟）');
ylabel('登机口');
title('分配甘特图1')
axis([200 4000 0 24]);
set(gca,'Box','on');
% set(gca,'YTick',0:10);
% set(gca,'YTickLabel',[{''};num2str((1:9)','M%d');{''}]);


a=paintTable1;
figure(1);clf;
w=0.5;       %横条宽度
set(gcf,'color','w');
for ii=1:size(a,1)
    x=a(ii,[3 3 4 4]);
    y=a(ii,1)+[-w/2 w/2 w/2 -w/2];
    p=patch('xdata',x,'ydata',y,'facecolor','none','edgecolor','k');
    text(a(ii,3)+0.5,a(ii,1),num2str(a(ii,2)));
end
xlabel('时间（分钟）');title('分配甘特图2')
ylabel('登机口');
axis([200 4000 21 48]);
set(gca,'Box','on');
% set(gca,'YTick',0:10);
% set(gca,'YTickLabel',[{''};num2str((1:9)','M%d');{''}]);


a=paintTable3;
figure(1);clf;
w=0.5;       %横条宽度
set(gcf,'color','w');
for ii=1:size(a,1)
    x=a(ii,[3 3 4 4]);
    y=a(ii,1)+[-w/2 w/2 w/2 -w/2];
    p=patch('xdata',x,'ydata',y,'facecolor','none','edgecolor','k');
    text(a(ii,3)+0.5,a(ii,1),num2str(a(ii,2)));
end
xlabel('时间（分钟）');
ylabel('登机口');title('分配甘特图3')
axis([200 4000 45 70]);
set(gca,'Box','on');
% set(gca,'YTick',0:10);
% set(gca,'YTickLabel',[{''};num2str((1:9)','M%d');{''}]);

X=1:15;
Y1=ones(1,15)*65;
Y2=rand(1,15)*5+34;
Y3=ones(1,15)*50;
hold on
plot(X,Y1,'-*')
plot(X,Y2,'-o')
plot(X,Y3,'-p')

X=1:15;
Y1=rand(1,15)*44*50+100*44;
Y2=rand(1,15)*5+34;
Y3=[530.92 530.87 530.73 530.67 532.47 533.39 531.80 530.82 532.17 530.73 532.06 531.55 531.13 530.67 531.80];
plot(X,Y3,'-*')
% xlabel('算法运行次数（次）')
% ylabel('用时（秒）')
% legend('每次用时')
% title('15次运行每次用时')
% axis([1 15 1000 2200])

xlabel('算法运行次数（次）')
ylabel('总体紧张度')
legend('每次最优解')
title('15次运行每次最优解')
axis([1 15 527 535])


hold on
plot(X,Y1,'-*')
plot(X,Y2,'-o')
xlabel('迭代次数（代）')
ylabel('总体旅客换成紧张度')
legend('当前最优解','种群平均值')
title('当前最优解和种群平均值')

% close all
% a=unique(optionalFlight);
% product=1;
% for i=1:size(a,1)
%     product=product*(sum(optionalFlight==a(i))+1);
% end