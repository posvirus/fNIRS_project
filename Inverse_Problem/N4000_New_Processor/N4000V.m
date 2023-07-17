clear all
close all
clc
disp('Open the raw data file (.csv)...');
[RawDataF,RawDataP]=uigetfile('*.csv','Pick the raw data','MultiSelect', 'on','C:\Users');
Mul_F=cell(1);
if isequal(RawDataF,0)
    error('Empty raw data file!');
else
    if ~iscell(RawDataF)
        Sin_F=[RawDataP RawDataF];
    else
        disp(1);
        for i=1:1:size(RawDataF,2)
           Mul_F{i}=[RawDataP RawDataF{i}]; 
        end
    end
    if ~iscell(RawDataF)
        R=Sin_F;
    else
        R=Mul_F;
    end
    disp('Your raw data file is:')
    disp(R);
end
disp('Generating Graph...');
if iscell(R)
    for i=1:1:size(R,2)
        [temp_path,temp_name,ext]=fileparts(R{i});
        disp(['Loadind data for No.',num2str(i),'...']);
        result_data=load(strcat(temp_path,'\derivatives\homer\',temp_name,'.mat'));
        result_HbO=result_data.output.dcAvg.GetDataTimeSeries('reshape');
        result_HbO=result_HbO(:,1,:);
        %result_HbO=result_data.output.dcAvg.dataTimeSeries(:,1:3:end);
        M_data=result_data.output.misc.mlActAuto{1,1};
        M_data=M_data(1:size(M_data,1)./2 ,:);
        [M_data,~]=sortrows(M_data,1);
        t=result_data.output.dcAvg.time;
        t=t';
        t_s=min(t):0.01:max(t);
        result_HbO=result_HbO.*1000;
        result_HbO(isnan(result_HbO))=0;
        set(0,'DefaultFigureVisible','off');
        figure
        hold on
        k=1;
        leg_str1=cell(0);
        for j=1:1:4
            if M_data(j,3)==1
                result_s=interp1(t,result_HbO(:,j),t_s,'spline');
                plot(t_s,result_s);
                set(gca,'FontName','STFangSong','FontSize',12,'LineWidth',1);
                xlabel('t/s');
                ylabel('\Delta HbO/mM·mm');
                title(strcat('实验者',temp_name(end-2:end-1),'在实验',temp_name(end),'的 \Delta HbO 变化','（右额叶）'),'FontWeight','bold');
                leg_str1{k}=[strcat('S',num2str(M_data(j,1)),'D',num2str(M_data(j,2)))];
                %disp([M_data(j,1),M_data(j,2)])
                k=k+1;
            end
        end
        legend(leg_str1,'Location','southeast');
        xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
        xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
        xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
        xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
        mkdir(temp_path,temp_name); 
        saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'_right_frontal_lobe','.png'));
        hold off
        figure
        hold on
        k=1;
        leg_str2=cell(0);
        for j=5:1:8
            if M_data(j,3)==1
                result_s=interp1(t,result_HbO(:,j),t_s,'spline');
                plot(t_s,result_s);
                set(gca,'FontName','STFangSong','FontSize',12,'LineWidth',1);
                xlabel('t/s');
                ylabel('\Delta HbO/mM·mm');
                title(strcat('实验者',temp_name(end-2:end-1),'在实验',temp_name(end),'的 \Delta HbO 变化','（左额叶）'),'FontWeight','bold');
                leg_str2{k}=[strcat('S',num2str(M_data(j,1)),'D',num2str(M_data(j,2)))];
                k=k+1;
            end
        end
        legend(leg_str2,'Location','southeast');
        xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
        xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
        xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
        xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
        saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'_left_frontal_lobe','.png'));
        hold off
        figure
        hold on
        k=1;
        leg_str3=cell(0);
        for j=9:1:13
            if M_data(j,3)==1
                result_s=interp1(t,result_HbO(:,j),t_s,'spline');
                plot(t_s,result_s);
                set(gca,'FontName','STFangSong','FontSize',12,'LineWidth',1);
                xlabel('t/s');
                ylabel('\Delta HbO/mM·mm');
                title(strcat('实验者',temp_name(end-2:end-1),'在实验',temp_name(end),'的 \Delta HbO 变化','（左颞叶）'),'FontWeight','bold');
                leg_str3{k}=[strcat('S',num2str(M_data(j,1)),'D',num2str(M_data(j,2)))];
                k=k+1;
            end
        end
        legend(leg_str3,'Location','southeast');
        xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
        xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
        xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
        xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
        saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'_left_temporal_lobe','.png'));
        hold off
        figure
        hold on
        k=1;
        leg_str4=cell(0);
        for j=14:1:18
            if M_data(j,3)==1
                result_s=interp1(t,result_HbO(:,j),t_s,'spline');
                plot(t_s,result_s);
                set(gca,'FontName','STFangSong','FontSize',12,'LineWidth',1);
                xlabel('t/s');
                ylabel('\Delta HbO/mM·mm');
                title(strcat('实验者',temp_name(end-2:end-1),'在实验',temp_name(end),'的 \Delta HbO 变化','（右颞叶）'),'FontWeight','bold');
                leg_str4{k}=[strcat('S',num2str(M_data(j,1)),'D',num2str(M_data(j,2)))];
                k=k+1;
            end
        end
        legend(leg_str4,'Location','southeast');
        xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
        xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
        xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
        xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
        saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'_right_temporal_lobe','.png'));
        hold off
        figure
        set(gcf,'position',[250 300 1200 800]);
        subplot(2,2,2)
        hold on
        for j=1:1:4
            if M_data(j,3)==1
                result_s=interp1(t,result_HbO(:,j),t_s,'spline');
                plot(t_s,result_s);
                set(gca,'FontName','STFangSong','FontSize',14,'FontWeight','bold','LineWidth',1);
                xlabel('t/s');
                ylabel('\Delta HbO/mM·mm');
                title('右额叶','FontWeight','bold');
            end
        end
        legend(leg_str1,'Location','southeast');
        xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
        xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
        xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
        xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
        hold off
        subplot(2,2,1)
        hold on
        for j=5:1:8
            if M_data(j,3)==1
                result_s=interp1(t,result_HbO(:,j),t_s,'spline');
                plot(t_s,result_s);
                set(gca,'FontName','STFangSong','FontSize',14,'FontWeight','bold','LineWidth',1);
                xlabel('t/s');
                ylabel('\Delta HbO/mM·mm');
                title('左额叶','FontWeight','bold');
            end
        end
        legend(leg_str2,'Location','southeast');
        xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
        xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
        xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
        xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
        hold off
        subplot(2,2,3)
        hold on
        for j=9:1:13
            if M_data(j,3)==1
                result_s=interp1(t,result_HbO(:,j),t_s,'spline');
                plot(t_s,result_s);
                set(gca,'FontName','STFangSong','FontSize',14,'FontWeight','bold','LineWidth',1);
                xlabel('t/s');
                ylabel('\Delta HbO/mM·mm');
                title('左颞叶','FontWeight','bold');
            end
        end
        legend(leg_str3,'Location','southeast');
        xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
        xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
        xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
        xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
        hold off
        subplot(2,2,4)
        hold on
        for j=14:1:18
            if M_data(j,3)==1
                result_s=interp1(t,result_HbO(:,j),t_s,'spline');
                plot(t_s,result_s);
                set(gca,'FontName','STFangSong','FontSize',14,'FontWeight','bold','LineWidth',1);
                xlabel('t/s');
                ylabel('\Delta HbO/mM·mm');
                title('右颞叶','FontWeight','bold');
            end
        end
        legend(leg_str4,'Location','southeast');
        xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
        xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
        xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
        xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
        %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
        sgtitle(strcat('实验者',temp_name(end-2:end-1),'在实验',temp_name(end),'的 \Delta HbO 浓度变化'),'FontName','STFangSong','FontSize',22,'FontWeight','bold');
        saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'.png'));
        hold off
        result_HbO_str=zeros(size(t_s,2),size(find(M_data(:,3)==1),1));t_str=[];
        result_cnt=1;
        xtick_str=cell(1,size(result_HbO_str,2));
        for j=1:1:18
            if M_data(j,3)==1
                result_s=interp1(t,result_HbO(:,j),t_s,'spline');
                xtick_str{result_cnt}=[strcat('S',num2str(M_data(j,1)),'D',num2str(M_data(j,2)))];
                result_HbO_str(:,result_cnt)=result_s';
                result_cnt=result_cnt+1;
                t_str=[t_str,t_s'];
            end
        end
        figure
        set(gcf,'position',[250 300 1200 800]);
        hold on
        ribboncoloredZ(t_str,result_HbO_str);
        set(gca,'xtick',1:1:size(result_HbO_str,2));
        set(gca,'xticklabel',xtick_str);
        colormap(hot);
        clim([-1 1]);
        view(90,90); shading interp; c=colorbar;
        c.Location = 'eastoutside'; axis tight
        xlabel('pairs');ylabel('t/s');
        hold off
        saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'_strip.png'));
        disp('Done!');
    end
else
    [temp_path,temp_name,ext]=fileparts(R);
    disp('Loadind data ...');
    result_data=load(strcat(temp_path,'\derivatives\homer\',temp_name,'.mat'));
    result_HbO=result_data.output.dcAvg.GetDataTimeSeries('reshape');
    result_HbO=result_HbO(:,1,:);
    %result_HbO=result_data.output.dcAvg.dataTimeSeries(:,1:3:end);
    M_data=result_data.output.misc.mlActAuto{1,1};
    M_data=M_data(1:size(M_data,1)./2 ,:);
    [M_data,~]=sortrows(M_data,1);
    t=result_data.output.dcAvg.time;
    t=t';
    t_s=min(t):0.01:max(t);
    result_HbO=result_HbO.*1000;
    result_HbO(isnan(result_HbO))=0;
    set(0,'DefaultFigureVisible','off');
    figure
    set(gcf,'position',[250 300 600 400]);
    hold on
    k=1;
    leg_str1=cell(0);
    for j=1:1:4
        if M_data(j,3)==1
            result_s=interp1(t,result_HbO(:,j),t_s,'spline');
            plot(t_s,result_s);
            set(gca,'FontName','STFangSong','FontSize',12,'LineWidth',1);
            xlabel('t/s');
            ylabel('\Delta HbO/mM·mm');
            title(strcat('实验者',temp_name(end-2:end-1),'在实验',temp_name(end),'的 \Delta HbO 变化','（右额叶）'),'FontWeight','bold');
            leg_str1{k}=[strcat('S',num2str(M_data(j,1)),'D',num2str(M_data(j,2)))];
            k=k+1;
        end
    end
    legend(leg_str1,'Location','southeast');
    xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
    xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
    xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
    xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
    mkdir(temp_path,temp_name);
    saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'_right_frontal_lobe','.png'));
    hold off
    figure
    set(gcf,'position',[250 300 600 400]);
    hold on
    k=1;
    leg_str2=cell(0);
    for j=5:1:8
        if M_data(j,3)==1
            result_s=interp1(t,result_HbO(:,j),t_s,'spline');
            plot(t_s,result_s);
            set(gca,'FontName','STFangSong','FontSize',12,'LineWidth',1);
            xlabel('t/s');
            ylabel('\Delta HbO/mM·mm');
            title(strcat('实验者',temp_name(end-2:end-1),'在实验',temp_name(end),'的 \Delta HbO 变化','（左额叶）'),'FontWeight','bold');
            leg_str2{k}=[strcat('S',num2str(M_data(j,1)),'D',num2str(M_data(j,2)))];
            k=k+1;
        end
    end
    legend(leg_str2,'Location','southeast');
    xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
    xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
    xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
    xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
    saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'_left_frontal_lobe','.png'));
    hold off
    figure
    set(gcf,'position',[250 300 600 400]);
    hold on
    k=1;
    leg_str3=cell(0);
    for j=9:1:13
        if M_data(j,3)==1
            result_s=interp1(t,result_HbO(:,j),t_s,'spline');
            plot(t_s,result_s);
            set(gca,'FontName','STFangSong','FontSize',12,'LineWidth',1);
            xlabel('t/s');
            ylabel('\Delta HbO/mM·mm');
            title(strcat('实验者',temp_name(end-2:end-1),'在实验',temp_name(end),'的 \Delta HbO 变化','（左颞叶）'),'FontWeight','bold');
            leg_str3{k}=[strcat('S',num2str(M_data(j,1)),'D',num2str(M_data(j,2)))];
            k=k+1;
        end
    end
    legend(leg_str3,'Location','southeast');
    xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
    xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
    xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
    xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
    saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'_left_temporal_lobe','.png'));
    hold off
    figure
    set(gcf,'position',[250 300 600 400]);
    hold on
    k=1;
    leg_str4=cell(0);
    for j=14:1:18
        if M_data(j,3)==1
            result_s=interp1(t,result_HbO(:,j),t_s,'spline');
            plot(t_s,result_s);
            set(gca,'FontName','STFangSong','FontSize',12,'LineWidth',1);
            xlabel('t/s');
            ylabel('\Delta HbO/mM·mm');
            title(strcat('实验者',temp_name(end-2:end-1),'在实验',temp_name(end),'的 \Delta HbO 变化','（右颞叶）'),'FontWeight','bold');
            leg_str4{k}=[strcat('S',num2str(M_data(j,1)),'D',num2str(M_data(j,2)))];
            k=k+1;
        end
    end
    legend(leg_str4,'Location','southeast');
    xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
    xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
    xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
    xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
    saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'_right_temporal_lobe','.png'));
    hold off
    figure
    set(gcf,'position',[250 300 1200 800]);
    subplot(2,2,2)
    hold on
    for j=1:1:4
        if M_data(j,3)==1
            result_s=interp1(t,result_HbO(:,j),t_s,'spline');
            plot(t_s,result_s);
            set(gca,'FontName','STFangSong','FontSize',14,'FontWeight','bold','LineWidth',1);
            xlabel('t/s');
            ylabel('\Delta HbO/mM·mm');
            title('右额叶','FontWeight','bold');
        end
    end
    legend(leg_str1,'Location','southeast');
    xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
    xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
    xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
    xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
    hold off
    subplot(2,2,1)
    hold on
    for j=5:1:8
        if M_data(j,3)==1
            result_s=interp1(t,result_HbO(:,j),t_s,'spline');
            plot(t_s,result_s);
            set(gca,'FontName','STFangSong','FontSize',14,'FontWeight','bold','LineWidth',1);
            xlabel('t/s');
            ylabel('\Delta HbO/mM·mm');
            title('左额叶','FontWeight','bold');
        end
    end
    legend(leg_str2,'Location','southeast');
    xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
    xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
    xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
    xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
    hold off
    subplot(2,2,3)
    hold on
    for j=9:1:13
        if M_data(j,3)==1
            result_s=interp1(t,result_HbO(:,j),t_s,'spline');
            plot(t_s,result_s);
            set(gca,'FontName','STFangSong','FontSize',14,'FontWeight','bold','LineWidth',1);
            xlabel('t/s');
            ylabel('\Delta HbO/mM·mm');
            title('左颞叶','FontWeight','bold');
        end
    end
    legend(leg_str3,'Location','southeast');
    xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
    xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
    xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
    xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'));
    hold off
    subplot(2,2,4)
    hold on
    for j=14:1:18
        if M_data(j,3)==1
            result_s=interp1(t,result_HbO(:,j),t_s,'spline');
            plot(t_s,result_s);
            set(gca,'FontName','STFangSong','FontSize',14,'FontWeight','bold','LineWidth',1);
            xlabel('t/s');
            ylabel('\Delta HbO/mM·mm');
            title('右颞叶','FontWeight','bold');
        end
    end
    legend(leg_str4,'Location','southeast');
    xline(-9.9,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    xline(0,'--','Word 1','LabelOrientation','aligned','HandleVisibility','off');
    xline(20,'--','Word 2','LabelOrientation','aligned','HandleVisibility','off');
    xline(40,'--','Word 3','LabelOrientation','aligned','HandleVisibility','off');
    xline(60,'--','Counting','LabelOrientation','aligned','HandleVisibility','off');
    %writematrix(result_s,strcat(temp_path,'\derivatives\homer\',temp_name,'.csv'))
    sgtitle(strcat('实验者',temp_name(end-2:end-1),'在实验',temp_name(end),'的 \Delta HbO 浓度变化'),'FontName','STFangSong','FontSize',22,'FontWeight','bold');
    saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'.png'));
    hold off
    result_HbO_str=zeros(size(t_s,2),size(find(M_data(:,3)==1),1));t_str=[];
    result_cnt=1;
    xtick_str=cell(1,size(result_HbO_str,2));
    for j=1:1:18
        if M_data(j,3)==1
            result_s=interp1(t,result_HbO(:,j),t_s,'spline');
            xtick_str{result_cnt}=[strcat('S',num2str(M_data(j,1)),'D',num2str(M_data(j,2)))];
            result_HbO_str(:,result_cnt)=result_s';
            result_cnt=result_cnt+1;
            t_str=[t_str,t_s'];
        end
    end
    figure
    set(gcf,'position',[250 300 1200 800]);
    hold on
    ribboncoloredZ(t_str,result_HbO_str);
    set(gca,'xtick',1:1:size(result_HbO_str,2));
    set(gca,'xticklabel',xtick_str);
    colormap(hot);
    clim([-1 1]);
    view(90,90); shading interp; c=colorbar;
    c.Location = 'eastoutside'; axis tight
    xlabel('pairs');ylabel('t/s');
    hold off
    saveas(gcf,strcat(temp_path,'\',temp_name,'\',temp_name,'_strip.png'));
    disp('Done!');
end