function myfun_RP_Vs_Area_supplimentary(fig,ax_pos,loc,name,vq2,xq)
l=0.05;w=0.1;
ax=ax_pos;
X1=xq;
xl_data=importdata('L:\codes_paper1\Plot26\referenceRegions.xls');
for i=1:length(loc)
    YMatrix1=vq2{loc(i),1}(:,4:end);
    ax2(i)=axes('Parent',fig,'FontName','times','FontSize',10.5,'Position',[ax(i,:),l,w],'TickDir','out','LineWidth',1.2);
    hold(ax2(i),'on');
    box(ax2(i),'on'); 
    h(1)=plot(X1,YMatrix1(:,1),'Color',[0 0 1],'LineWidth',1.5);
    
    h(2)=plot(X1,YMatrix1(:,2),'Color',[0 1 0],'LineWidth',1.5);
    h(3)=plot(X1,YMatrix1(:,3),'Color',[1 0 0],'LineWidth',1.5);
    h(4)=plot(X1,YMatrix1(:,4),'k:.','LineWidth',1.5);
    ylabel('% of Area');
    xlabel('RP (years)');
    set(ax2(i),'XGrid','on','YGrid','on','GridColor',[0.65,0.65,0.65],'xlim',[0,13.5]);
    hold(ax2(i),'off');
    
    idx_of_brace=strfind(xl_data.textdata{loc(i)+1,1},'[');
    heading_name=strcat(num2str(i),'- ',xl_data.textdata{loc(i)+1,1}(1:idx_of_brace-1));
    annotation(fig,'textbox',...
        [ax(i,1),ax(i,2)+0.11,0.042,0.018],...
        'Color',[0 0 0],...
        'String',heading_name,...
        'FontSize',10.5,...
        'FontName','Times New Roman',...
        'FitBoxToText','on',...
        'EdgeColor','none',...
        'HorizontalAlignment','center',...
        'BackgroundColor','none');
end

end %% end of parent function

