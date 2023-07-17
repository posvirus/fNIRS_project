function varargout = N4000_2_Homer(varargin)
% N4000_2_HOMER MATLAB code for N4000_2_Homer.fig
%      N4000_2_HOMER, by itself, creates a new N4000_2_HOMER or raises the existing
%      singleton*.
%
%      H = N4000_2_HOMER returns the handle to a new N4000_2_HOMER or the handle to
%      the existing singleton*.
%
%      N4000_2_HOMER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in N4000_2_HOMER.M with the given input arguments.
%
%      N4000_2_HOMER('Property','Value',...) creates a new N4000_2_HOMER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before N4000_2_Homer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to N4000_2_Homer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help N4000_2_Homer

% Last Modified by GUIDE v2.5 17-Feb-2023 10:37:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @N4000_2_Homer_OpeningFcn, ...
                   'gui_OutputFcn',  @N4000_2_Homer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before N4000_2_Homer is made visible.
function N4000_2_Homer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to N4000_2_Homer (see VARARGIN)

% Choose default command line output for N4000_2_Homer
handles.output = hObject;
set(handles.text2,'String',[]);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes N4000_2_Homer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = N4000_2_Homer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RawData_filename;
RawData_filename=get(hObject,'String');
handles.R=RawData_filename;
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Pos_filename;
Pos_filename=get(hObject,'String');
handles.P=Pos_filename;
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Mlist_filename;
Mlist_filename=get(hObject,'String');
handles.M=Mlist_filename;
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global RawData_filename;
[RawDataF,RawDataP]=uigetfile('*.csv','Pick the raw data','MultiSelect', 'off','C:\Users');
if isequal(RawDataF,0)
    set(handles.edit1,'String',[]);
else
    RawData_filename=fullfile(RawDataP,RawDataF);
    set(handles.edit1,'String',RawData_filename);
    handles.R=RawData_filename;
    guidata(hObject, handles);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Pos_filename;
[PosF,PosP]=uigetfile('*.pos','Pick a .pos file','MultiSelect', 'off','C:\Users');
if isequal(PosF,0)
    set(handles.edit2,'String',[]);
else
    Pos_filename=fullfile(PosP,PosF);
    set(handles.edit2,'String',Pos_filename);
    handles.P=Pos_filename;
    guidata(hObject, handles);
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Mlist_filename;
[MlistF,MlistP]=uigetfile('*.mlist','Pick a .mlist file','MultiSelect', 'off','C:\Users');
if isequal(MlistF,0)
    set(handles.edit3,'String',[]);
else
    Mlist_filename=fullfile(MlistP,MlistF);
    set(handles.edit3,'String',Mlist_filename);
    handles.M=Mlist_filename;
    guidata(hObject, handles);
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Read the raw data
R=handles.R; P=handles.P; M=handles.M;
disp('Start converting...');
set(handles.text2,'String','Start converting...','ForegroundColor','#EDB120');
temp_struct=importdata(R);%读入csv文件
disp('Loading raw data...');
set(handles.text2,'String','Loading raw data...','ForegroundColor','#EDB120');
R_data=temp_struct.data;%去除数据头
t=R_data(:,1);%t is required in the .nirs file
temp_aux=R_data(:,end);
R_data=R_data(:,1:end-1);
R_data=abs(R_data(:,2:2:end))./10000;%分离原始矩阵数据，仅保留PD测量数据
len_of_aux=length(unique(temp_aux))-1;%生成标记矩阵aux
aux=zeros(size(R_data,1),len_of_aux);
for i=1:1:len_of_aux
   [aux_row,junk]=find(temp_aux==i);
   for j=1:1:length(aux_row)
      aux(aux_row(j),i)=1; 
   end
end
%disp(aux);
s=zeros(size(R_data,1),1);

%Read the position data
P_data=importdata(P);
disp('Loading position data...');
set(handles.text2,'String','Loading position data...','ForegroundColor','#EDB120');
SD.nSrcs=sum(P_data(:,end)==2);%计算光源个数
SD.nDets=sum(P_data(:,end)==1);%计算探测器个数
P_data(:,end)=[];
SD.DetPos=P_data(1:SD.nDets,:);%存储光源位置
SD.SrcPos=P_data(SD.nDets+1:end,:);%存储探测器位置

%Read the measure link data
M_data=importdata(M);
disp('Loading measure link data...');
set(handles.text2,'String','Loading measure link data...','ForegroundColor','#EDB120');
[M_data,I]=sortrows(M_data,4);
d=R_data(:,I);
SD.MeasList=M_data(:,1:4);
ml=SD.MeasList;
SD.Lambda=unique(M_data(:,5),'stable');
%disp(SD);
disp('I have all the information I need... Saving...');
set(handles.text2,'String','I have all the information I need... Saving...','ForegroundColor','#EDB120');

save(strcat(R(1:length(R)-3),'nirs'),'t', 'd', 'SD', 's', 'ml', 'aux');
disp('Done!');
set(handles.text2,'String','Done!','ForegroundColor','green');


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
