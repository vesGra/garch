% Factor
clc;
numfactors=3;
p=1;
o=0;
q=1;
Var_startIndex=2349; % 
%data&w
Alternative_w=[1/5;1/5;1/5;1/5;1/5];
ww=Alternative_w;
data=Alternative_LP;
Equity_w=[1/3;1/3;1/3];
%ww=Equity_w;
%data=Equity_LP;
[Var_lens,Var_cols]=size(data); %
mdata=data(2:Var_startIndex,:);
k=Var_cols;
% 1
% new data 
newData=[];
for i=260:Var_lens
   for j=1: Var_cols
       tempData=data(i-259:i,j);
        Cov_PF=cov(tempData);  
        mu=mean(tempData);
        epsilon=bsxfun(@minus,tempData(end,:,:),mu);
        newData(i-259,j)=epsilon;
   end
end
%[parameters,ll,Ht,VCV,scores] = gogarch(newData,1,1);%(newData,numfactors,p,o,q);

for i=Var_lens-260-261:Var_lens-260
    index=i-(Var_lens-260-262);
    Alternative_Result_Gogarch11(index)=sqrt(ww'*Ht(:,:,i)*ww);
end
 
