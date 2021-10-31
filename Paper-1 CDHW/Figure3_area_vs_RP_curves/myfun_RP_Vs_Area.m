function myfun_RP_Vs_Area(fig,ax_pos,loc,name,vq2,xq)
ax=ax_pos;
X1=xq;
l=0.1;
w=0.18;
xl_data=importdata('L:\codes_paper1\Plot26\referenceRegions.xls');
for i=1:length(loc)
    YMatrix1=vq2{loc(i),1}(:,4:end);
    ax2(i)=axes('Parent',fig,'FontSize',15,'Position',[ax(i,:),l,w],'TickDir','out','FontName','times');hold(ax2(i),'on');
    box(ax2(i),'on'); 
    h(1)=plot(X1,YMatrix1(:,1),'Color',[0 0 1],'LineWidth',1.5);
    
    h(2)=plot(X1,YMatrix1(:,2),'Color',[0 1 0],'LineWidth',1.5);
    h(3)=plot(X1,YMatrix1(:,3),'Color',[1 0 0],'LineWidth',1.5);
    h(4)=plot(X1,YMatrix1(:,4),'k:.','LineWidth',1.5);
    ylabel('% of Area');
    xlabel('RP (years)');
    set(ax2(i),'XGrid','on','YGrid','on','GridColor',0.3*[1 1 1],'xlim',[0,13.5]);
    
     %% title box resources
    idx_of_brace=strfind(xl_data.textdata{loc(i)+1,1},'[');
    fullname=xl_data.textdata{loc(i)+1,1}(1:idx_of_brace-1);
    shortname=xl_data.textdata{loc(i)+1,1}(idx_of_brace+1:idx_of_brace+3);
    heading_name=strcat(fullname,{'  '},'(',shortname,')');
    annotation(fig,'textbox',...
        [ax_pos(i,1)+0.03,ax_pos(i,2)+0.19,0.042,0.018],...
        'Color',[0 0 0],...
        'String',heading_name,...
        'FontSize',12,...
        'FontName','Times New Roman',...
        'FitBoxToText','on',...
        'EdgeColor','none',...
        'HorizontalAlignment','center',...
        'BackgroundColor','none');
    
    
    hold(ax2(i),'off');
    
    
end
lgd=legend;
lgd.Orientation='horizontal';
lgd.Location='southoutside';
lgd.Position=[0.38 0.02 0.30 0.032];
lgd.EdgeColor='none';
lgd.FontSize=18;
lgd.String={'SSP1-2.6','SSP2-4.5','SSP5-8.5','Observation'};
end %% end of parent function

