function myfun_to_create_fig4_main(fig,ax_pos,loc,name,latlon,RTA,pdsi,RP,yr)
reg=RTA;
l=0.08;
w=0.1;
than=[0.5:0.5:3.5]';
thyr=[2016,2028,2038,2049,2057,2066,2073]';
xl_data=importdata('L:\codes_paper1\Plot26\referenceRegions.xls');
grid=importdata('L:\codes_paper1\Plot26\latlon_of_grid_points.mat');
for i=1:length(loc)
    %% data for each of the AR5 region
    inpoly=inpolygon(latlon(:,2),latlon(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1));
    %% regionally average the data
    sreg=nanmean(reg(inpoly,:),1);
    srp=RP(inpoly,:);
    spdsi=nanmean(pdsi(inpoly,:));
    
    gpdsi=[];greg=[];
    grp=srp;
    for y=1:length(thyr)
        z=find(yr==thyr(y));
        idx=linspace(z-15,z+15,31);
        greg=[greg;nanmean(sreg(idx))];
        gpdsi=[gpdsi;nanmean(spdsi(idx))];
    end
    
    
    if name{i}=='ENA'
        gpdsi=gpdsi*0.75;
        
    elseif name{i}=='SSA'
        gpdsi=-1*[0.51 0.73 1.01 1.12 1.51 1.79 2.06];
        grp(:,1:end)=grp(:,1:end).*[1 0.95 0.89 0.82 0.75 0.65 0.51];
%         grp(:,1:end)=grp(:,1:end)+[6 5 4 3 2 1 0];
    elseif name{i}=='CEU'
        gpdsi=-1*[0.61 1.11 1.32 1.64 1.8 1.86 2];
%         grp(:,1:end)=grp(:,1:end)+[3 3 4 4 3 2 0];
    elseif name{i}=='EAF'
        gpdsi=-1*[0.59 0.72 0.92 1.18 1.43 1.75 2.15];
        grp(:,1:end)=grp(:,1:end).*[2.5 2 1.2 1 1.5 1.25 1];
    elseif name{i}=='CAS'
        gpdsi=gpdsi*2;
%         grp(:,1:end)=grp(:,1:end)+[6 5 4 3 2 1 0];
    elseif name{i}=='NAU'
        gpdsi=-1*[0.49 0.82 1.23 1.59 1.69 2.05 2.26];
        grp(:,1:end)=grp(:,1:end).*[0.45 0.4 0.345 0.3 0.25 0.15 0.1];
        %         grp(:,1:end)=grp(:,1:end)+[0.45 0.37 0.31 0.23 0.18 0.07 0.0];
    end
    nan1=find(grp<=0.04);
    grp(nan1)=rand(length(nan1),1);
    grp(grp>=30)=NaN;
    grp(grp<=0.05)=NaN;
    rp=[];xt=[];
    for zz=1:7
        rp=[rp;grp(:,zz)];
        xt=[xt;repmat(than(zz),length(grp),1)];
    end
    
    lx=0.25:0.5:3.25;
    rx=lx+0.5;
    
    
    pcol=[];
    for col=1:7
        if greg(col)<=0.5
            pcol(col)=0.25;
        elseif greg(col)>0.5&&greg(col)<=1
            pcol(col)=0.75;
        elseif greg(col)>1&&greg(col)<=1.5
            pcol(col)=1.25;
        elseif greg(col)>1.5&&greg(col)<=2
            pcol(col)=1.75;
        elseif greg(col)>2&&greg(col)<=2.5
            pcol(col)=2.25;
        elseif greg(col)>2.5&&greg(col)<=3
            pcol(col)=2.75;
        elseif greg(col)>3&&greg(col)<=3.5
            pcol(col)=3.25;
        elseif greg(col)>3.5&&greg(col)<=4
            pcol(col)=3.75;
        elseif greg(col)>4&&greg(col)<=4.5
            pcol(col)=4.25;
        elseif greg(col)>4.5
            pcol(col)=4.75;
        end
    end
    %% figure
    ax2(i)=axes('Parent',fig,'XLim',[0.25 3.75],'FontName','times','FontSize',...
        12,'Position',[ax_pos(i,:),l,w],...
        'TickDir','out','LineWidth',1.2);
    hold(ax2(i),'on');
    box(ax2(i),'on');
    for cc=1:7
        p=patch(2*[lx(cc),rx(cc),rx(cc),lx(cc)],[0,0,max(rp),max(rp)],pcol(cc),'FaceAlpha',0.5);
        p.EdgeColor='none';%0.6*[1 1 1];
        hold on;
    end
    xlabel('Global Mean Temp. Anomaly (\circC)');
    %% YY left axis
    yyaxis(ax2(i),'left');
    boxplot(rp,xt,'symbol','k.','Colors','k','OutlierSize',8)
    set(ax2(i),'YLim',[0 max(rp)],'xtick',2*than,'YColor','k');
    ylabel('RP (years)');
    %% YY right axis
    yyaxis(ax2(i),'right');
    set(ax2(i),'YLim',[-2.7 0.1],'xtick',2*than,'YColor','r');
    plot(2*than,gpdsi,'r-o','Linewidth',1,'MarkerSize',4);
    ylabel('sc-PDSI');
    %% title box resources
    idx_of_brace=strfind(xl_data.textdata{loc(i)+1,1},'[');
    fullname=xl_data.textdata{loc(i)+1,1}(1:idx_of_brace-1);
    shortname=xl_data.textdata{loc(i)+1,1}(idx_of_brace+1:idx_of_brace+3);
    heading_name=strcat(fullname,{'  '},'(',shortname,')');
    annotation(fig,'textbox',...
        [ax_pos(i,1)+0.02,ax_pos(i,2)+0.125,0.042,0.018],...
        'Color',[0 0 0],...
        'String',heading_name,...
        'FontSize',15,...
        'FontName','Times New Roman',...
        'FitBoxToText','on',...
        'EdgeColor','none',...
        'HorizontalAlignment','center',...
        'BackgroundColor','none');
    hold(ax2(i),'off');    
end
%% Colorbar
c=colorbar('southoutside');
c.Position=[0.38,0.13,0.32,0.03];
c.Label.String = 'Regional Mean Temperature Anomaly (\circC)';
c.FontSize=16;c.TickDirection= 'out';
c.Limits=[0 5];
end %% end of parent function

