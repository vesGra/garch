%生成新的数据

function [newData,newData_F,sigma] = MakeNewData_F(data)
%生成新的数据
%Factor GoGarch使用
[Var_lens,Var_cols]=size(data); %
for i=261:Var_lens
   for j=1: Var_cols
       tempData=data(i-260:i,j);
        mu=mean(tempData);
        sigma(i-260,j)=sqrt(var(tempData));
        newData(i-260,j)=data(i,j)-mu;
        newData_F(i-260,j)=newData(i-260,j)/sigma(i-260,j);
   end
end