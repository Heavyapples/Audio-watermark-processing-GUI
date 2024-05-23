function varargout = DSP_mark(varargin)
% DSP_MARK MATLAB code for DSP_mark.fig
%      DSP_MARK, by itself, creates a new DSP_MARK or raises the existing
%      singleton*.
%
%      H = DSP_MARK returns the handle to a new DSP_MARK or the handle to
%      the existing singleton*.
%
%      DSP_MARK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DSP_MARK.M with the given input arguments.
%
%      DSP_MARK('Property','Value',...) creates a new DSP_MARK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DSP_mark_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DSP_mark_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DSP_mark

% Last Modified by GUIDE v2.5 20-Apr-2023 21:46:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DSP_mark_OpeningFcn, ...
                   'gui_OutputFcn',  @DSP_mark_OutputFcn, ...
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


% --- Executes just before DSP_mark is made visible.

function DSP_mark_OpeningFcn(hObject,handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DSP_mark (see VARARGIN)

% Choose default command line output for DSP_mark
handles.output = hObject;

handles.axes1 = findobj(gcf, 'Tag', 'axes1');
handles.axes2 = findobj(gcf, 'Tag', 'axes2');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DSP_mark wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DSP_mark_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDA)
%--------------------------读取原始音频-------------------------%
cla reset;
FILE1='Rihanna - Take A Bow.wav';
[y,Fs]=audioread(FILE1);%音频信号y，采样率fs,采样精度bits
y_fft=fft(y,Fs);
% y_fft_f=2*sqrt(y_fft.*conj(y_fft));
axes(handles.axes1);
plot(y);
grid on;axis tight;
title('原始音频信号的时域波形');
xlabel('time(s)');ylabel('幅度');
axes(handles.axes2);
plot(abs(y_fft));
grid on;axis tight;
title('原始音频信号的频域波形');
xlabel('f(Hz)');ylabel('幅度');
player = audioplayer(y, Fs);
play(player);%播放原始语音

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------------------读取水印音频-------------------------%
cla reset;
FILE1='Rihanna - Take A Bow.wav';
[y,~]=audioread(FILE1);%音频信号y，采样率fs,采样精度bits
%用db4小波对原始音频信号进行3级小波分解
y = y(:); % 将矩阵转换为列向量
[c,l]=wavedec(y,3,'db4');%3级小波分解，低频部分为相似，高频部分为细节
%提取3级小波分解的低频系数和高频系数
ca3=appcoef(c,l,'db4',3);%提取三级小波分解的最低频分
%cd3=detcoef(c,l,3);%提取三级小波分解的次低频分
%cd2=detcoef(c,l,2);
%cd1=detcoef(c,l,1);
x=ca3;%提取三级小波分解的最低频部分
%找到插入位置，检测特征点
s=max(abs(x))*0.2;
i= abs(x)>s;
lx=length(x(i));
%读取水印音频
FILE2='test_new.wav';
[mark,Fs]=audioread(FILE2);
mark=mark(1:lx);
mark_fft=fft(mark);
% mark_fft_f=2*sqrt(mark_fft.*conj(mark_fft));
axes(handles.axes1);
plot(mark);
grid on;axis tight;
title('水印音频信号的时域波形');
xlabel('time(s)');ylabel('幅度');
axes(handles.axes2)
plot(abs(mark_fft));
grid on;axis tight;
title('水印音频信号的频域波形');
xlabel('f(Hz)');ylabel('幅度');
sound(mark,Fs);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------------------水印嵌入-------------------------%
cla reset;
FILE1='Rihanna - Take A Bow.wav';
[y,~]=audioread(FILE1);%音频信号y，采样率fs,采样精度bits
%用db4小波对原始音频信号进行3级小波分解
y = y(:); % 将矩阵转换为列向量
[c,l]=wavedec(y,3,'db4');%3级小波分解，低频部分为相似，高频部分为细节
%提取3级小波分解的低频系数和高频系数
ca3=appcoef(c,l,'db4',3);%提取三级小波分解的最低频分
cd3=detcoef(c,l,3);%提取三级小波分解的次低频分
cd2=detcoef(c,l,2);
cd1=detcoef(c,l,1);
x=ca3;%提取三级小波分解的最低频部分
%找到插入位置，检测特征点
s=max(abs(x))*0.2;
i=find(abs(x)>s);
lx=length(x(i));
%读取水印音频
FILE2='test_new.wav';
[mark,Fs]=audioread(FILE2);
mark=mark(1:lx);
%水印信号嵌入
ss=mark(1:lx);
rr=ss*0.02;
x(i)=x(i).*(1+rr');
%小波重构，生成加入了水印信号的音频信号
c1=[x',cd3',cd2',cd1'];
s1=waverec(c1,l,'db4');
%把加入了水印的原始音频信号作为final1.wav保存
FILE3='final1.wav';
% 归一化音频数据
s1 = s1 / max(abs(s1));
audiowrite(FILE3,s1,Fs,'BitsPerSample',16,...
'Comment','This is my new audio file.');
[y1,Fs]=audioread(FILE3);
y1_fft=fft(y1,Fs);
% y1_fft_f=2*sqrt(y1_fft.*conj(y1_fft));
axes(handles.axes1);
plot(y1);
grid on;axis tight;
title('嵌入水印后的原始音频信号的时域波形');
xlabel('time(s)');ylabel('幅度');
axes(handles.axes2);
plot(abs(y1_fft));
grid on;axis tight;
title('嵌入水印后的原始音频信号的频域波形');
xlabel('f(Hz)');ylabel('幅度');
ly1=length(y1);
y1=y1(1:0.5*ly1);
sound(y1,Fs);

% --- Executes on button press in pushbutton4.
matlab
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------------------水印提取-------------------------%
cla reset;
FILE1='Rihanna - Take A Bow.wav';
[y,~]=audioread(FILE1);%音频信号y，采样率fs,采样精度bits
%用db4小波对原始音频信号进行3级小波分解
y = y(:); % 将矩阵转换为列向量
[c,l]=wavedec(y,3,'db4');%3级小波分解，低频部分为相似，高频部分为细节
%提取3级小波分解的低频系数和高频系数
ca3=appcoef(c,l,'db4',3);%提取三级小波分解的最低频分
%cd3=detcoef(c,l,3);%提取三级小波分解的次低频分
%cd2=detcoef(c,l,2);
%cd1=detcoef(c,l,1);
x=ca3;%提取三级小波分解的最低频部分
%找到插入位置，检测特征点
s=max(abs(x))*0.2;
i=find(abs(x)>s);
%lx=length(i);
%读取含有水印的原始音频
FILE3='final1.wav';
[y1,Fs]=audioread(FILE3);
%用db4小波对含有水印的原始音频信号进行3级小波分解
[c1,l1]=wavedec(y1,3,'db4');
%提取3级小波分解的低频系数和高频系数
ca31=appcoef(c1,l1,'db4',3);
%cd31=detcoef(c1,l1,3);
%cd21=detcoef(c1,l1,2);
%cd11=detcoef(c1,l1,1);
x1=ca31;
%水印信号提取
z(i)=x1(i)-x(i);
s2=z(i)./x(i)';
s2=s2/0.02;
%把提取的水印信号作为final2.wav保存
FILE4='final2.wav';
% 归一化音频数据
s2 = s2 / max(abs(s2));
audiowrite(FILE4,s2,Fs,'BitsPerSample',16,...
'Comment','This is my new audio file.');
[mark1,Fs]=audioread(FILE4);
mark1_fft=fft(mark1);
% mark1_fft_f=2*sqrt(mark1_fft.*conj(mark1_fft));
axes(handles.axes1)
plot(mark1);
grid on;axis tight;
title('提取出的水印音频信号的时域波形');
xlabel('time（s）');ylabel('幅度');
axes(handles.axes2);
plot(abs(mark1_fft));
grid on;axis tight;
title('提取出的水印音频信号的频域波形');
xlabel('f（Hz）');ylabel('幅度');
sound(mark1,Fs);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------------------低通滤波-------------------------%
%读取含有水印的原始音频
FILE3='final1.wav';
[y1,Fs]=audioread(FILE3);
% wc=[0.3,0.8];
% [b,a]=butter(5,wc);
[b,a]=butter(5,0.1);
s3=filtfilt(b,a,y1);
%把经过滤波后的含有水印的原始音频信号作为final3.wav保存
FILE5='final3.wav';
% 归一化音频数据
s3 = s3 / max(abs(s3));
audiowrite(FILE5,s3,Fs,'BitsPerSample',16,...
'Comment','This is my new audio file.');
[y_filter,Fs]=audioread(FILE5);
y_filter_fft=fft(y_filter);
% y_filter_fft_f=2*sqrt(y_filter_fft.*conj(y_filter_fft));
axes(handles.axes1);
plot(y_filter);
grid on;axis tight;
title('经过滤波后的含有水印的原始音频信号的时域波形');
xlabel('time(s)');ylabel('幅度');
axes(handles.axes2);
plot(abs(y_filter_fft));
grid on;axis tight;
title('经过滤波后的含有水印的原始音频信号的频域波形');
xlabel('f(Hz)');ylabel('幅度');
ly2=length(y_filter);
y_filter=y_filter(1:0.5*ly2);
sound(y_filter,Fs);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------------------低通滤波后提取水印-------------------------%
cla reset;
FILE1='Rihanna - Take A Bow.wav';
[y,~]=audioread(FILE1);%音频信号y，采样率fs,采样精度bits
%用db4小波对原始音频信号进行3级小波分解
y = y(:); % 将矩阵转换为列向量
[c,l]=wavedec(y,3,'db4');%3级小波分解，低频部分为相似，高频部分为细节
%提取3级小波分解的低频系数和高频系数
ca3=appcoef(c,l,'db4',3);%提取三级小波分解的最低频分
%cd3=detcoef(c,l,3);%提取三级小波分解的次低频分
%cd2=detcoef(c,l,2);
%cd1=detcoef(c,l,1);
x=ca3;%提取三级小波分解的最低频部分
%找到插入位置，检测特征点
s=max(abs(x))*0.2;
i=find(abs(x)>s);
%lx=length(i);
%读取经过滤波后的含有水印的原始音频
FILE5='final3.wav';
[y_filter,Fs]=audioread(FILE5);
%用db4小波对经过滤波后的含有水印的原始音频信号进行3级小波分解
[c2,l1]=wavedec(y_filter,3,'db4');
%提取3级小波分解的低频系数和高频系数
ca32=appcoef(c2,l1,'db4',3);
%cd32=detcoef(c2,l1,3);
%cd22=detcoef(c2,l1,2);
%cd12=detcoef(c2,l1,1);
x2=ca32;
%水印信号提取
z(i)=x2(i)-x(i);
s3=z(i)./x(i)';
s3=s3/0.02;
%把提取的水印信号作为final4.wav保存
FILE6='final4.wav';
% 归一化音频数据
s3 = s3 / max(abs(s3));
audiowrite(FILE6,s3,Fs,'BitsPerSample',16,...
'Comment','This is my new audio file.');
[mark_filter,Fs]=audioread(FILE6);
mark_filter_fft=fft(mark_filter);
% mark_filter_fft_f=2*sqrt(mark_filter_fft.*conj(mark_filter_fft));
axes(handles.axes1);
plot(mark_filter);
grid on;axis tight;
title('经过滤波器处理后提取的水印音频信号的时域波形');
xlabel('time(s)');ylabel('幅度');
axes(handles.axes2);
plot(abs(mark_filter_fft));
grid on;axis tight;
title('经过滤波器处理后提取的水印音频信号的频域波形');
xlabel('f(Hz)');ylabel('幅度');
sound(mark_filter,Fs);


%fined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.


% --- Executes on button press in playButton.
