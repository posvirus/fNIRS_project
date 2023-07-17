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
disp('Choose the brain node file (.node)...');%读入大脑结点文件
[NodeF,NodeP]=uigetfile('*.node','Pick a .node file','MultiSelect', 'off','C:\Users');
if isequal(NodeF,0)
    error('Empty node file!');
else
    N=fullfile(NodeP,NodeF);
    disp('Your node file is:')
    disp(N);
end
disp('Choose the brain model file (.nv)...');%读入大脑模型文件
[ModF,ModP]=uigetfile('*.nv','Pick a .nv file','MultiSelect', 'off','C:\Users');
if isequal(ModF,0)
    error('Empty model file!');
else
    B=fullfile(ModP,ModF);
    disp('Your brain model is:')
    disp(B);
end
disp('Choose the option file (.mat)...');%读入设置文件
[OpF,OpP]=uigetfile('*.mat','Pick a .mat file','MultiSelect', 'off','C:\Users');
if isequal(OpF,0)
    error('Empty option file!');
else
    O=fullfile(OpP,OpF);
    disp('Your option file is:')
    disp(O);
end
%处理大脑结点文件
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
clear mid_cnt
disp('Genrating new node file...');
[XCor,YCor,ZCor,Size,~,Label]=textread(N,'%f %f %f %f %f %s');
XCor=XCor(find(Size==1));
YCor=YCor(find(Size==1));
ZCor=ZCor(find(Size==1));
Size=Size(find(Size==1));
Label=Label(find(Size==1));
Cor_Matrix=[XCor,YCor,ZCor];
Saved_Node=cell(1,4);
for j=1:1:size(middle_p,1)
    dist_vec=[];
    for i=1:1:size(Cor_Matrix,1)
        dist_vec=[dist_vec, norm(Cor_Matrix(i,:)-middle_p(j,:))];
    end
    [~,temp]=min(dist_vec);
    Saved_Node{j,1}=Cor_Matrix(temp,:);
    Saved_Node{j,2}=Size(temp,:);
    Saved_Node{j,3}=1;
    Saved_Node{j,4}=Label{temp};
    Cor_Matrix(temp,:)=[];%清除已被选择的结点，防止重复选择
    Size(temp,:)=[];
    Label(temp,:)=[];
end
clear temp dist_vec 
writecell(Saved_Node,strcat(PosP,'N4000_',NodeF(1:end-4),'txt'),"Delimiter",' ');
movefile(strcat(PosP,'N4000_',NodeF(1:end-4),'txt'),strcat(PosP,'N4000_',NodeF(1:end-4),'node'));
if iscell(R)%对多个任务的处理
    for i=1:1:size(R,2)
        [temp_path,temp_name,ext]=fileparts(R{i});%读取Homer3输出文件
        disp(['Loadind data for No.',num2str(i),'...']);
        result_data=load(strcat(temp_path,'\derivatives\homer\',temp_name,'.mat'));
        temp_HbO=result_data.output.dcAvg.GetDataTimeSeries('reshape');
        result_HbO=squeeze(temp_HbO(:,1,:));
        %result_HbO=result_data.output.dcAvg.dataTimeSeries(:,1:3:end);
        M_data=result_data.output.misc.mlActAuto{1,1};
        M_data=M_data(1:size(M_data,1)./2 ,:);
        [M_data,~]=sortrows(M_data,1);
        Rho_of_edge=corr(result_HbO);
        Rho_of_edge(isnan(Rho_of_edge))=0;
        writematrix(Rho_of_edge,strcat(temp_path,'\N4000_',temp_name,'.txt'),"Delimiter",' ');
        movefile(strcat(temp_path,'\N4000_',temp_name,'.txt'),strcat(temp_path,'\N4000_',temp_name,'.edge'));
        set(0,'DefaultFigureVisible','off');
        mkdir(temp_path,temp_name);
        BrainNet_MapCfg(B,strcat(PosP,'N4000_',NodeF(1:end-4),'node'),strcat(temp_path,'\N4000_',temp_name,'.edge'),O,strcat(temp_path,'\',temp_name,'\',temp_name,'_brain_net.png'));
        close all
    end
    disp('Done!');
else
    [temp_path,temp_name,ext]=fileparts(R);%读取Homer3输出文件
    disp('Loadind data...');
    result_data=load(strcat(temp_path,'\derivatives\homer\',temp_name,'.mat'));
    temp_HbO=result_data.output.dcAvg.GetDataTimeSeries('reshape');
    result_HbO=squeeze(temp_HbO(:,1,:));
    %result_HbO=result_data.output.dcAvg.dataTimeSeries(:,1:3:end);
    M_data=result_data.output.misc.mlActAuto{1,1};
    M_data=M_data(1:size(M_data,1)./2 ,:);
    [M_data,~]=sortrows(M_data,1);
    Rho_of_edge=corr(result_HbO);
    Rho_of_edge(isnan(Rho_of_edge))=0;
    writematrix(Rho_of_edge,strcat(temp_path,'\N4000_',temp_name,'.txt'),"Delimiter",' ');
    movefile(strcat(temp_path,'\N4000_',temp_name,'.txt'),strcat(temp_path,'\N4000_',temp_name,'.edge'));
    set(0,'DefaultFigureVisible','off');
    mkdir(temp_path,temp_name);
    BrainNet_MapCfg(B,strcat(PosP,'N4000_',NodeF(1:end-4),'node'),strcat(temp_path,'\N4000_',temp_name,'.edge'),O,strcat(temp_path,'\',temp_name,'\',temp_name,'_brain_net.png'));
    close all
    disp('Done!');
end
clear all
