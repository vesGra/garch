% 主程序
% clear;
clc;
% 是否计算历史
his=0;
DCC1011=0;
DCC101Every=0;
BEKK101=0;
Factor101=0;
Gogarch11=0;
BEKK101Every=1;
%初始化数据
InitData;


%BEKK101_Every
if BEKK101Every==1
    %[Alternative_BEKK101_Every]=Cal_BEKK_Every(Alternative_LP,[],Alternative_w,[],'Alternative',1,0,1);
    [Equity_BEKK101_Every]=Cal_BEKK_Every_UP(Equity_LP,[],Equity_w,[],'Equity',1,0,1,Equity_BEKK_PARAMETERS);
    %[FixIncome_BEKK101_Every]=Cal_BEKK_Every(FixIncome_LP,[],FixIncome_w,[],'FixIncome',1,0,1);
    %[NewPF_BEKK101_Every_Defensive,NewPF_BEKK101_Every_Offensive]=Cal_BEKK_Every(NewPF_LP,[],NewPF_w,NewPF_w2,'NewPF',1,0,1);
    %[OldPF_BEKK101_Every_Defensive,OldPF_BEKK101_Every_Offensive]=Cal_BEKK_Every(OldPF_LP,[],OldPF_w,OldPF_w2,'OldPF',1,0,1);
end

