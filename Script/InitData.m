% 1 º”‘ÿ ˝æ› 
load('../Data/Alternative_LP.mat');
load('../Data/Equity_LP.mat');
load('../Data/FixIncome_LP.mat');
load('../Data/NewPF_LP.mat');
load('../Data/OldPF_LP.mat');
%load('../Data/SP_DAX_LP.mat');

load('../Data/Alternative_LP2.mat');
load('../Data/Equity_LP2.mat');
load('../Data/FixIncome_LP2.mat');
load('../Data/NewPF_LP2.mat');
load('../Data/OldPF_LP2.mat');
%load('../Data/SP_DAX_LP2.mat');
%2 weights
SP_DAX_w=[1/2;1/2]; % Weight
Alternative_w=[0.2;0.2;0.2;0.2;0.2]; % Weight
Equity_w=[1/3;1/3;1/3]; % Weight
FixIncome_w=[1/3;1/3;1/3]; % Weight
NewPF_w=[0.3;0.6;0.1]; %Defensive Weight
NewPF_w2=[0.5;0.3;0.2]; %Offensive Weight
OldPF_w=[0.15;0.1;0.05;0.3;0.2;0.1;0.02;0.02;0.02;0.02;0.02]; %Defensive Weight
OldPF_w2=[0.25;0.15;0.10;0.15;0.10;0.05;0.04;0.04;0.04;0.04;0.04]; %Offensive Weight

%Cal_BasicStatistics
%Alternative_LP
[Alternative_BasicStatistics]=Cal_BasicStatistics(Alternative_LP2);
%Equity_LP
[Equity_BasicStatistics]=Cal_BasicStatistics(Equity_LP2);
%FixIncome_LP
[FixIncome_BasicStatistics]=Cal_BasicStatistics(FixIncome_LP2);
%NewPF_LP
[NewPF_BasicStatistics]=Cal_BasicStatistics(NewPF_LP2);
%OldPF_LP
[OldPF_BasicStatistics]=Cal_BasicStatistics(OldPF_LP2);