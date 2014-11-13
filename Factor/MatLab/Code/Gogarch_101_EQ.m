% Factor
clc;
numfactors=3;
p=1;
o=0;
q=1;
Var_startIndex=2349; % 
%data&w
Alternative_w=[1/5;1/5;1/5;1/5;1/5];
%ww=Alternative_w;
%data=Alternative_LP;
Equity_w=[1/3;1/3;1/3];
ww=Equity_w;
data=Equity_LP;
[Var_lens,Var_cols]=size(data); %
mdata=data(2:Var_startIndex,:);
k=Var_cols;
% 1
% new data 
newData=[];
for i=260:Var_lens
   for j=1: Var_cols
       tempData=data(i-259:i,j);
        Cov_PF=cov(tempData);  
        mu=mean(tempData);
        epsilon=bsxfun(@minus,tempData(end,:,:),mu);
        newData(i-259,j)=epsilon;
   end
end
% 用前8年，算参数
[parameters,ll,Ht,VCV,scores,Z,Zinv] = gogarch(newData(1:end-261,:),1,1);%(newData,numfactors,p,o,q);

paraA=[];
paraB=[];
paraW=[];
paraA=parameters(10:12);
paraB=parameters(13:15);

paraW=bsxfun(@minus,1,bsxfun(@plus,paraA,paraB));

%paraA=paraA';
%paraB=paraB';
%paraW=paraW';

%2
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1;  
    m2=data(i-261:i,:);
    Cov_PF=cov(m2);  
    Alternative_Result_His(index,1)=sqrt(ww'*Cov_PF*ww); % 
    
    m_new2=newData(i-522:i-261,:);
   errors=[];
   for t=1:262    
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
   Alternative_Result_gogarch11(index)=sqrt(ww'*H_gogarch*ww);
   disp(i);
end 
 
