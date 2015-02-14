% 计算BasicStatistics
% 每次计算一个组合
function [result]=Cal_BasicStatistics(lp)
[row,col]=size(lp);
result=[];
for i=1:col
    result(1,i)= length(lp(:,i));
    result(2,i)= min(lp(:,i));
    result(3,i)= max(lp(:,i));
    result(4,i)= mean(lp(:,i));%geomean
    result(5,i)= std(lp(:,i));
    result(6,i)= skewness(lp(:,i));
    result(7,i)= kurtosis(lp(:,i));
end

