%计算 MSE
function results =Cal_MSE(st, ht)


[a b] = size(st);
[c d] = size(ht);

if a ~= c
    error('Dimension mismatch between realized and forecasted volatility vectors');
end
MSE1 = (1/a).*(sum(st - ht).^2);
%MSE=1/(向量的长度)*((st_(1)-ht_(1))^2+(st_(2)-ht_(2))^2+...+(st_(T)-ht_(T))^2)
[a b] = size(st);
MSE=[];
for i=1:a
    if i==1 
        MSE=(st(i)-ht(i))^2;
    else
        MSE=MSE+(st(i)-ht(i))^2;
    end
    
end
MSE=(1/a)*MSE;
results=MSE;