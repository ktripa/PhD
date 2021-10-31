function myfun_RP_Vs_Area_supp(fig,ax_pos,loc,name,vq2,xq)
ax=ax_pos;
X1=xq;
for i=1:length(loc)
    YMatrix1=vq2{loc(i),1}(:,4:end);
    ax2(i)=axes('Parent',fig,'FontName','times','FontSize',12,'Position',ax(i,:),'TickDir','out','LineWidth',1.2);
    hold(ax2(i),'on');
    box(ax2(i),'on'); 
    h(1)=plot(X1,YMatrix1(:,1),'Color',[0 0 1],'LineWidth',1.5);
    
    h(2)=plot(X1,YMatrix1(:,2),'Color',[0 1 0],'LineWidth',1.5);
    h(3)=plot(X1,YMatrix1(:,3),'Color',[1 0 0],'LineWidth',1.5);
    h(4)=plot(X1,YMatrix1(:,4),'k:.','LineWidth',1.5);
    ylabel('% of Area');
    xlabel('RP (years)');
    title(name{i});
    set(ax2(i),'XGrid','on','YGrid','on','GridColor',[0.65,0.65,0.65],'xlim',[0,13.5]);
    hold(ax2(i),'off');
end

end %% end of parent function

