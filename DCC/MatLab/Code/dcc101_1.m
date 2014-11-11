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
% 固定parameters
% 这个是采用固定的parameters，即1-9年的log price算出来parameters，后面计算采用固定的参数计算
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
% para
m=1;
l=0;
n=1;

p=1;
o=0;
q=1;

Var_startIndex=2349; % 
%data&w
Equity_w=[1/3;1/3;1/3];
ww=Equity_w;
data=Equity_LP;
[Var_lens,Var_cols]=size(data); % 
mdata=data(1:Var_startIndex,:);
k=Var_cols;

% 1
[PARAMETERS,LL,HtTemp,VCV,SCORES,DIAGNOSTICS,RRt,QQt,Ao,Go,Bo,Ro]=dcc(mdata,[],p,o,q,m,l,n,2,'2-stage','none');
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
ht1=[];
intcept=[];
eps=[];
for kl=1:k
   w(kl)=PARAMETERS((kl-1)*3+1);
   alpha(kl)=PARAMETERS((kl-1)*3+2);
   beta(kl)=PARAMETERS((kl-1)*3+3);
end
intcept=bsxfun(@times,corr_ivech(Ro),scale);
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1;  
    m2=data(i-261:i,:);
    Cov_PF=cov(m2);
    Equity_Result_His(index,1)=ww'*Cov_PF*ww; % 
   
    n=m2;
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
   Equity_Result_DCC101(index)=ww'*result_DCC(:,:,index)*ww;
end 



