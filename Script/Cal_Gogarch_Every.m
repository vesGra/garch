function [Gogarch_Result1,Gogarch_Result2] = Cal_Gogarch_Every(data,Var_startIndex,weight1,weight2,name,p,q,YC)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 动态parameters，自己计算Ht&Rt
% 这个是采用动态的parameters，即parameters根据每条数据的前9年计算而出
% Ht和Rt采用自己计算方式。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
YC=YC+1;
if isempty(p)
    p=1;
end
if isempty(q)
    q=1;
end

if isempty(Var_startIndex)
    Var_startIndex=2349;
end

[Var_lens,Var_cols]=size(data); %
k=Var_cols;
offset=k*(p+q);
% new data 
newData=[];
sigma=[];
for i=261:Var_lens
   for j=1: Var_cols
       tempData=data(i-260:i,j);
        mu=mean(tempData);
        sigma(i-260,j)=sqrt(var(tempData));
        newData(i-260,j)=data(i,j)-mu;
   end
end
% save Gogarch Result
Equity_Gogarch_PARAMETERS=[];
Equity_Gogarch_Z=[];

ht=[];
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1;        
    %mData=newData(i-260-261*YC+1:i-260-1,:);
    if (i-260-261*YC+1)<1
        subIndex=1;
    else
        subIndex=i-260-261*YC+1;
    end
    mData=newData(subIndex:i-260-1,:)
    m_new2=mData(end-260:end,:);
   [parameters,ll,Ht,VCV,scores,Z] = gogarch(mData,p,q);%(newData,numfactors,p,o,q);
    Equity_Gogarch_PARAMETERS(:,:,index)=parameters;
    Equity_Gogarch_Z(:,:,:,index)=Z;
    paraA=[];
    paraB=[];
    paraW=[];
    for i2=1:k
        paraA(i2)=parameters(end-(offset-((i2-1)*(p+q)+1)));
        paraB(i2)=parameters(end-(offset-((i2-1)*(p+q)+2)));
    end
    paraA=paraA';
    paraB=paraB';
    paraW=bsxfun(@minus,1,bsxfun(@plus,paraA,paraB));
    errors=[];
   for t=1:261    
    erros=inv(Z)*m_new2(t,:)';
    errors(t,:)=erros';
   end
   
    Ht=cov(errors);
    ht=diag(Ht,0);
    
    ft=errors(end,:,:);
    ft=ft';
    
    htsub1=bsxfun(@times,paraA,ft.^2);
    htsub2=bsxfun(@times,paraB,ht);
    ht1=bsxfun(@plus,paraW,htsub1); 
    ht1=bsxfun(@plus,ht1,htsub2);
    Ht1=diag(ht1); 
    H_gogarch=Z * Ht1 * Z';  
    Gogarch_Result1(index)=sqrt(weight1'*H_gogarch*weight1);
   if ~isempty(weight2)
        Gogarch_Result2(index)=sqrt(weight2'*H_gogarch*weight2);
    end
    disp(i);
end 
% save Gogarch Result 
save(strcat('../modelResults/',name,'_Gogarch',num2str(p),num2str(q),'_PARAMETERS'),'Equity_Gogarch_PARAMETERS');
save(strcat('../modelResults/',name,'_Gogarch',num2str(p),num2str(q),'_Z'),'Equity_Gogarch_Z');


% 保存数据文件
if ~isempty(weight2)
    save(strcat('../Result/',name,'_Gogarch',num2str(p),num2str(q),'_Every_Defensive'),'Gogarch_Result1');
    save(strcat('../Result/',name,'_Gogarch',num2str(p),num2str(q),'_Every_Offensive'),'Gogarch_Result2');   
else
    save(strcat('../Result/',name,'_Gogarch',num2str(p),num2str(q),'_Every'),'Gogarch_Result1');
end



