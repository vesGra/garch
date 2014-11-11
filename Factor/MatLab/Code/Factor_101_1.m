% Factor
clc;
numfactors=3;
p=1;
o=0;
q=1;
Var_startIndex=2349; % 
%data&w
Alternative_w=[1/5;1/5;1/5;1/5;1/5];
ww=Alternative_w;
data=Alternative_LP;
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
count = 1;
paraW=[];
paraA=[];
paraB=[];
for i=1:numfactors;
    paraW(i)=PARAMETERS((i-1)*3+1);
    paraA(i)=PARAMETERS((i-1)*3+2);
    paraB(i)=PARAMETERS((i-1)*3+3);
end

 
%2
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1;  
    m2=data(i-261:i,:);
    Cov_PF=cov(m2);  
    Alternative_Result_His(index,1)=sqrt(ww'*Cov_PF*ww); % 
    
    m_new=newData(i-261-1:i,:);
    [w, pc] = pca(m_new,'outer');
    weights = w(1:numfactors,:);
    F = pc(:,1:numfactors);

    erros=m_new-F*weights;
    omega=diag(mean(erros.^2));
    
    Ht=cov(F);
    ht=diag(Ht,0);
    
    ft=F(end,:,:);
    ft=ft';
    htsub1=bsxfun(@times,paraA.^2,ft.^2);
   
    htsub2=bsxfun(@times,paraB.^2,ht);
   
    ht1=bsxfun(@plus,paraW,htsub1);
   
    ht1=bsxfun(@plus,ht1,htsub2);
    Ht1=diag(ht1);
     weights
     Ht1
    H_Factor=weights'*Ht1*weights+omega;
   
   Alternative_Result_Factor101(index)=sqrt(ww'*H_Factor*ww);
end 


