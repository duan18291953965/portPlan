%关于编译
%函数说明
%输入变量：pop：二进制种群，pm：变异概率
%输出变量：newpop变异以后的种群
function [newpop] = mutation(pop,pm)
[px,py] = size(pop);
newpop = ones(size(pop));
for i = 1:px
    if(rand<pm)
        try
            mpoint = sort(2+floor(rand(1,3)*(py-2)));
            newpop(i,:)=pop(i,[1:mpoint(1)-1,mpoint(2)+1:mpoint(3),...
                mpoint(1):mpoint(2),mpoint(3)+1:102]); %交换位置
        catch
            mpoint
        end
    else
        newpop(i,:) = pop(i,:);
    end
end
newpop=[pop;newpop];