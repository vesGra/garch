function [DCC_Result1,DCC_Result2] = Cal_DCC_Every(data,Var_startIndex,weight1,weight2,name,p,o,q,YC)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 动态parameters，自己计算Ht&Rt
% 这个是采用动态的parameters，即parameters根据每条数据的前9年计算而出
% Ht和Rt采用自己计算方式。
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
% save DCC Result
Equity_DCC_PARAMETERS=[];
Equity_DCC_Ht=[];
Equity_DCC_Rt=[];
Equity_DCC_Ao=[];
Equity_DCC_Go=[];
Equity_DCC_Bo=[];
Equity_DCC_Ro=[];
ht=[];
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1; 
       
    %mData=newData(index+261*5:index+261*8,:);
   mData=newData(i-260-1-261*YC+1:i-260-1,:);
    % 1
    [PARAMETERS,LL,HtTemp,VCV,SCORES,DIAGNOSTICS,RRt,QQt,Ao,Go,Bo,Ro]=dcc(mData,[],p,o,q,m,l,n,2,'2-stage','none');
    
    Equity_DCC_PARAMETERS(:,:,index)=PARAMETERS;
    Equity_DCC_Ht(:,:,:,index)=HtTemp;
    Equity_DCC_Rt(:,:,:,index)=RRt;
    Equity_DCC_Ao(:,:,index)=Ao;
    Equity_DCC_Go(:,:,index)=Go;
    Equity_DCC_Bo(:,:,index)=Bo;
    Equity_DCC_Ro(:,:,index)=Ro;

    gScale=DIAGNOSTICS.gScale;   
    scale = (1-sum(Ao)-sum(Bo)) - gScale*sum(Go);
    scale = sqrt(scale); 
    scale=scale'*scale;
    w=[];
    alpha=[];
    beta=[];
    volParameters=[];
    ht1=[];
    intcept=[];
    eps=[];
    BB=[];
    AA=[];
    epsilon=[];
    count = 0;
    for j=1:k
        count = count + p+o+q+1;
    end
    garchParameters = PARAMETERS(1:count);
    offset = 0;
    count = p+o+q+1;
    for j=1:k       
        volParameters(:,:,j) = garchParameters(offset + (1:count));        
        % w与数据维数相同
        w(j)=volParameters(1,1,j);
        offset = offset+count;
    end
    
    intcept=bsxfun(@times,corr_ivech(Ro),scale);
  
    for j=1:p       
        %m2= newData(i-520-j+1:i-259-j+1,:);%mData(i-261-j+1:i-j+1,:);mData
        m2= mData(end-260-j+1:end-j+1,:);
        Ht=cov(m2);
        Rt=corr(m2);
        dht=diag(Ht,0);
        alpha=[];
        beta=[];
        for kl=1:k
            tempPara=volParameters(:,:,kl);
            %parameters(j+1)
            %parameters(j+p+1)
            %parameters(j+p+o+1)
           alpha(kl)=tempPara(1+j);
           beta(kl)=tempPara(1+j+p);
        end              
        epsilon(1:Var_cols,1,i)=bsxfun(@rdivide,m2(end,:)',sqrt(dht));
        eps=epsilon(1:Var_cols,1,i)*epsilon(1:Var_cols,1,i)';
        if j==1
            ht(1:Var_cols,1,index)=bsxfun(@plus,bsxfun(@plus,w',bsxfun(@times,alpha',(m2(end,:).^2)')),bsxfun(@times,beta',dht));
            BB=bsxfun(@times,Rt,Bo(j));
            AA=bsxfun(@times,eps,Ao(j));
        else
            ht(1:Var_cols,1,index)=bsxfun(@plus,ht(1:Var_cols,1,index),bsxfun(@plus,bsxfun(@plus,w',bsxfun(@times,alpha',(m2(end,:).^2)')),bsxfun(@times,beta',dht)));
            BB=bsxfun(@plus,BB,bsxfun(@times,Rt,Bo(j)));
            AA=bsxfun(@plus,AA,bsxfun(@times,eps,Ao(j)));
        end
    end

   Rt1(1:Var_cols,1:Var_cols,index)=bsxfun(@plus,intcept,bsxfun(@plus,AA,BB));
   Dt1(:,:,index)=diag(sqrt(ht(1:Var_cols,1,index)));
   result_DCC(:,:,index)=Dt1(:,:,index)*Rt1(1:Var_cols,1:Var_cols,index)*Dt1(:,:,index);
   DCC_Result1(index)=sqrt(weight1'*result_DCC(:,:,index)*weight1);
   if ~isempty(weight2)
        DCC_Result2(index)=sqrt(weight2'*result_DCC(:,:,index)*weight2);
    end
   disp(i);
end 
% save DCC Result 
save(strcat('../modelResults/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_',num2str(YC),'_PARAMETERS'),'Equity_DCC_PARAMETERS');
save(strcat('../modelResults/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_',num2str(YC),'_Ht'),'Equity_DCC_Ht');
save(strcat('../modelResults/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_',num2str(YC),'_Rt'),'Equity_DCC_Rt');
save(strcat('../modelResults/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_',num2str(YC),'_Ao'),'Equity_DCC_Ao');
save(strcat('../modelResults/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_',num2str(YC),'_Go'),'Equity_DCC_Go');
save(strcat('../modelResults/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_',num2str(YC),'_Bo'),'Equity_DCC_Bo');
save(strcat('../modelResults/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_',num2str(YC),'_Ro'),'Equity_DCC_Ro');

% 保存数据文件
if ~isempty(weight2)
    save(strcat('../Result/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_Every_',num2str(YC),'_Defensive'),'DCC_Result1');
    save(strcat('../Result/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_Every_',num2str(YC),'_Offensive'),'DCC_Result2');   
else
    save(strcat('../Result/',name,'_DCC',num2str(p),num2str(o),num2str(q),'_Every_',num2str(YC)),'DCC_Result1');
end



