% 计算Portfolio，包括计算，生成图表,保存图表对应图片文件
%  Cal Portfolio
[Alternative_PF]=Alternative_LP2 * Alternative_w;
[Equity_PF]=Equity_LP2 * Equity_w;
[FixIncome_PF]=FixIncome_LP2 * FixIncome_w;
[NewPF_PF]=NewPF_LP2 * NewPF_w;
[NewPF_PF2]=NewPF_LP2 * NewPF_w2;
[OldPF_PF]=OldPF_LP2 * OldPF_w;
[OldPF_PF2]=OldPF_LP2 * OldPF_w2;


%Alternative_LP
[Alternative_Statistics]=Cal_Portfolio_Statistics(Alternative_LP2,Alternative_PF,Alternative_w);
%Equity_LP
[Equity_Statistics]=Cal_Portfolio_Statistics(Equity_LP2,Equity_PF,Equity_w);
%FixIncome_LP
[FixIncome_Statistics]=Cal_Portfolio_Statistics(FixIncome_LP2,FixIncome_PF,FixIncome_w);
%NewPF_LP
[NewPF_D_Statistics]=Cal_Portfolio_Statistics(NewPF_LP2,NewPF_PF,NewPF_w);
%NewPF_LP
[NewPF_O_Statistics]=Cal_Portfolio_Statistics(NewPF_LP2,NewPF_PF2,NewPF_w2);
%OldPF_LP
[OldPF_O_Statistics]=Cal_Portfolio_Statistics(OldPF_LP2,OldPF_PF2,OldPF_w2);
%OldPF_LP
[OldPF_D_Statistics]=Cal_Portfolio_Statistics(OldPF_LP2,OldPF_PF,OldPF_w);

% function  [result]=SaveChartPub(data,chartLegend,chartTitle,filename)cumsum(ans)
chartTitle='Performance Curve';
data1=[cumsum(Alternative_PF*100) cumsum(Equity_PF*100) cumsum(FixIncome_PF*100)];
chartLegend=strcat('''','Alternative Assets Portfolio','''',',');
chartLegend=strcat(chartLegend,'''','Equity Portfolio','''',',');
chartLegend=strcat(chartLegend,'''','Fixed Income Portfolio','''');
SaveChartPub(data1,chartLegend,chartTitle,'a_e_f');
data1=[];
data1=[cumsum(NewPF_PF*100) cumsum(NewPF_PF2*100)];
chartLegend=strcat('''','3 Indexes Multi-asset Portfolio(Defensive)','''',',');
chartLegend=strcat(chartLegend,'''','3 Indexes Multi-asset Portfolio(Offensive)','''');
SaveChartPub(data1,chartLegend,chartTitle,'3');
data1=[];
data1=[cumsum(OldPF_PF*100) cumsum(OldPF_PF2*100)];
chartLegend=strcat('''','11 Indexes Multi-asset Poertfolio(Defensive)','''',',');
chartLegend=strcat(chartLegend,'''','11 Indexes Multi-asset Poertfolio(Offensive)','''');
SaveChartPub(data1,chartLegend,chartTitle,'11');
close all;