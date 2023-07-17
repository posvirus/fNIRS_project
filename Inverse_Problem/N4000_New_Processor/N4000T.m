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
disp('Open the position file (.csv)...');
[PosF,PosP]=uigetfile('*.pos','Pick a .pos file','MultiSelect', 'off','C:\Users');
if isequal(PosF,0)
    error('Empty position file!');
else
    P=fullfile(PosP,PosF);
    disp('Your position file is:')
    disp(P);
end
disp('Open the measurelist file (.csv)...');
[MlistF,MlistP]=uigetfile('*.mlist','Pick a .mlist file','MultiSelect', 'off','C:\Users');
if isequal(MlistF,0)
    error('Empty measurelist file!');
else
    M=fullfile(MlistP,MlistF);
    disp('Your measurelist file is:')
    disp(M);
end
disp('Start converting...');
event=cell(2,1);
event{1}='Onset	Duration	Amplitude	trial_type';
event{2}=[35 60 1 1];
if iscell(R)
    for i=1:1:size(R,2)
        R_data=csvread(R{i},18,0);%读入csv文件
        disp(['Loading raw data for No.',num2str(i),'...']);
        t=(R_data(:,1)-1)./10;%t is required in the .nirs file
        R_data=(R_data(:,2:end).*2.5)./(32768-1)+2.5;
        %temp_aux=R_data(:,end);
        %R_data=R_data(:,1:end-1);
        %R_data=abs(R_data(:,2:2:end))./10000;%分离原始矩阵数据，仅保留PD测量数据
        %len_of_aux=length(unique(temp_aux))-1;%生成标记矩阵aux
        %aux=zeros(size(R_data,1),len_of_aux);
        %for i=1:1:len_of_aux
        %   [aux_row,junk]=find(temp_aux==i);
        %    for j=1:1:length(aux_row)
        %        aux(aux_row(j),i)=1;
        %    end
        %end
        %disp(aux);
        s=zeros(size(R_data,1),1);
        aux=s;
        %Read the position data
        P_data=importdata(P);
        disp(['Loading position data for No.',num2str(i),'...']);
        SD.nSrcs=sum(P_data(:,end)==2);%计算光源个数
        SD.nDets=sum(P_data(:,end)==1);%计算探测器个数
        P_data(:,end)=[];
        SD.DetPos=P_data(1:SD.nDets,:);%存储光源位置
        SD.SrcPos=P_data(SD.nDets+1:end,:);%存储探测器位置
        
        %Read the measure link data
        M_data=importdata(M);
        disp(['Loading measure link data for No.',num2str(i),'...']);
        [M_data,I]=sortrows(M_data,4);
        R_data=R_data(:,I);
        %writematrix(R_data,'R.csv');
        offset = [9.82612777337252e-09,9.92409121472797e-09,1.00221628444732e-08,1.00134680172500e-08,1.00663821185775e-08,1.00773679071181e-08,1.00406448177855e-08,1.00251679066948e-08,1.00588199514854e-08,1.00019985600491e-08,1.00857675894307e-08,0];
        for k=1:1:size(M_data,1)
            R_data(:,k)=R_data(:,k)-offset(M_data(k,2))*50e6;
        end
        d=R_data;
        SD.MeasList=M_data(:,1:4);
        ml=SD.MeasList;
        SD.Lambda=unique(M_data(:,5),'stable');
        %disp(SD);
        disp('I have all the information I need... Saving...');
        save(strcat(R{i}(1:length(R{i})-3),'nirs'),'t', 'd', 'SD', 's', 'ml', 'aux');
        writeTsv(strcat(R{i}(1:length(R{i})-4),'_events.tsv'),event);
    end
else
    R_data=csvread(R,18,0);%读入csv文件
    disp('Loading raw data ...');
    t=(R_data(:,1)-1)./10;%t is required in the .nirs file
    R_data=(R_data(:,2:end).*2.5)./(32768-1)+2.5;
    %writematrix(R_data,'R.csv');
    %temp_aux=R_data(:,end);
    %R_data=R_data(:,1:end-1);
    %R_data=abs(R_data(:,2:2:end))./10000;%分离原始矩阵数据，仅保留PD测量数据
    %len_of_aux=length(unique(temp_aux))-1;%生成标记矩阵aux
    %aux=zeros(size(R_data,1),len_of_aux);
    %for i=1:1:len_of_aux
    %   [aux_row,junk]=find(temp_aux==i);
    %    for j=1:1:length(aux_row)
    %        aux(aux_row(j),i)=1;
    %    end
    %end
    %disp(aux);
    s=zeros(size(R_data,1),1);
    aux=s;
    %Read the position data
    P_data=importdata(P);
    disp('Loading position data...');
    SD.nSrcs=sum(P_data(:,end)==2);%计算光源个数
    SD.nDets=sum(P_data(:,end)==1);%计算探测器个数
    P_data(:,end)=[];
    SD.DetPos=P_data(1:SD.nDets,:);%存储光源位置
    SD.SrcPos=P_data(SD.nDets+1:end,:);%存储探测器位置
    
    %Read the measure link data
    M_data=importdata(M);
    disp('Loading measure link data...');
    [M_data,I]=sortrows(M_data,4);
    R_data=R_data(:,I);
    %writematrix(R_data,'R.csv');
    offset = [9.82612777337252e-09,9.92409121472797e-09,1.00221628444732e-08,1.00134680172500e-08,1.00663821185775e-08,1.00773679071181e-08,1.00406448177855e-08,1.00251679066948e-08,1.00588199514854e-08,1.00019985600491e-08,1.00857675894307e-08,0];
    for k=1:1:size(M_data,1)
       R_data(:,k)=R_data(:,k)-offset(M_data(k,2))*50e6; 
    end
    d=R_data;
    %writematrix(R_data,'d.csv');
    SD.MeasList=M_data(:,1:4);
    ml=SD.MeasList;
    SD.Lambda=unique(M_data(:,5),'stable');
    %disp(SD);
    disp('I have all the information I need... Saving...');
    save(strcat(R(1:length(R)-3),'nirs'),'t', 'd', 'SD', 's', 'ml', 'aux')
    writeTsv(strcat(R(1:length(R)-4),'_events.tsv'),event);
end
disp('Done!');