function [DCC_Result1,DCC_Result2] = Cal_DCC_1(data,Var_startIndex,weight1,weight2,name,p,o,q)
% 计算DCC poq默认101，一个参数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 固定parameters
% 这个是采用固定的parameters，即1-9年的log price算出来parameters，后面计算采用固定的参数计算
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=1;
l=0;
n=1;
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
for i=261:Var_lens
   for j=1: Var_cols
       tempData=data(i-260:i,j);
        mu=mean(tempData);
        epsilon=bsxfun(@minus,tempData(end,:,:),mu);
        newData(i-260,j)=epsilon;
   end
end
% 1
[PARAMETERS,LL,HtTemp,VCV,SCORES,DIAGNOSTICS,RRt,QQt,Ao,Go,Bo,Ro]=dcc(newData(1:end-261,:),[],p,o,q,m,l,n,2,'2-stage','none');

gScale=DIAGNOSTICS.gScale;   
scale = (1-sum(Ao)-sum(Bo)) - gScale*sum(Go);
scale = sqrt(scale); 
scale=scale'*scale;
w=[];
alpha=[];
beta=[];
ht1=[];
intcept=[];
eps=[];
count=p+o+q+1;
for kl=1:k
   w(kl)=PARAMETERS((kl-1)*count+1);
   alpha(kl)=PARAMETERS((kl-1)*count+2);
   beta(kl)=PARAMETERS((kl-1)*count+3);
end
intcept=bsxfun(@times,corr_ivech(Ro),scale);
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1;  
    %m2=data(i-261:i,:);
    %Cov_PF=cov(m2);
   
    n=newData(i-260-1-260:i-260-1,:);
    Ht=cov(n);
    Rt=corr(n);
    dht=diag(Ht,0);
   
    epsilon(1:Var_cols,1,i)=bsxfun(@rdivide,n(end,:)',sqrt(dht));
    eps=epsilon(1:Var_cols,1,i)*epsilon(1:Var_cols,1,i)';
    AA=bsxfun(@times,eps,Ao);
    BB=bsxfun(@times,Rt,Bo);
    ht(1:Var_cols,1,index)=bsxfun(@plus,bsxfun(@plus,w',bsxfun(@times,alpha',(n(end,:).^2)')),bsxfun(@times,beta',dht));
    Rt1(1:Var_cols,1:Var_cols,index)=bsxfun(@plus,intcept,bsxfun(@plus,AA,BB));
   Dt1(:,:,index)=diag(sqrt(ht(1:Var_cols,1,index)));
   result_DCC(:,:,index)=Dt1(:,:,index)*Rt1(1:Var_cols,1:Var_cols,index)*Dt1(:,:,index);
   DCC_Result1(index)=sqrt(weight1'*result_DCC(:,:,index)*weight1);
   if ~isempty(weight2)
        DCC_Result2(index)=sqrt(weight1'*result_DCC(:,:,index)*weight1);
    end
end 
% 保存数据文件
if ~isempty(weight2)
    save(strcat('../Result/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_1_Defensive'),'DCC_Result1');
    save(strcat('../Result/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_1_Offensive'),'DCC_Result2');   
else
    save(strcat('../Result/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_1'),'DCC_Result1');
end


