%生成新的数据
% 除Factor GoGarch外使用
function [newData] = MakeNewData(data)
%生成新的数据
% 除Factor GoGarch外使用
[Var_lens,Var_cols]=size(data); %
for i=261:Var_lens
   for j=1: Var_cols
       tempData=data(i-260:i,j);
        mu=mean(tempData);
        epsilon=bsxfun(@minus,tempData(end,:,:),mu);
        newData(i-260,j)=epsilon;
   end
end