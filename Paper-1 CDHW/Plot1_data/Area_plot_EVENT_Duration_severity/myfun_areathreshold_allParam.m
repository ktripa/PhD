function myfun_areathreshold_allParam(final,axes,lgd_tag)
        colormap(autumn);
        final(:,2:end) = movmean(final(:,2:end),9,1);
        hold(axes,'on');
        set(axes,'FontSize',14,'TickDir','out');
        
        % Create multiple lines using matrix input to area
        area11 = area(final(:,1),final(:,2),'EdgeColor','none','Parent',axes);
        hold on;
        
        area12 = area(final(:,1),final(:,3),'EdgeColor','none','Parent',axes);
        area13 = area(final(:,1),final(:,4),'EdgeColor','none','Parent',axes);
        area14 = area(final(:,1),final(:,5),'EdgeColor','none','Parent',axes);
        set(area14,'DisplayName','<20% area','FaceAlpha',0.35,...
            'FaceColor',[1 1 0.0666666666666667]);
        set(area13,'DisplayName','<40% area','FaceAlpha',0.45);
        set(area12,'DisplayName','<60% area','FaceAlpha',0.5,...
            'FaceColor',[1 0 0]);
        set(area11,'DisplayName','<80% area','FaceAlpha',0.6,...
            'FaceColor',[0.0588235294117647 1 1]);
       xline(2020,'k--','Color',[0.6,0.6,0.6]);
        xline(2058,'k--','Color',[0.6,0.6,0.6])
        % Create ylabel
        %
        
        % Create xlabel
        xlabel('Years','FontSize',14);
        
        xlim(axes,[final(1,1) final(end,1)]);
        box(axes,'on');
%         hold(axes,'off');
        % Set the remaining axes properties
        set(axes,'XTick',[1982:20:2095]);
        lgd=legend('<20% area','<40% area','<60% area','<80% area','Orientation','horizontal','Location','southoutside','FontSize',14);
%         lgd.Orientation('Horizontal');
%         lgd.Location('South')
lgd.EdgeColor=[1 1 1];
        legend(lgd_tag);
        
    end %% end of nested function