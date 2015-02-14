%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BEKK滚动参数
% 动态parameters
% 这个是采用动态的parameters，即parameters根据每条数据的前YC年计算而出
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [BEKK_Result1,BEKK_Result2] = Cal_BEKK_Every(data,Var_startIndex,weight1,weight2,name,p,o,q,YC)

% YC=YC+1;
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
% save BEKK Result
Equity_BEKK_PARAMETERS=[];
ht=[];
j=1;
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1; 
    m2=data(i-261:i-1,:);
    m_new=newData(i-260-1,:);
    Cov_PF=cov(m2);  
    if (i-260-261*YC+1)<1
        subIndex=1;
    else
        subIndex=i-260-261*YC+1;
    end
    %mData=newData(subIndex:end-261,:)
    mData=newData(i-260-261*YC+1:i-260-1,:);
    % 1
    [PARAMETERS,LL,HT,VCV,SCORES] = bekk(mData,[],p,o,q,'Full');
%     [C,A,G,B] = bekk_parameter_transform(PARAMETERS,p,o,q,k,1);    
    [C,A,G,B] = bekk_parameter_transform(PARAMETERS,p,o,q,k,3);    
    Equity_BEKK_PARAMETERS(:,:,index)=PARAMETERS;   

    result_BEKK(:,:,index)= C+ A(:,:,j)'*m_new'*m_new*A(:,:,j)+B(:,:,j)'*Cov_PF*B(:,:,j);
    BEKK_Result1(index)=sqrt(weight1'*result_BEKK(:,:,index)*weight1);
    if ~isempty(weight2)
        BEKK_Result2(index)=sqrt(weight2'*result_BEKK(:,:,index)*weight2);
    end
   disp(i);
end 
% save DCC Result 
save(strcat('../modelResults/',name,'_BEKK',num2str(p),num2str(o),num2str(q),'_PARAMETERS'),'Equity_BEKK_PARAMETERS');

% 保存数据文件
if ~isempty(weight2)
    save(strcat('../Result/',name,'_BEKK',num2str(p),num2str(o),num2str(q),'_Every_',num2str(YC),'_Defensive'),'BEKK_Result1');
    save(strcat('../Result/',name,'_BEKK',num2str(p),num2str(o),num2str(q),'_Every_',num2str(YC),'_Offensive'),'BEKK_Result2');   
else
    save(strcat('../Result/',name,'_BEKK',num2str(p),num2str(o),num2str(q),'_Every_',num2str(YC)),'BEKK_Result1');
end



