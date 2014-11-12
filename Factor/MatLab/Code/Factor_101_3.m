% Factor
clc;
numfactors=5;
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
%[PARAMETERS,HT,W,PC]= o_mvgarch(newData,numfactors,p,o,q);

 
%2
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1;  
    m2=data(i-261:i,:);
    Cov_PF=cov(m2);  
    Alternative_Result_His(index,1)=sqrt(ww'*Cov_PF*ww); % 
     m_new2=newData(i-Var_startIndex+1:i-261,:);
    [PARAMETERS,HT,W,PC]= o_mvgarch(m_new2,numfactors,p,o,q);

   Alternative_Result_Factor101(index)=sqrt(ww'*HT(:,:,end)*ww);
   disp(i);
end 


