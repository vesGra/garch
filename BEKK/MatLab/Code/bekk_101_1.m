% bekk
% Ht(:,:,i) = C+ A(:,:,j)'*data(:,:,i-j)*A(:,:,j);+B(:,:,j)'*Ht(:,:,i-j)*B(:,:,j)
% j=1
% 取 历史数据 第九年最后一天的Ht(:,:,i-1)
% 和 log price 九年最后一天的 data(:,:,i-1)
% result_BEKK(:,:,index)= C+ A(:,:,1)'*m_new(:,:,index-1)'*m_new(:,:,index-1)*A(:,:,1)+A(:,:,2)'*m_new(:,:,index-2)'*m_new(:,:,index-2)*A(:,:,2)+...+A(:,:,j)'*m_new(:,:,index-j)'*m_new(:,:,index-j)*A(:,:,j)+B(:,:,1)'*Cov_PF(:,:,1)*B(:,:,1)+B(:,:,2)'*Cov_PF(:,:,2)*B(:,:,2)+...
clc;
P=1;
O=0;
Q=1;
Var_startIndex=2349; % 
%data&w
Equity_w=[1/3;1/3;1/3];
ww=Equity_w;
data=Equity_LP;
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


[PARAMETERS,LL,HT,VCV,SCORES] = bekk(newData,[],P,O,Q);
[C,A,G,B] = bekk_parameter_transform(PARAMETERS,1,0,1,3,1);
j=1;
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1;  
    m2=data(i-261:i,:);
    m_new=newData(i-261-1,:);
    Cov_PF=cov(m2);  
  
   Result_His_BEKK(index,1)=sqrt(ww'*Cov_PF*ww); % 
  
   result_BEKK(:,:,index)= C+ A(:,:,j)'*m_new'*m_new*A(:,:,j)+B(:,:,j)'*Cov_PF*B(:,:,j)
   Equity_Result_bekk101(index)=sqrt(ww'*result_BEKK(:,:,index)*ww);
end 



