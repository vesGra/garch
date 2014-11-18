function [BEKK_Result1,BEKK_Result2] = Cal_BEKK_1(data,Var_startIndex,weight1,weight2,name,p,o,q)
%Cal_BEKK_1
% bekk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 固定parameters
% 这个是采用固定的parameters，即1-9年的log price算出来parameters，后面计算采用固定的参数计算
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
mdata=data(2:Var_startIndex,:);
k=Var_cols;
% 1
% new data 
newData=[];
for i=261:Var_lens
   for j=1: Var_cols
       tempData=data(i-260:i,j);
        mu=mean(tempData);
        epsilon=bsxfun(@minus,tempData(end,:,:),mu);
        newData(i-260,j)=epsilon;
   end
end
[PARAMETERS,LL,HT,VCV,SCORES] = bekk(newData,[],p,o,q);
[C,A,G,B] = bekk_parameter_transform(PARAMETERS,1,0,1,k,1);
j=1;
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1;  
    m2=data(i-261:i-1,:);
    m_new=newData(i-260-1,:);
    Cov_PF=cov(m2);  
    
   result_BEKK(:,:,index)= C+ A(:,:,j)'*m_new'*m_new*A(:,:,j)+B(:,:,j)'*Cov_PF*B(:,:,j);
   BEKK_Result1(index)=sqrt(weight1'*result_BEKK(:,:,index)*weight1);
   if ~isempty(weight2)
        BEKK_Result2(index)=sqrt(weight2'*result_BEKK(:,:,index)*weight2);
    end
end 
% 保存数据文件
if ~isempty(weight2)
    save(strcat('../Result/',name,'_BEKK',num2str(p),num2str(o),num2str(q),'_1_Defensive'),'BEKK_Result1');
    save(strcat('../Result/',name,'_BEKK',num2str(p),num2str(o),num2str(q),'_1_Offensive'),'BEKK_Result2');   
else
    save(strcat('../Result/',name,'_BEKK',num2str(p),num2str(o),num2str(q),'_1'),'BEKK_Result1');
end


