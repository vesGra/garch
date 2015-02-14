%生成图表，并保存
% 生成Portfolio的图表使用
function  [result]=SaveChartPub(data,chartLegend,chartTitle,filename)

figure1=figure('Position',[0 30 1100 550]);
% plot(data,'linewidth',2);
plot(data);
set(gcf,'Position',[-50 30 1100 500]);
set(gcf, 'color', 'white');
set(gca, 'color', 'white');
 set(gca,'FontSize',13);
set(gcf, 'InvertHardCopy', 'off');
% set(gca,'xticklabel',{'2013-04-09','2013-05-09','2013-06-09','2013-07-09','2013-08-09','2013-09-09','2013-10-09','2013-11-09','2013-12-09','2014-01-09','2014-02-09','2014-03-09','2014-04-09'});
% set(gca,'XTick',[1 22 44 66 88 110 132 154 176 198 220 242 261]);Apr.04  Aug.05 Nov.06 Feb.08 May09 Aug.10 Nov.11 Feb.13 Apr.14
set(gca,'xticklabel',{'Apr04','Aug05','Nov06','Feb08','May09','Aug10','Nov11','Feb13', 'Apr14'});
set(gca,'XTick',[1  326  652  978  1304  1630  1956 2282  2609]);
title(chartTitle);
% strcat('legend(',chartLegend,')');SouthEast
eval(strcat('legend(',chartLegend,')'));
% legend('Location','best');
legend('Location','SouthEast');
xlabel('Date');
ylabel('Cumulative Return');
% set(gca,'LineWidth',2.0); 
f=getframe(gcf);
imwrite(f.cdata,[strcat('../Charts/',filename,'.png')]);
close all;