%¼ÆËãPortfolioµÄStatistics
% mean£¬std£¬sharpe ratio£¬max£¬min
function [result]=Cal_Portfolio_Statistics(lp,pf,wight)
% [row,col]=size(lp);
result=[];

    result(:,1)= min(pf);
    result(:,2)= max(pf);
    result(:,3)= mean(pf);%geomean
    result(:,4)=   sqrt(portvar(lp,wight'));
    result(:,5)= result(3)/result(4);% sharpe ratio=mean/std
    result(:,6)=max(cumsum(pf*100));
