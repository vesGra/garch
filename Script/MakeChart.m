function  [result]=MakeChart(name,weightCount,numfactors)
% 生成图表
% weightCount : 占比个数，是否包含进攻与防守两个
if isempty(name)
     error('名称必须有！');
end
%最终的四个图表数据
tempData11=[];
tempData21=[];
tempData31=[];
tempData41=[];
tempData51=[];
tempData61=[];
tempData71=[];
tempData81=[];
tempData12=[];
tempData22=[];
tempData32=[];
tempData42=[];
tempData52=[];
tempData62=[];
tempData72=[];
tempData82=[];
tempData23=[];
tempData24=[];
tempData43=[];
tempData44=[];
tempData83=[];
tempData84=[];
tempData63=[];
tempData64=[];


YC=[];
result=0;
data=[];
data2=[];
chartTitle=strcat(name,' volatility');
His1=[];
His2=[];
%Load Datas 'Historical'
%1 His
model='His'; 
type='His';      
[His1,His2,flag] = LoadData(model,type,name,weightCount,[]);

%2 DCC101_1
model='DCC'; 
type='DCC101_1';      
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,[]);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData11 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData11 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData12 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
%3 DCC101_Every
model='DCC'; 
type='DCC101_Every';   
YC=1;
chartTitle=strcat(name,' Historical & ',type,'_',num2str(YC),' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,YC);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'_',num2str(YC),'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
   if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData21 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData21 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData22 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
model='DCC'; 
type='DCC101_Every';   
YC=3;
chartTitle=strcat(name,' Historical & ',type,'_',num2str(YC),' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,YC);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'_',num2str(YC),'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData23 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData23 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData24 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
% data2=[His2 tempData23.data tempData21.data tempData11.data];
% SaveChart(data2,chartLegend,chartTitle);
YC=[];
%4 BEKK101_1
model='BEKK'; 
type='BEKK101_1';  
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,[]);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData31 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData31 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData32 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
%5 BEKK101_1
model='BEKK'; 
type='BEKK101_Every'; 
YC=1;
chartTitle=strcat(name,' Historical & ',type,'_',num2str(YC),' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,YC);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'_',num2str(YC),'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData41 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData41 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData42 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
model='BEKK'; 
type='BEKK101_Every'; 
YC=3;
chartTitle=strcat(name,' Historical & ',type,'_',num2str(YC),' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,YC);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'_',num2str(YC),'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData43 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData43 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData44 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
YC=[];
%6 Factor101_1
model='Factor'; 
type='Factor101_1';     
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,[]);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'_',numfactors,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData51 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData51 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData52 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
%7 Factor101_1
model='Factor'; 
type='Factor101_Every'; 
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,[]);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'_',numfactors,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData61 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData61 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData62 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
%7+ Factor101_3
model='Factor'; 
type='Factor101_Every'; 
YC=3;
chartTitle=strcat(name,' Historical & ',type,'_',num2str(YC),' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,YC+1);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'_',num2str(YC),'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData63 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData63 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData64 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
%8 Gogarch11_1
model='Gogarch'; 
type='Gogarch11_1'; 
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,[]);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData71 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData71 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData72 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
%9 Gogarch11_1
model='Gogarch'; 
type='Gogarch11_Every'; 
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,[]);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData81 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData81 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData82 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
%10 Gogarch11_3
model='Gogarch'; 
type='Gogarch11_Every'; 
YC=3;
chartTitle=strcat(name,' Historical & ',type,'_',num2str(YC),' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount,YC+1);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'_',num2str(YC),'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
      tempData83 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      tempData83 = struct('data',data,'chartLegend',chartLegend,'chartTitle',chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
     tempData84 = struct('data',data2,'chartLegend',chartLegend,'chartTitle',chartTitle2);
    end    
end
%生成总的图表图片
% 8*8
if(weightCount==1)
      chartData1 = struct('data1',tempData11,'data2',tempData21,'data3',tempData31,'data4',tempData41,'data5',tempData51,'data6',tempData61,'data7',tempData71,'data8',tempData81,'data9',tempData63,'data10',tempData83);
      SaveChart_All(chartData1,strcat(name,'1'));
      if ~isempty(tempData23)
          chartData1 = struct('data1',tempData11,'data2',tempData23,'data3',tempData31,'data4',tempData41,'data5',tempData51,'data6',tempData61,'data7',tempData71,'data8',tempData81,'data9',tempData63,'data10',tempData83);
          SaveChart_All(chartData1,strcat(name,'2'));
      end
      if ~isempty(tempData43)
          chartData1 = struct('data1',tempData11,'data2',tempData21,'data3',tempData31,'data4',tempData43,'data5',tempData51,'data6',tempData61,'data7',tempData71,'data8',tempData81,'data9',tempData63,'data10',tempData83);
          SaveChart_All(chartData1,strcat(name,'3'));
      end
      if ~isempty(tempData43) && ~isempty(tempData23)     
          chartData1 = struct('data1',tempData11,'data2',tempData23,'data3',tempData31,'data4',tempData43,'data5',tempData51,'data6',tempData61,'data7',tempData71,'data8',tempData81,'data9',tempData63,'data10',tempData83);
          SaveChart_All(chartData1,strcat(name,'4'));
      end
      if ~isempty(tempData23)
          chartData1 = struct('data1',tempData21,'data2',tempData23,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' DCC r1&r3'));
      end
      if ~isempty(tempData43)
          chartData1 = struct('data1',tempData41,'data2',tempData43,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' BEKK r1&r3'));
      end
      if ~isempty(tempData63)
          chartData1 = struct('data1',tempData61,'data2',tempData63,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' Factor r1&r3'));
      end
      if ~isempty(tempData83)
          chartData1 = struct('data1',tempData81,'data2',tempData83,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' Gogarch r1&r3'));
      end
    elseif(weightCount==2)
      chartData1 = struct('data1',tempData11,'data2',tempData21,'data3',tempData31,'data4',tempData41,'data5',tempData51,'data6',tempData61,'data7',tempData71,'data8',tempData81,'data9',tempData63,'data10',tempData83);
      SaveChart_All(chartData1,strcat(name,'1(Defensive)'));
      if ~isempty(tempData23)
          chartData1 = struct('data1',tempData11,'data2',tempData23,'data3',tempData31,'data4',tempData41,'data5',tempData51,'data6',tempData61,'data7',tempData71,'data8',tempData81,'data9',tempData63,'data10',tempData83);
          SaveChart_All(chartData1,strcat(name,'2(Defensive)'));
      end
      if ~isempty(tempData43)
          chartData1 = struct('data1',tempData11,'data2',tempData21,'data3',tempData31,'data4',tempData43,'data5',tempData51,'data6',tempData61,'data7',tempData71,'data8',tempData81,'data9',tempData63,'data10',tempData83);
          SaveChart_All(chartData1,strcat(name,'3(Defensive)'));
      end
      if ~isempty(tempData43) && ~isempty(tempData23)     
          chartData1 = struct('data1',tempData11,'data2',tempData23,'data3',tempData31,'data4',tempData43,'data5',tempData51,'data6',tempData61,'data7',tempData71,'data8',tempData81,'data9',tempData63,'data10',tempData83);
          SaveChart_All(chartData1,strcat(name,'4(Defensive)'));
      end
       if ~isempty(tempData23)
          chartData1 = struct('data1',tempData21,'data2',tempData23,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' DCC r1&r3(Defensive)'));
      end
      if ~isempty(tempData43)
          chartData1 = struct('data1',tempData41,'data2',tempData43,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' BEKK r1&r3(Defensive)'));
      end
       if ~isempty(tempData63)
          chartData1 = struct('data1',tempData61,'data2',tempData63,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' Factor r1&r3'));
      end
      if ~isempty(tempData83)
          chartData1 = struct('data1',tempData81,'data2',tempData83,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' Gogarch r1&r3'));
      end
      chartData1 = struct('data1',tempData12,'data2',tempData22,'data3',tempData32,'data4',tempData42,'data5',tempData52,'data6',tempData62,'data7',tempData72,'data8',tempData82,'data9',tempData64,'data10',tempData84);
      SaveChart_All(chartData1,strcat(name,'1(Offensive)'));
      if ~isempty(tempData24)
          chartData1 = struct('data1',tempData12,'data2',tempData24,'data3',tempData32,'data4',tempData42,'data5',tempData52,'data6',tempData62,'data7',tempData72,'data8',tempData82,'data9',tempData64,'data10',tempData84);
          SaveChart_All(chartData1,strcat(name,'2(Offensive)'));
      end
      if ~isempty(tempData44)
         chartData1 = struct('data1',tempData12,'data2',tempData22,'data3',tempData32,'data4',tempData44,'data5',tempData52,'data6',tempData62,'data7',tempData72,'data8',tempData82,'data9',tempData64,'data10',tempData84);
          SaveChart_All(chartData1,strcat(name,'3(Offensive)'));
      end
      if ~isempty(tempData44)&&~isempty(tempData24)
          chartData1 = struct('data1',tempData12,'data2',tempData24,'data3',tempData32,'data4',tempData44,'data5',tempData52,'data6',tempData62,'data7',tempData72,'data8',tempData82,'data9',tempData64,'data10',tempData84);
          SaveChart_All(chartData1,strcat(name,'4(Offensive)'));
      end
       if ~isempty(tempData24)
          chartData1 = struct('data1',tempData22,'data2',tempData24,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' DCC r1&r3(Offensive)'));
      end
      if ~isempty(tempData44)
          chartData1 = struct('data1',tempData42,'data2',tempData44,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' BEKK r1&r3(Offensive)'));
      end
       if ~isempty(tempData64)
          chartData1 = struct('data1',tempData62,'data2',tempData64,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' Factor r1&r3'));
      end
      if ~isempty(tempData84)
          chartData1 = struct('data1',tempData82,'data2',tempData84,'data3',[],'data4',[],'data5',[],'data6',[],'data7',[],'data8',[],'data9',[],'data10',[]);
          SaveChart_All(chartData1,strcat(name,' Gogarch r1&r3'));
      end
    end    


