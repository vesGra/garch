% 主程序 gogarch 测试入口
clear;
clc;
% 是否计算历史

%初始化数据
InitData;

[Alternative_Gogarch11_1]=Cal_Gogarch_1(Alternative_LP,[],Alternative_w,[],'Alternative',1,1);
[Equity_Gogarch11_1]=Cal_Gogarch_1(Equity_LP,[],Equity_w,[],'Equity',1,1);
[FixIncome_Gogarch11_1]=Cal_Gogarch_1(FixIncome_LP,[],FixIncome_w,[],'FixIncome',1,1);
[NewPF_Gogarch11_1_Defensive,NewPF_Gogarch11_1_Offensive]=Cal_Gogarch_1(NewPF_LP,[],NewPF_w,NewPF_w2,'NewPF',1,1);
[OldPF_Gogarch11_1_Defensive,OldPF_Gogarch11_1_Offensive]=Cal_Gogarch_1(OldPF_LP,[],OldPF_w,OldPF_w2,'OldPF',1,1);

