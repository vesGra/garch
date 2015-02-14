%生成图表，并保存文件
function  [result]=SaveChart(data,chartLegend,chartTitle)

chartLegend=strcat(chartLegend,'''',' ','''');
chartLegend=strrep(chartLegend,'Every','r');
[chartLegend]=ModifyName(chartLegend);
[chartTitle]=ModifyName(chartTitle);
%7 chart
figure1=figure('Position',[0 30 1100 550]);
% plot(data,'linewidth',2);
plot(data);
set(gcf,'Position',[-50 30 1100 500]);
set(gcf, 'color', 'white');
set(gca, 'color', 'white');

 set(gca,'FontSize',13);
set(gcf, 'InvertHardCopy', 'off');
% set(gca,'xticklabel',{'2013-04-09','2013-05-09','2013-06-09','2013-07-09','2013-08-09','2013-09-09','2013-10-09','2013-11-09','2013-12-09','2014-01-09','2014-02-09','2014-03-09','2014-04-09'});
% set(gca,'XTick',[1 22 44 66 88 110 132 154 176 198 220 242 261]);
set(gca,'xticklabel',{'Apr13','Jun13','Aug13','Oct13','Dec13','Feb14','Apr14'});
set(gca,'XTick',[1  44  88  132  176  220  261]);
title(chartTitle);
% strcat('legend(',chartLegend,')');
eval(strcat('legend(',chartLegend,')'));
xlabel('Date');
ylabel('volatility');
% set(gca,'LineWidth',2.0); 
f=getframe(gcf);
imwrite(f.cdata,[strcat('../Charts/',chartTitle,'.png')]);
close all;