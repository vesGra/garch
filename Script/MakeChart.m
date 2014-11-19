function  [result]=MakeChart(name,weightCount)
% 生成图表
% weightCount : 占比个数，是否包含进攻与防守两个
if isempty(name)
     error('名称必须有！');
end
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
[His1,His2,flag] = LoadData(model,type,name,weightCount);

%2 DCC101_1
model='DCC'; 
type='DCC101_1';      
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
    end    
end
%3 DCC101_Every
model='DCC'; 
type='DCC101_Every';   
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
    end    
end

%4 BEKK101_1
model='BEKK'; 
type='BEKK101_1';  
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
    end    
end
%5 BEKK101_1
model='BEKK'; 
type='BEKK101_Every'; 
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
    end    
end
%6 Factor101_1
model='Factor'; 
type='Factor101_1';     
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
    end    
end
%7 Factor101_1
model='Factor'; 
type='Factor101_Every'; 
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
    end    
end

%8 Gogarch11_1
model='Gogarch'; 
type='Gogarch11_1'; 
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
    end    
end
%9 Gogarch11_1
model='Gogarch'; 
type='Gogarch11_Every'; 
chartTitle=strcat(name,' Historical & ',type,' volatility');
chartLegend=strcat('''','Historical','''',',');
[Data,Data2,flag] = LoadData(model,type,name,weightCount);
if(flag==1)
    chartLegend=strcat(chartLegend,'''',type,'''',',');   
    data=[His1 Data'];
    data2=[His2 Data2'];
    if(weightCount==1)
      SaveChart(data,chartLegend,chartTitle);
    elseif(weightCount==2)
      chartTitle1=strcat(chartTitle,'(Defensive)');
      SaveChart(data,chartLegend,chartTitle1);
      chartTitle2=strcat(chartTitle,'(Offensive)');
     SaveChart(data2,chartLegend,chartTitle2);
    end    
end


