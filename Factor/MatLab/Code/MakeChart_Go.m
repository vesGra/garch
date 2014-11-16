 subplot(3,1,1);
 plot([Alternative_Result_His]);
 set(gca,'xticklabel',{'2013-04-09','2013-05-09','2013-06-09','2013-07-09','2013-08-09','2013-09-09','2013-10-09','2013-11-09','2013-12-09','2014-01-08','2014-02-08','2014-03-08','2014-04-08'});
 set(gca,'XTick',[1 22 44 66 88 110 132 154 176 198 220 242 261])
 legend('Historical volatility','dcc his');
 title('Historical volatility');
 xlabel('Date');
 ylabel('volatility');
 subplot(3,1,2);
 plot(Alternative_Result_gogarch11)
 set(gca,'xticklabel',{'2013-04-09','2013-05-09','2013-06-09','2013-07-09','2013-08-09','2013-09-09','2013-10-09','2013-11-09','2013-12-09','2014-01-08','2014-02-08','2014-03-08','2014-04-08'});
 set(gca,'XTick',[1 22 44 66 88 110 132 154 176 198 220 242 261])
 title('gogarch11 volatility');
 legend('gogarch11 volatility');
 xlabel('Date');
ylabel('volatility');
subplot(3,1,3);
 plot([Alternative_DCC101_1 sqrt(His_Result1)'])
 set(gca,'xticklabel',{'2013-04-09','2013-05-09','2013-06-09','2013-07-09','2013-08-09','2013-09-09','2013-10-09','2013-11-09','2013-12-09','2014-01-08','2014-02-08','2014-03-08','2014-04-08'});
 set(gca,'XTick',[1 22 44 66 88 110 132 154 176 198 220 242 261])
 title('Historical volatility&gogarch11 volatility');
 legend('Historical volatility','gogarch11 volatility','Factor101 volatility');
 xlabel('Date');
ylabel('volatility');

% plot([Equity,'linewidth',1);
% set(gca,'xticklabel',{'2005-04-09','2006-04-09','2007-04-09','2008-04-09','2009-04-09','2010-04-09','2011-04-09','2012-04-09','2013-04-09','2014-04-08'});
% set(gca,'XTick',[1 261 522 783 1044 1305 1566 1827 2088  2349])
% xlabel('Date');
% ylabel('volatility');
% legend('Historical volatility','DCC volatility','BEKK volatility');

