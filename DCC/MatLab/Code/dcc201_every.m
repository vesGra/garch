% 第一步。 算dcc(m)的参数>dcc [PARAMETERS,LL,HtTemp,VCV,SCORES,DIAGNOSTICS,Rt,Qt]=dcc(m,[],1,0,1,1,0,1,2,'2-stage','none');
% 第二步。 取2012/4/9到2013/4/9的数据 计算 Ht=Cov(n) 
% 第三步。 算Rt=Corr(n)
% 第四步。 ht=diag(Ht,0)
% 第五步。 用ht和参数算ht+1 (结果3x1向量)
% 第六步。 用Rt和参数算Rt+1 （结果3x3矩阵）
% 第七步。 用diag(sqrt(ht))合成 Dt 3x3的矩阵，除了对角线其他都为零
% 第八步。 最后result=D(k)*Rt(k)*D(k) 是t+1的预测值
% 最后 把n往后移动一天 然后同样的步骤再算第t+2的预测值 一直循环到第260个
%ht1=bsxfun(@plus,bsxfun(@plus,w',bsxfun(@times,alpha',(n(end,:).^2)')),bsxfun(@times,beta',dht))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 动态parameters，自己计算Ht&Rt
% 这个是采用动态的parameters，即parameters根据每条数据的前9年计算而出
% Ht和Rt采用自己计算方式。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;

%data&w
Equity_w=[1/3;1/3;1/3];

ww=Equity_w;
data=Equity_LP;
% para
m=2;
l=0;
n=2;

p=2;
o=0;
q=2;
Var_startIndex=2349; % 
[Var_lens,Var_cols]=size(data); % 
k=Var_cols;
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
       
    mData=data(i-Var_startIndex+1:i,:);
    mHis=mData(end-261:end,:);
    Cov_PF=cov(mHis);    
    Result_His1(index,1)=ww'*Cov_PF*ww; % 
    % 1
    [PARAMETERS,LL,HtTemp,VCV,SCORES,DIAGNOSTICS,RRt,QQt,Ao,Go,Bo,Ro]=dcc(mData,[],p,o,q,m,l,n,2,'2-stage','none');
    
    Equity_DCC_PARAMETERS(:,:,index)=PARAMETERS;
    Equity_DCC_Ht(:,:,:,index)=HtTemp;
    Equity_DCC_Rt(:,:,:,index)=RRt;
    Equity_DCC_Ao(:,:,index)=Ao;
    Equity_DCC_Go(:,:,index)=Go;
    Equity_DCC_Bo(:,:,index)=Bo;
    Equity_DCC_Ro(:,:,index)=Ro;
    
    % 2
    %Ht=cov(n);
    % 3
    %Rt=corr(n);
    % 4
    %dht=diag(Ht,0);
    % 5
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
   
    %AA=bsxfun(@times,eps,Ao);
    %BB=bsxfun(@times,Rt,Bo);  
    for j=1:p
        m2=data(i-261-j+1:i-j+1,:);
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
   Result(index)=ww'*result_DCC(:,:,index)*ww;
   disp(i);
end 



