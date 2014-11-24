function  [result]=SaveChart(data,chartLegend,chartTitle)
%生成图表，并保存
chartLegend=strcat(chartLegend,'''',' ','''');
chartLegend=strrep(chartLegend,'Every','r');
chartTitle=strrep(chartTitle,'Every','r');
chartTitle=strrep(chartTitle,'FixIncome','Fixed Income');
%7 chart
figure1=figure('Position',[0 30 1866 1808]);
set(gcf,'Position',[0 30 1866 1808]);
plot(data);
set(gcf,'Position',[0 30 1866 1808]);
set(gca,'xticklabel',{'2013-04-09','2013-05-09','2013-06-09','2013-07-09','2013-08-09','2013-09-09','2013-10-09','2013-11-09','2013-12-09','2014-01-08','2014-02-08','2014-03-08','2014-04-08'});
set(gca,'XTick',[1 22 44 66 88 110 132 154 176 198 220 242 261]);
title(chartTitle);
strcat('legend(',chartLegend,')');
eval(strcat('legend(',chartLegend,')'));
xlabel('Date');
ylabel('volatility');
f=getframe(gcf);
imwrite(f.cdata,[strcat('../Charts/',chartTitle,'.png')]);
close all;