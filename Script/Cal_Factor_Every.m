function [Factor_Result1,Factor_Result2] = Cal_Factor_Every(data,Var_startIndex,weight1,weight2,name,p,o,q,numfactors)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 动态parameters，自己计算Ht&Rt
% 这个是采用动态的parameters，即parameters根据每条数据的前9年计算而出
% Ht和Rt采用自己计算方式。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numfactors=3;
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
k=Var_cols;
if ~isempty(numfactors) && numfactors>k    
    error('numfactors超过维数！');
end
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
% save Factor Result
Equity_Factor_PARAMETERS=[];
ht=[];
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1; 
    %mData=newData(index+261*5:index+261*8,:);
    mData=newData(i-260-261*3+1:i-260-1,:);
    %m_new2=newData(i-520:i-259,:);
    m_new2=mData(end-260:end,:);
   [PARAMETERS,HT,W,PC]= o_mvgarch(mData,numfactors,p,o,q);
    Equity_Factor_PARAMETERS(:,:,index)=PARAMETERS;
    paraW=[];
    paraA=[];
    paraB=[];
    for i2=1:numfactors;
        paraW(i2)=PARAMETERS((i2-1)*3+1);
        paraA(i2)=PARAMETERS((i2-1)*3+2);
        paraB(i2)=PARAMETERS((i2-1)*3+3);
    end
    paraW=paraW';
    paraA=paraA';
    paraB=paraB';
     [w, pc] = pca(m_new2,'outer');

    weights = w(:,1:numfactors);	
   
   errors=[];
   for t=1:261
    F = pc(t,1:numfactors);
    erros=bsxfun(@minus,m_new2(t,:)',weights*F');
    errors(t,:)=erros';
   end
   H_omega=cov(errors);
    omega=diag(H_omega,0);   
    omega=diag(omega);
    %omega=omega-weights*paraW*paraW'*weights';
    Ht=cov(F);
    ht=diag(Ht,0);
    
    ft=F(end,:,:);
    ft=ft';
    
    htsub1=bsxfun(@times,paraA,ft.^2);

    htsub2=bsxfun(@times,paraB,ht);

    ht1=bsxfun(@plus,paraW,htsub1);
 
    ht1=bsxfun(@plus,ht1,htsub2);
    Ht1=diag(ht1);
 
    H_Factor=weights * Ht1 * weights' + omega;   
    Factor_Result1(index)=sqrt(weight1'*H_Factor*weight1);
    if ~isempty(weight2)
        Factor_Result2(index)=sqrt(weight2'*H_Factor*weight2);
    end
   disp(i);
end 
% save Factor Result 
save(strcat('../modelResults/',name,'_Factor',num2str(p),num2str(o),num2str(q),'_PARAMETERS'),'Equity_Factor_PARAMETERS');
% 保存数据文件
if ~isempty(weight2)
    save(strcat('../Result/',name,'_Factor',num2str(p),num2str(o),num2str(q),'_Every_Defensive'),'Factor_Result1');
    save(strcat('../Result/',name,'_Factor',num2str(p),num2str(o),num2str(q),'_Every_Offensive'),'Factor_Result2');   
else
    save(strcat('../Result/',name,'_Factor',num2str(p),num2str(o),num2str(q),'_Every'),'Factor_Result1');
end



