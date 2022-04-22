set(gcf,'position',[400,400,560,420]);  
set(findobj(gca,'Type','Line'),'LineWidth',3);
set(get(gca,'XLabel'),'FontSize',20,'FontName','Times','FontWeight','normal');
set(get(gca,'YLabel'),'FontSize',20,'FontName','Times','FontWeight','normal');
set(get(gca,'Title'),'FontSize',20,'FontName','Times','FontWeight','normal');
set(gca,'fontsize',20);
grid on;
set(gcf,'color','w');