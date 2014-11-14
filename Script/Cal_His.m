function [His_Result1,His_Result2] = Cal_His(data,Var_startIndex,weight1,weight2,name)
% 计算历史波动率
% Var_startIndex 为数据起始计算索引。默认值：2349
% name 保存的数据文件名称,为空则不保存
% 针对有进攻和防守占比的数据，就传两个weight
% [His_Result1,His_Result2] = Cal_His(data,weight1,weight2)
% 否则，只传一个就可以
% [His_Result] = Cal_His(data,weight1)
if isempty(Var_startIndex)
    Var_startIndex=2349;
end
[Var_lens,Var_cols]=size(data); %
for i=Var_startIndex:Var_lens
    index=i-Var_startIndex+1;  
    m2=data(i-261:i,:);
    Cov_PF=cov(m2);
    His_Result1(index,1)=sqrt(weight1'*Cov_PF*weight1); % 
    if ~isempty(weight2)
        His_Result2(index,1)=sqrt(weight2'*Cov_PF*weight2); % 
    end
end
% 保存数据文件
if ~isempty(weight2)
    save(strcat('../Result/',name,'_His_Defensive'),'His_Result1');
    save(strcat('../Result/',name,'_His_Offensive'),'His_Result2');   
else
    save(strcat('../Result/',name,'_His'),'His_Result1');
end