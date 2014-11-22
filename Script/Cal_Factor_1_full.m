function [Factor_Result1,Factor_Result2] = Cal_Factor_1_full(data,Var_startIndex,weight1,weight2,name,p,o,q,numfactors,YC)
% Cal_Factor_1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 固定parameters
% 这个是采用固定的parameters，即1-8年的log price算出来parameters，后面计算采用固定的参数计算
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

YC=YC+1;
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
% 1
% new data 
newData=[];
newData_F=[];
sigma=[];
for i=261:Var_lens
   for j=1: Var_cols
       tempData=data(i-260:i,j);
        mu=mean(tempData);
        sigma(i-260,j)=sqrt(var(tempData));
        newData(i-260,j)=data(i,j)-mu;
        newData_F(i-260,j)=newData(i-260,j)/sigma(i-260,j);
   end
end
[lens,cols]=size(newData_F);
if (lens-261*YC+1)<1
    index=1;
else
    index=lens-261*YC+1;
end
[PARAMETERS,HT,W,PC]= o_mvgarch(newData_F(index:end-261,:),numfactors,p,o,q);

paraW=[];
paraA=[];
paraB=[];
for i=1:numfactors;
    paraW(i)=PARAMETERS((i-1)*3+1);
    paraA(i)=PARAMETERS((i-1)*3+2);
    paraB(i)=PARAMETERS((i-1)*3+3);
end
paraW=paraW';
paraA=paraA';
paraB=paraB';
 
%2
%sigma=[]
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1;  
   %m_new2=newData(i-520:i-259,:);
    m2=data(i-261:i,:);
    Cov_PF=cov(m2);  
    m_new2=newData(i-260-1-260:i-260-1,:);
    m_new2_F=newData_F(i-260-1-260:i-260-1,:);
    [w, pc] = pca(m_new2_F,'outer');	
    Ht=cov(pc);
    ht=diag(Ht,0);
    ft=pc(end,:,:);
    ft=ft';
    
    htsub1=bsxfun(@times,paraA,ft.^2);
    htsub2=bsxfun(@times,paraB,ht);
    ht1=bsxfun(@plus,paraW,htsub1);
    ht1=bsxfun(@plus,ht1,htsub2);
    Ht1=diag(ht1);
    w_F=bsxfun(@times,w,sigma(i-260-1,:)');
    H_Factor=w_F * Ht1 * w_F';  
    %H_Factor=w*Ht1*w';  
    Factor_Result1(index)=sqrt(weight1'*H_Factor*weight1);
    if ~isempty(weight2)
        Factor_Result2(index)=sqrt(weight2'*H_Factor*weight2);
    end
end 
% 保存数据文件
if ~isempty(weight2)
    save(strcat('../Result/',name,'_Factor',num2str(p),num2str(o),num2str(q),'_1_Defensive'),'Factor_Result1');
    save(strcat('../Result/',name,'_Factor',num2str(p),num2str(o),num2str(q),'_1_Offensive'),'Factor_Result2');   
else
    save(strcat('../Result/',name,'_Factor',num2str(p),num2str(o),num2str(q),'_1'),'Factor_Result1');
end