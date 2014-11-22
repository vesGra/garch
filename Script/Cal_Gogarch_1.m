function [Gogarch_Result1,Gogarch_Result2] = Cal_Gogarch_1(data,Var_startIndex,weight1,weight2,name,p,q)
%Cal_Gogarch_1
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
% 1
% new data 
[newData,newData_F,sigma] = MakeNewData_F(data);
% 
[parameters,ll,Ht,VCV,scores,Z] = gogarch(newData_F(end-2*261-1:end-261,:),p,q);%(newData,numfactors,p,o,q);

paraA=[];
paraB=[];
paraW=[];
paraA=parameters(end-3*k+1:end-2*k);
paraB=parameters(end-k+1:end);

paraW=bsxfun(@minus,1,bsxfun(@plus,paraA,paraB));

%2
for i=Var_startIndex:Var_lens
   index=i-Var_startIndex+1;       
   m_new2_F=newData_F(i-260-1-260:i-260-1,:);
   errors=[];
   for t=1:261    
    erros=inv(Z)*m_new2_F(t,:)';
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
end 

% 保存数据文件
if ~isempty(weight2)
    save(strcat('../Result/',name,'_Gogarch',num2str(p),num2str(q),'_1_Defensive'),'Gogarch_Result1');
    save(strcat('../Result/',name,'_Gogarch',num2str(p),num2str(q),'_1_Offensive'),'Gogarch_Result2');   
else
    save(strcat('../Result/',name,'_Gogarch',num2str(p),num2str(q),'_1'),'Gogarch_Result1');
end
