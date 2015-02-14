% 生成图表，并保存文件。
% 对比图使用
function  [result]=SaveChart_All(chartData,name)
%判断
% if isempty(chartData.data1)||isempty(chartData.data2)||isempty(chartData.data3)||isempty(chartData.data4)||isempty(chartData.data5)||isempty(chartData.data6)||isempty(chartData.data7)||isempty(chartData.data8)
%     return;
% end
count=0;
col=1;
row=1;
index=0;
if ~isempty(chartData.data1)
    count=count+1;
end
if ~isempty(chartData.data2)
    count=count+1;
end
if ~isempty(chartData.data3)
    count=count+1;
end
if ~isempty(chartData.data4)
    count=count+1;
end
if ~isempty(chartData.data5)
    count=count+1;
end
if ~isempty(chartData.data6)
    count=count+1;
end
if ~isempty(chartData.data7)
    count=count+1;
end
if ~isempty(chartData.data8)
    count=count+1;
end
if ~isempty(chartData.data9)
    count=count+1;
end
if ~isempty(chartData.data10)
    count=count+1;
end
if(count==0)
    return;
elseif(count==1)
    col=1;
    row=1;
elseif(count<4)
   col=1;
   row=count;
else
   col=2;
   row=ceil(count/2);
end
%生成图表，并保存
figure1=figure('Position',[0 30 1880 1880]);
set(gcf, 'color', 'white');
set(gca, 'color', 'white');
%4*2 8张

if ~isempty(chartData.data1)
    index=index+1;
    subplot(row,col,index);
    cdata=chartData.data1;
    chartLegend=strcat(cdata.chartLegend,'''',' ','''');
    chartLegend=strrep(chartLegend,'Every','r');
    [chartLegend]=ModifyName(chartLegend);
    [chartTitle]=ModifyName(cdata.chartTitle);
    plot(cdata.data);
    set(gca,'xticklabel',{'Apr13','Aug13','Dec13','Apr14'});
    set(gca,'XTick',[1 88 176 261]);
    title(chartTitle);
    strcat('legend(',chartLegend,')');
    eval(strcat('legend(',chartLegend,')'));
    xlabel('Date');
    ylabel('volatility');
end
if ~isempty(chartData.data2)
    index=index+1;
    subplot(row,col,index);
    cdata=chartData.data2;
    chartLegend=strcat(cdata.chartLegend,'''',' ','''');
    chartLegend=strrep(chartLegend,'Every','r');
    [chartLegend]=ModifyName(chartLegend);
    [chartTitle]=ModifyName(cdata.chartTitle);
    plot(cdata.data);
   set(gca,'xticklabel',{'Apr13','Aug13','Dec13','Apr14'});
    set(gca,'XTick',[1 88 176 261]);
    title(chartTitle);
    strcat('legend(',chartLegend,')');
    eval(strcat('legend(',chartLegend,')'));
    xlabel('Date');
    ylabel('volatility');
end
if ~isempty(chartData.data3)
    index=index+1;
    subplot(row,col,index);
    cdata=chartData.data3;
    chartLegend=strcat(cdata.chartLegend,'''',' ','''');
    chartLegend=strrep(chartLegend,'Every','r');
    [chartLegend]=ModifyName(chartLegend);
    [chartTitle]=ModifyName(cdata.chartTitle);
    plot(cdata.data);
  set(gca,'xticklabel',{'Apr13','Aug13','Dec13','Apr14'});
    set(gca,'XTick',[1 88 176 261]);
    title(chartTitle);
    strcat('legend(',chartLegend,')');
    eval(strcat('legend(',chartLegend,')'));
    xlabel('Date');
    ylabel('volatility');
end
if ~isempty(chartData.data4)
    index=index+1;
    subplot(row,col,index);
    cdata=chartData.data4;
    chartLegend=strcat(cdata.chartLegend,'''',' ','''');
    chartLegend=strrep(chartLegend,'Every','r');
    [chartLegend]=ModifyName(chartLegend);
   [chartTitle]=ModifyName(cdata.chartTitle);
    plot(cdata.data);
   set(gca,'xticklabel',{'Apr13','Aug13','Dec13','Apr14'});
    set(gca,'XTick',[1 88 176 261]);
    title(chartTitle);
    strcat('legend(',chartLegend,')');
    eval(strcat('legend(',chartLegend,')'));
    xlabel('Date');
    ylabel('volatility');
end
if ~isempty(chartData.data5)
    index=index+1;
    subplot(row,col,index);
    cdata=chartData.data5;
    chartLegend=strcat(cdata.chartLegend,'''',' ','''');
    chartLegend=strrep(chartLegend,'Every','r');
    [chartLegend]=ModifyName(chartLegend);
    [chartTitle]=ModifyName(cdata.chartTitle);
    plot(cdata.data);
   set(gca,'xticklabel',{'Apr13','Aug13','Dec13','Apr14'});
    set(gca,'XTick',[1 88 176 261]);
    title(chartTitle);
    strcat('legend(',chartLegend,')');
    eval(strcat('legend(',chartLegend,')'));
    xlabel('Date');
    ylabel('volatility');
end
if ~isempty(chartData.data6)
    index=index+1;
    subplot(row,col,index);
    cdata=chartData.data6;
    chartLegend=strcat(cdata.chartLegend,'''',' ','''');
    chartLegend=strrep(chartLegend,'Every','r');
    [chartLegend]=ModifyName(chartLegend);
    [chartTitle]=ModifyName(cdata.chartTitle);
    plot(cdata.data);
   set(gca,'xticklabel',{'Apr13','Aug13','Dec13','Apr14'});
    set(gca,'XTick',[1 88 176 261]);
    title(chartTitle);
    strcat('legend(',chartLegend,')');
    eval(strcat('legend(',chartLegend,')'));
    xlabel('Date');
    ylabel('volatility');
end
if ~isempty(chartData.data7)
    index=index+1;
    subplot(row,col,index);
    cdata=chartData.data7;
    chartLegend=strcat(cdata.chartLegend,'''',' ','''');
    chartLegend=strrep(chartLegend,'Every','r');
    [chartLegend]=ModifyName(chartLegend);
    [chartTitle]=ModifyName(cdata.chartTitle);
    plot(cdata.data);
   set(gca,'xticklabel',{'Apr13','Aug13','Dec13','Apr14'});
    set(gca,'XTick',[1 88 176 261]);
    title(chartTitle);
    strcat('legend(',chartLegend,')');
    eval(strcat('legend(',chartLegend,')'));
    xlabel('Date');
    ylabel('volatility');
end
if ~isempty(chartData.data8)
    index=index+1;
    subplot(row,col,index);
    cdata=chartData.data8;
    chartLegend=strcat(cdata.chartLegend,'''',' ','''');
    chartLegend=strrep(chartLegend,'Every','r');
    [chartLegend]=ModifyName(chartLegend);
   [chartTitle]=ModifyName(cdata.chartTitle);
    plot(cdata.data);
   set(gca,'xticklabel',{'Apr13','Aug13','Dec13','Apr14'});
    set(gca,'XTick',[1 88 176 261]);
    title(chartTitle);
    strcat('legend(',chartLegend,')');
    eval(strcat('legend(',chartLegend,')'));
    xlabel('Date');
    ylabel('volatility');
end
if ~isempty(chartData.data9)
    index=index+1;
    subplot(row,col,index);
    cdata=chartData.data9;
    chartLegend=strcat(cdata.chartLegend,'''',' ','''');
    chartLegend=strrep(chartLegend,'Every','r');
    [chartLegend]=ModifyName(chartLegend);
   [chartTitle]=ModifyName(cdata.chartTitle);
    plot(cdata.data);
   set(gca,'xticklabel',{'Apr13','Aug13','Dec13','Apr14'});
    set(gca,'XTick',[1 88 176 261]);
    title(chartTitle);
    strcat('legend(',chartLegend,')');
    eval(strcat('legend(',chartLegend,')'));
    xlabel('Date');
    ylabel('volatility');
end
if ~isempty(chartData.data10)
    index=index+1;
    subplot(row,col,index);
    cdata=chartData.data10;
    chartLegend=strcat(cdata.chartLegend,'''',' ','''');
    chartLegend=strrep(chartLegend,'Every','r');
    [chartLegend]=ModifyName(chartLegend);
   [chartTitle]=ModifyName(cdata.chartTitle);
    plot(cdata.data);
   set(gca,'xticklabel',{'Apr13','Aug13','Dec13','Apr14'});
    set(gca,'XTick',[1 88 176 261]);
    title(chartTitle);
    strcat('legend(',chartLegend,')');
    eval(strcat('legend(',chartLegend,')'));
    xlabel('Date');
    ylabel('volatility');
end
%end save
% set(gca,'FontSize',11);
set(gcf,'Position',[-130 30 1570 700]);
f=getframe(gcf);
imwrite(f.cdata,[strcat('../Charts/',name,'.png')]);
close all;