clear all
close all
clc
disp('Open the raw data file (.csv)...');%读入原始数据文件
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
disp('Open the position file (.pos)...');%读入位置文件
[PosF,PosP]=uigetfile('*.pos','Pick a .pos file','MultiSelect', 'off','C:\Users');
if isequal(PosF,0)
    error('Empty position file!');
else
    P=fullfile(PosP,PosF);
    disp('Your position file is:')
    disp(P);
end
% disp("Downloading MNE dataset...");
% py.mne.datasets.fnirs_motor.data_path()%下载MNE数据集
% py.mne.datasets.sample.data_path()%下载MNE数据集
% if iscell(R)
%     [temp_path,temp_name,ext]=fileparts(R{1});
% else
%     [temp_path,temp_name,ext]=fileparts(R);
% end
% raw = py.mne.io.read_raw_snirf(strcat(temp_path,'\',temp_name,'.snirf'),optode_frame='head');%绘制探测器空间位置图像
% raw.load_data()
% subjects_dir = py.mne.datasets.sample.data_path() / 'subjects';
% brain = py.mne.viz.Brain('fsaverage', subjects_dir=subjects_dir, background='w', cortex='0.5');
% brain.add_sensors(raw.info, trans='fsaverage',fnirs=py.list({'channels', 'pairs', 'sources', 'detectors'}));
% brain.show_view(azimuth=20, elevation=60, distance=400);
P_data=importdata(P);
disp('Loading position data...');
disp('Genrating middle points...');
middle_p=zeros(18,3);
mid_cnt=1;
for i=[2 3 9 10]
    middle_p(mid_cnt,:)=(P_data(i,1:3)+P_data(13,1:3))./2;
    mid_cnt=mid_cnt+1;
end
for i=[3 4 8 9]
    middle_p(mid_cnt,:)=(P_data(i,1:3)+P_data(14,1:3))./2;
    mid_cnt=mid_cnt+1;
end
for i=[4 5 6 7 8]
    middle_p(mid_cnt,:)=(P_data(i,1:3)+P_data(15,1:3))./2;
    mid_cnt=mid_cnt+1;
end
for i=[1 2 10 11 12]
    middle_p(mid_cnt,:)=(P_data(i,1:3)+P_data(16,1:3))./2;
    mid_cnt=mid_cnt+1;
end
[x,y]=meshgrid(min(P_data(:,1))-5:0.1:max(P_data(:,1))+5,min(P_data(:,3))-5:0.1:max(P_data(:,3))+5);%生成空间位置网格
[in,~] = inpolygon(x,y,P_data(1:12,1),P_data(1:12,3));
if iscell(R)%对多个任务的处理
    for i=1:1:size(R,2)
        [temp_path,temp_name,ext]=fileparts(R{i});%读取Homer3输出文件
        disp(['Loadind data for No.',num2str(i),'...']);
        result_data=load(strcat(temp_path,'\derivatives\homer\',temp_name,'.mat'));
        temp_HbO=result_data.output.dcAvg.GetDataTimeSeries('reshape');
        result_HbO=squeeze(temp_HbO(:,1,:));
        M_data=result_data.output.misc.mlActAuto{1,1};
        M_data=M_data(1:size(M_data,1)./2 ,:);
        [M_data,~]=sortrows(M_data,1);
        t=result_data.output.dcAvg.time;
        t=t';
        result_HbO=result_HbO.*1000;
        result_HbO(isnan(result_HbO))=0;
        im=cell(size(result_HbO,1),1);
        Act_Channel=find(M_data(:,3)==1);
        for j=1:10:size(result_HbO,1)%绘制大脑HbO浓度动态变化图像
            disp(['Processing at No.',num2str(j),'...']);
            F=scatteredInterpolant(middle_p(Act_Channel,1),middle_p(Act_Channel,3),result_HbO(j,Act_Channel)');
            val_Int=F(x,y);
            val_Int(~in)=0;
            junk=max(val_Int,[],"all")+5;
            set(0,'DefaultFigureVisible','off');
            fig=figure(j);
            hold on
            scatter3(P_data(1:12,1),P_data(1:12,3),junk,100,'MarkerFaceColor',"#4D2828",'MarkerEdgeColor','k','LineWidth',1.5);
            scatter3(P_data(13:16,1),P_data(13:16,3),junk,100,'MarkerFaceColor',"#FF3E33",'MarkerEdgeColor','k','LineWidth',1.5);
            scatter3(middle_p(:,1),middle_p(:,3),junk,50,'MarkerFaceColor',"#FFBC32",'MarkerEdgeColor','k','LineWidth',1.5);
            plot3([P_data(1:12,1);P_data(1,1)],[P_data(1:12,3);P_data(1,3)],ones(13,1).*(junk-2),'-k',LineWidth=1.5);
            for k=[2 3 9 10]
                plot3([P_data(13,1);P_data(k,1)],[P_data(13,3);P_data(k,3)],ones(2,1).*(junk-2),'--k',LineWidth=1);
            end
            for k=[3 4 8 9]
                plot3([P_data(14,1);P_data(k,1)],[P_data(14,3);P_data(k,3)],ones(2,1).*(junk-2),'--k',LineWidth=1);
            end
            for k=[4 5 6 7 8]
                plot3([P_data(15,1);P_data(k,1)],[P_data(15,3);P_data(k,3)],ones(2,1).*(junk-2),'--k',LineWidth=1);
            end
            for k=[1 2 10 11 12]
                plot3([P_data(16,1);P_data(k,1)],[P_data(16,3);P_data(k,3)],ones(2,1).*(junk-2),'--k',LineWidth=1);
            end
            surf(squeeze(x),squeeze(y),squeeze(val_Int));
            colormap(othercolor('BuDRd_18'));
            clim([-1.5 1.5]);
            view(0,90);
            shading interp; c=colorbar;
            c.Location = 'southoutside'; axis tight
            xlabel('x/mm'); ylabel('y/mm');
            title(strcat('t=',num2str(t(j)),'s'));
            hold off
            frame = getframe(fig);
            im{j}=frame2im(frame);
            close;
        end
        mkdir(temp_path,temp_name);
        filename = strcat(temp_path,'\',temp_name,'\',temp_name,'.gif');
        for j = 1:10:size(result_HbO,1)
            [A,map] = rgb2ind(im{j},256);
            if j == 1
                imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
            else
                imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);
            end
        end
        disp('Done!');
    end
else%对单个任务的处理
    [temp_path,temp_name,ext]=fileparts(R);%读取Homer3输出文件
    disp(['Loadind data...']);
    result_data=load(strcat(temp_path,'\derivatives\homer\',temp_name,'.mat'));
    temp_HbO=result_data.output.dcAvg.GetDataTimeSeries('reshape');
    result_HbO=squeeze(temp_HbO(:,1,:));
    %result_HbO=result_data.output.dcAvg.dataTimeSeries(:,1:3:end);
    M_data=result_data.output.misc.mlActAuto{1,1};
    M_data=M_data(1:size(M_data,1)./2 ,:);
    [M_data,~]=sortrows(M_data,1);
    t=result_data.output.dcAvg.time;
    t=t';
    t_s=min(t):0.01:max(t);
    result_HbO=result_HbO.*1000;
    result_HbO(isnan(result_HbO))=0;
    im=cell(size(result_HbO,1),1);
    Act_Channel=find(M_data(:,3)==1);
    for j=1:10:size(result_HbO,1)%绘制大脑HbO浓度动态变化图像
        F=scatteredInterpolant(middle_p(Act_Channel,1),middle_p(Act_Channel,3),result_HbO(j,Act_Channel)');
        disp(['Processing at No.',num2str(j),'...']);
        val_Int=F(x,y);
        %val_Int(~in)=min(val_Int,[],'all')-2;
        val_Int(~in)=0;
        junk=max(val_Int,[],"all")+5;
        set(0,'DefaultFigureVisible','off');
        fig=figure(j);
        hold on
        scatter3(P_data(1:12,1),P_data(1:12,3),junk,100,'MarkerFaceColor',"#4D2828",'MarkerEdgeColor','k','LineWidth',1.5);
        scatter3(P_data(13:16,1),P_data(13:16,3),junk,100,'MarkerFaceColor',"#FF3E33",'MarkerEdgeColor','k','LineWidth',1.5);
        scatter3(middle_p(:,1),middle_p(:,3),junk,50,'MarkerFaceColor',"#FFBC32",'MarkerEdgeColor','k','LineWidth',1.5);
        plot3([P_data(1:12,1);P_data(1,1)],[P_data(1:12,3);P_data(1,3)],ones(13,1).*(junk-2),'-k',LineWidth=1.5);
        for k=[2 3 9 10]
            plot3([P_data(13,1);P_data(k,1)],[P_data(13,3);P_data(k,3)],ones(2,1).*(junk-2),'--k',LineWidth=1);
        end
        for k=[3 4 8 9]
            plot3([P_data(14,1);P_data(k,1)],[P_data(14,3);P_data(k,3)],ones(2,1).*(junk-2),'--k',LineWidth=1);
        end
        for k=[4 5 6 7 8]
            plot3([P_data(15,1);P_data(k,1)],[P_data(15,3);P_data(k,3)],ones(2,1).*(junk-2),'--k',LineWidth=1);
        end
        for k=[1 2 10 11 12]
            plot3([P_data(16,1);P_data(k,1)],[P_data(16,3);P_data(k,3)],ones(2,1).*(junk-2),'--k',LineWidth=1);
        end
        surf(squeeze(x),squeeze(y),squeeze(val_Int));
        colormap(othercolor('BuDRd_18'));
        clim([-1.5 1.5]);
        view(0,90); shading interp; c=colorbar;
        c.Location = 'southoutside'; axis tight
        xlabel('x/mm'); ylabel('y/mm');
        title(strcat('t=',num2str(t(j)),'s'));
        hold off
        frame = getframe(fig);
        im{j}=frame2im(frame);
        close;
    end
    mkdir(temp_path,temp_name);
    filename = strcat(temp_path,'\',temp_name,'\',temp_name,'.gif');
    for j = 1:10:size(result_HbO,1)
        [A,map] = rgb2ind(im{j},256);
        if j == 1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
        else
            imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);
        end
    end
    disp('Done!');
end
clear all