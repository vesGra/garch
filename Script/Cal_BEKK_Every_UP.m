function [BEKK_Result1,BEKK_Result2] = Cal_BEKK_Every_UP(data,Var_startIndex,weight1,weight2,name,p,o,q,ppp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 动态parameters，自己计算Ht&Rt
% 这个是采用动态的parameters，即parameters根据每条数据的前9年计算而出
% Ht和Rt采用自己计算方式。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(p)
    p=1;
end
if isempty(o)
    o=0;
end
if isempty(q)
    q=1;
end

if isempty(Var_startIndex)
    Var_startIndex=2349;
end

[Var_lens,Var_cols]=size(data); % 
mdata=data(1:Var_startIndex,:);
k=Var_cols;
% new data 
newData=[];

for i=262:Var_lens
   for j=1: Var_cols
       tempData=data(i-260:i,j);
        mu=mean(tempData);
        epsilon=bsxfun(@minus,tempData(end,:,:),mu);
        newData(i-261,j)=epsilon;
   end
end
% save BEKK Result
% Equity_BEKK_PARAMETERS=[];
ht=[];
j=1;
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1; 
    m2=data(i-261:i,:);
    m_new=newData(i-261-1,:);
    Cov_PF=cov(m2);  
    mData=newData(index+261*5:index+261*8,:);   
    % 1
    %[PARAMETERS,LL,HT,VCV,SCORES] = bekk(mData,[],p,o,q);
 PARAMETERS=ppp(:,:,index);
    [C,A,G,B] = bekk_parameter_transform(PARAMETERS,p,o,q,k,1);  

    result_BEKK(:,:,index)= C+ A(:,:,j)'*m_new'*m_new*A(:,:,j)+B(:,:,j)'*Cov_PF*B(:,:,j);
    BEKK_Result1(index)=sqrt(weight1'*result_BEKK(:,:,index)*weight1);
    if ~isempty(weight2)
        BEKK_Result2(index)=sqrt(weight2'*result_BEKK(:,:,index)*weight2);
    end
   disp(i);
end 




