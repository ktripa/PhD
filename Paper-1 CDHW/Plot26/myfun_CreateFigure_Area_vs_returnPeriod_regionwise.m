function myfun_CreateFigure_Area_vs_returnPeriod_regionwise(location,vq2,xq,name,axes)
loc=location;
YMatrix1=vq2(:,4:end);X1=xq;



plot1 = plot(X1,YMatrix1,'parent',axes,'LineWidth',1.5);
set(plot1(1),'Color',[0 0 1]);
set(plot1(2),'Color',[0 1 0]);
set(plot1(3),'Color',[1 0 0]);
set(plot1(4),'Marker','.','LineWidth',1,'LineStyle',':','Color',[0 0 0]);
ylabel('% of Area');
xlabel('RP (years)');

title(name,'FontSize',10,...
    'Color',[0.635294117647059 0.0784313725490196 0.184313725490196]);
set(axes,'XGrid','on','YGrid','on','GridColor',[0.65,0.65,0.65],'xlim',[0,13.5]);
hold off;




