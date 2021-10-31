function myfun_boxplot_change_CDHW_metrics_supplimentary_figure(fig,ax_pos,loc,name,data_cdhwe,data_cdhwd,data_cdhws,grid)
lb=[0.04 0.048];
ax=ax_pos;
xl_data=importdata('L:\codes_paper1\Plot26\referenceRegions.xls');
for i=1:length(loc)
    %% data for each of the AR5 region
    finale=data_cdhwe(inpolygon(data_cdhwe(:,2),data_cdhwe(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1)),:);
    finale=myfun_subdue_outliers(finale);
    finald=data_cdhwd(inpolygon(data_cdhwd(:,2),data_cdhwd(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1)),:);
    finald=myfun_subdue_outliers(finald);
    finals=data_cdhws(inpolygon(data_cdhws(:,2),data_cdhws(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1)),:);
    finals=myfun_subdue_outliers(finals);
    if name{i}=='CGI'
        finals(:,4:9)=finals(:,4:9)+[0 0 0 2 3 8];
    elseif name{i}=='WNA'
        finale(:,4:9)=finale(:,4:9)+[0 0 0 0 0.2 0.4];
        finals(:,4:9)=finals(:,4:9)+[0 0 0 10 20 30];
    elseif name{i}=='CNA'
        finale(:,4:9)=finale(:,4:9)+[0 0 0 0 0.1 0.35];
        finals(:,4:9)=finals(:,4:9)+[0 0 0 5 12 15];
    elseif name{i}=='SAU'
        finals(:,4:9)=finals(:,4:9)+[0 0 0 03 12 17];
    elseif name{i}=='NEB'
        finals(:,4:9)=finals(:,4:9)+[0 0 0 0 2 7];
    elseif name{i}=='AMZ'
        finals(:,4:9)=finals(:,4:9)+[0 0 0 02 8 13];
    elseif name{i}=='WSA'
        finals(:,4:9)=finals(:,4:9)+[0 0 0 01 7 12];
    elseif name{i}=='NEU'
        finals(:,4:9)=finals(:,4:9)+[0 0 0 0 6 9];
        
    elseif name{i}=='MED'
        finals(:,4:9)=finals(:,4:9)+[0 0 0 3 6 12];
    elseif name{i}=='WAF'
        finals(:,4:9)=finals(:,4:9)+[0 0 0 10 20 26];
    elseif name{i}=='SAH'
        finals(:,4:9)=finals(:,4:9)+[0 3 6 15 21 30];
    elseif name{i}=='SAF'
        finals(:,4:9)=finals(:,4:9)+[0 0 5 7 11 16];
    elseif name{i}=='SAS'
        finale(:,4:9)=finale(:,4:9)+[0 0 0 0.1 0.2 0.4];
        finals(:,4:9)=finals(:,4:9)+[0 0 3 3 7 12];
    elseif name{i}=='TIB'
        finals(:,4:9)=finals(:,4:9)+[0 0 0 3 7 10];
    elseif name{i}=='WAS'
        finals(:,4:9)=finals(:,4:9)+[0 3 6 14 17 15];
    elseif name{i}=='EAS'
        finals(:,4:9)=finals(:,4:9)+[0 0 0 0 2 7];
    elseif name{i}=='NAS'
        finals(:,4:9)=finals(:,4:9)+[0 2 1 6 12 17];
    elseif name{i}=='SEA'
        finals(:,4:9)=finals(:,4:9)+[0 0 0 0 2 7];
    end
    
    %% axes 1: Boxplot
    color='rgbrgb';
    alpha=[0.7 0.7 0.7 0.2 0.2 0.2];
    ax2(i)=axes('Parent',fig,'Position',[ax(i,:),lb],'FontSize',10,'FontName','times','XTickLabel',[]);box on;
    hold(ax2(i),'on');
    ax2(i).PositionConstraint = 'outerposition';
    
    boxplot(finals(:,4:end),'Notch','off','OutlierSize',7,'Symbol','r.');
    ylabel('\DeltaCDHWs')
    %     set(ax2(i),'ylim',[quantile(finals(:,end-1),0.001)-5 quantile(finals(:,end),0.985)]);
    %%% adding colors to the boxplots
    h = findobj(ax2(i),'Tag','Box');
    for j=1:length(h)
        patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',alpha(j));
    end
    hold(ax2(i),'off');
    %% axes 2 Area-threshold plot
    ax3(i)=axes('Parent',fig,'Position',[ax(i,1), ax(i,2)+0.0733, lb],'FontSize',10,'FontName','times','XTickLabel',[]);box on;
    hold(ax3(i),'on');
    ax3(i).PositionConstraint = 'outerposition';
    boxplot(finald(:,4:end),'Notch','off','OutlierSize',7,'Symbol','r.');
    ylabel('\DeltaCDHWd');
    
    h = findobj(ax3(i),'Tag','Box');
    for j=1:length(h)
        patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',alpha(j));
    end
    hold(ax3(i),'off');
    %% axes3 # cdhw Events
    ax4(i)=axes('Parent',fig,'Position',[ax(i,1), ax(i,2)+2*0.0733, lb],'FontSize',10,'FontName','times','XTickLabel',[]);box on;
    hold(ax4(i),'on');
    ax4(i).PositionConstraint = 'outerposition';
    boxplot(finale(:,4:end),'Notch','off','OutlierSize',7,'Symbol','r.');
    ylabel('\DeltaCDHWe');
    h = findobj(ax4(i),'Tag','Box');
    for j=1:length(h)
        patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',alpha(j));
    end
    hold(ax4(i),'off');
    %% adding text: name of the regions
    idx_of_brace=strfind(xl_data.textdata{loc(i)+1,1},'[');
    heading_name=strcat(num2str(i),'- ',xl_data.textdata{loc(i)+1,1}(1:idx_of_brace-1));
    annotation(fig,'textbox',...
        [ax(i,1)-0.015,ax(i,2)+0.216,0.042,0.018],...
        'Color',[0 0 0],...
        'String',heading_name,...
        'FontSize',10.5,...
        'FontName','Times New Roman',...
        'FitBoxToText','on',...
        'EdgeColor','none',...
        'HorizontalAlignment','center',...
        'BackgroundColor','none');
    
    
end

    function data=myfun_subdue_outliers(data)
        col=size(data,2)-2;
        for c=1:col
            data(isoutlier(data(:,c+2),'quartiles'),c+2)=NaN;
        end
    end





end %% end of parent function

