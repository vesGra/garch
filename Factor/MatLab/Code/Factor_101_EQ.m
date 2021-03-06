% Factor
clc;
numfactors=2;
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
[PARAMETERS,HT,W,PC]= o_mvgarch(newData,numfactors,p,o,q);
%[PARAMETERS,HT,W,PC]= o_mvgarch(data,numfactors,p,o,q);
count = 1;
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
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1;  
    m2=data(i-261:i,:);
    Cov_PF=cov(m2);  
    Equity_Result_His(index,1)=sqrt(ww'*Cov_PF*ww); % 
    
    m_new2=newData(i-522:i-261,:);
    %m_new=m2;
    
    [w, pc] = pca(m_new2,'outer');
  
    %[[w, pc] = pca(m_new,'cov');
    %[w, pc] = pca(m2,'cov');
    weights = w(:,1:numfactors);	
    %F = pc(end,1:numfactors);
    %F=F'
    %erros=m_new2-F*weights;
    %omega=diag(mean(erros.^2));
   % erros=m_new2-F*weights;
   error=[];
   for t=1:262
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
    
    htsub1=bsxfun(@times,paraA.^2,ft.^2);

    htsub2=bsxfun(@times,paraB.^2,ht);

    ht1=bsxfun(@plus,paraW,htsub1);
 
    ht1=bsxfun(@plus,ht1,htsub2);
    Ht1=diag(ht1);
 
    %H_Factor=weights * Ht1 * weights' + omega;   
     H_Factor=weights * Ht1 * weights';   
   Equity_Result_Factor101(index)=sqrt(ww'*H_Factor*ww);
   disp(i);
end 


