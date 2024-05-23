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
%--------------------------��ȡԭʼ��Ƶ-------------------------%
cla reset;
FILE1='Rihanna - Take A Bow.wav';
[y,Fs]=audioread(FILE1);%��Ƶ�ź�y��������fs,��������bits
y_fft=fft(y,Fs);
% y_fft_f=2*sqrt(y_fft.*conj(y_fft));
axes(handles.axes1);
plot(y);
grid on;axis tight;
title('ԭʼ��Ƶ�źŵ�ʱ����');
xlabel('time(s)');ylabel('����');
axes(handles.axes2);
plot(abs(y_fft));
grid on;axis tight;
title('ԭʼ��Ƶ�źŵ�Ƶ����');
xlabel('f(Hz)');ylabel('����');
player = audioplayer(y, Fs);
play(player);%����ԭʼ����

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------------------��ȡˮӡ��Ƶ-------------------------%
cla reset;
FILE1='Rihanna - Take A Bow.wav';
[y,~]=audioread(FILE1);%��Ƶ�ź�y��������fs,��������bits
%��db4С����ԭʼ��Ƶ�źŽ���3��С���ֽ�
y = y(:); % ������ת��Ϊ������
[c,l]=wavedec(y,3,'db4');%3��С���ֽ⣬��Ƶ����Ϊ���ƣ���Ƶ����Ϊϸ��
%��ȡ3��С���ֽ�ĵ�Ƶϵ���͸�Ƶϵ��
ca3=appcoef(c,l,'db4',3);%��ȡ����С���ֽ�����Ƶ��
%cd3=detcoef(c,l,3);%��ȡ����С���ֽ�Ĵε�Ƶ��
%cd2=detcoef(c,l,2);
%cd1=detcoef(c,l,1);
x=ca3;%��ȡ����С���ֽ�����Ƶ����
%�ҵ�����λ�ã����������
s=max(abs(x))*0.2;
i= abs(x)>s;
lx=length(x(i));
%��ȡˮӡ��Ƶ
FILE2='test_new.wav';
[mark,Fs]=audioread(FILE2);
mark=mark(1:lx);
mark_fft=fft(mark);
% mark_fft_f=2*sqrt(mark_fft.*conj(mark_fft));
axes(handles.axes1);
plot(mark);
grid on;axis tight;
title('ˮӡ��Ƶ�źŵ�ʱ����');
xlabel('time(s)');ylabel('����');
axes(handles.axes2)
plot(abs(mark_fft));
grid on;axis tight;
title('ˮӡ��Ƶ�źŵ�Ƶ����');
xlabel('f(Hz)');ylabel('����');
sound(mark,Fs);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------------------ˮӡǶ��-------------------------%
cla reset;
FILE1='Rihanna - Take A Bow.wav';
[y,~]=audioread(FILE1);%��Ƶ�ź�y��������fs,��������bits
%��db4С����ԭʼ��Ƶ�źŽ���3��С���ֽ�
y = y(:); % ������ת��Ϊ������
[c,l]=wavedec(y,3,'db4');%3��С���ֽ⣬��Ƶ����Ϊ���ƣ���Ƶ����Ϊϸ��
%��ȡ3��С���ֽ�ĵ�Ƶϵ���͸�Ƶϵ��
ca3=appcoef(c,l,'db4',3);%��ȡ����С���ֽ�����Ƶ��
cd3=detcoef(c,l,3);%��ȡ����С���ֽ�Ĵε�Ƶ��
cd2=detcoef(c,l,2);
cd1=detcoef(c,l,1);
x=ca3;%��ȡ����С���ֽ�����Ƶ����
%�ҵ�����λ�ã����������
s=max(abs(x))*0.2;
i=find(abs(x)>s);
lx=length(x(i));
%��ȡˮӡ��Ƶ
FILE2='test_new.wav';
[mark,Fs]=audioread(FILE2);
mark=mark(1:lx);
%ˮӡ�ź�Ƕ��
ss=mark(1:lx);
rr=ss*0.02;
x(i)=x(i).*(1+rr');
%С���ع������ɼ�����ˮӡ�źŵ���Ƶ�ź�
c1=[x',cd3',cd2',cd1'];
s1=waverec(c1,l,'db4');
%�Ѽ�����ˮӡ��ԭʼ��Ƶ�ź���Ϊfinal1.wav����
FILE3='final1.wav';
% ��һ����Ƶ����
s1 = s1 / max(abs(s1));
audiowrite(FILE3,s1,Fs,'BitsPerSample',16,...
'Comment','This is my new audio file.');
[y1,Fs]=audioread(FILE3);
y1_fft=fft(y1,Fs);
% y1_fft_f=2*sqrt(y1_fft.*conj(y1_fft));
axes(handles.axes1);
plot(y1);
grid on;axis tight;
title('Ƕ��ˮӡ���ԭʼ��Ƶ�źŵ�ʱ����');
xlabel('time(s)');ylabel('����');
axes(handles.axes2);
plot(abs(y1_fft));
grid on;axis tight;
title('Ƕ��ˮӡ���ԭʼ��Ƶ�źŵ�Ƶ����');
xlabel('f(Hz)');ylabel('����');
ly1=length(y1);
y1=y1(1:0.5*ly1);
sound(y1,Fs);

% --- Executes on button press in pushbutton4.
matlab
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------------------ˮӡ��ȡ-------------------------%
cla reset;
FILE1='Rihanna - Take A Bow.wav';
[y,~]=audioread(FILE1);%��Ƶ�ź�y��������fs,��������bits
%��db4С����ԭʼ��Ƶ�źŽ���3��С���ֽ�
y = y(:); % ������ת��Ϊ������
[c,l]=wavedec(y,3,'db4');%3��С���ֽ⣬��Ƶ����Ϊ���ƣ���Ƶ����Ϊϸ��
%��ȡ3��С���ֽ�ĵ�Ƶϵ���͸�Ƶϵ��
ca3=appcoef(c,l,'db4',3);%��ȡ����С���ֽ�����Ƶ��
%cd3=detcoef(c,l,3);%��ȡ����С���ֽ�Ĵε�Ƶ��
%cd2=detcoef(c,l,2);
%cd1=detcoef(c,l,1);
x=ca3;%��ȡ����С���ֽ�����Ƶ����
%�ҵ�����λ�ã����������
s=max(abs(x))*0.2;
i=find(abs(x)>s);
%lx=length(i);
%��ȡ����ˮӡ��ԭʼ��Ƶ
FILE3='final1.wav';
[y1,Fs]=audioread(FILE3);
%��db4С���Ժ���ˮӡ��ԭʼ��Ƶ�źŽ���3��С���ֽ�
[c1,l1]=wavedec(y1,3,'db4');
%��ȡ3��С���ֽ�ĵ�Ƶϵ���͸�Ƶϵ��
ca31=appcoef(c1,l1,'db4',3);
%cd31=detcoef(c1,l1,3);
%cd21=detcoef(c1,l1,2);
%cd11=detcoef(c1,l1,1);
x1=ca31;
%ˮӡ�ź���ȡ
z(i)=x1(i)-x(i);
s2=z(i)./x(i)';
s2=s2/0.02;
%����ȡ��ˮӡ�ź���Ϊfinal2.wav����
FILE4='final2.wav';
% ��һ����Ƶ����
s2 = s2 / max(abs(s2));
audiowrite(FILE4,s2,Fs,'BitsPerSample',16,...
'Comment','This is my new audio file.');
[mark1,Fs]=audioread(FILE4);
mark1_fft=fft(mark1);
% mark1_fft_f=2*sqrt(mark1_fft.*conj(mark1_fft));
axes(handles.axes1)
plot(mark1);
grid on;axis tight;
title('��ȡ����ˮӡ��Ƶ�źŵ�ʱ����');
xlabel('time��s��');ylabel('����');
axes(handles.axes2);
plot(abs(mark1_fft));
grid on;axis tight;
title('��ȡ����ˮӡ��Ƶ�źŵ�Ƶ����');
xlabel('f��Hz��');ylabel('����');
sound(mark1,Fs);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------------------��ͨ�˲�-------------------------%
%��ȡ����ˮӡ��ԭʼ��Ƶ
FILE3='final1.wav';
[y1,Fs]=audioread(FILE3);
% wc=[0.3,0.8];
% [b,a]=butter(5,wc);
[b,a]=butter(5,0.1);
s3=filtfilt(b,a,y1);
%�Ѿ����˲���ĺ���ˮӡ��ԭʼ��Ƶ�ź���Ϊfinal3.wav����
FILE5='final3.wav';
% ��һ����Ƶ����
s3 = s3 / max(abs(s3));
audiowrite(FILE5,s3,Fs,'BitsPerSample',16,...
'Comment','This is my new audio file.');
[y_filter,Fs]=audioread(FILE5);
y_filter_fft=fft(y_filter);
% y_filter_fft_f=2*sqrt(y_filter_fft.*conj(y_filter_fft));
axes(handles.axes1);
plot(y_filter);
grid on;axis tight;
title('�����˲���ĺ���ˮӡ��ԭʼ��Ƶ�źŵ�ʱ����');
xlabel('time(s)');ylabel('����');
axes(handles.axes2);
plot(abs(y_filter_fft));
grid on;axis tight;
title('�����˲���ĺ���ˮӡ��ԭʼ��Ƶ�źŵ�Ƶ����');
xlabel('f(Hz)');ylabel('����');
ly2=length(y_filter);
y_filter=y_filter(1:0.5*ly2);
sound(y_filter,Fs);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%--------------------------��ͨ�˲�����ȡˮӡ-------------------------%
cla reset;
FILE1='Rihanna - Take A Bow.wav';
[y,~]=audioread(FILE1);%��Ƶ�ź�y��������fs,��������bits
%��db4С����ԭʼ��Ƶ�źŽ���3��С���ֽ�
y = y(:); % ������ת��Ϊ������
[c,l]=wavedec(y,3,'db4');%3��С���ֽ⣬��Ƶ����Ϊ���ƣ���Ƶ����Ϊϸ��
%��ȡ3��С���ֽ�ĵ�Ƶϵ���͸�Ƶϵ��
ca3=appcoef(c,l,'db4',3);%��ȡ����С���ֽ�����Ƶ��
%cd3=detcoef(c,l,3);%��ȡ����С���ֽ�Ĵε�Ƶ��
%cd2=detcoef(c,l,2);
%cd1=detcoef(c,l,1);
x=ca3;%��ȡ����С���ֽ�����Ƶ����
%�ҵ�����λ�ã����������
s=max(abs(x))*0.2;
i=find(abs(x)>s);
%lx=length(i);
%��ȡ�����˲���ĺ���ˮӡ��ԭʼ��Ƶ
FILE5='final3.wav';
[y_filter,Fs]=audioread(FILE5);
%��db4С���Ծ����˲���ĺ���ˮӡ��ԭʼ��Ƶ�źŽ���3��С���ֽ�
[c2,l1]=wavedec(y_filter,3,'db4');
%��ȡ3��С���ֽ�ĵ�Ƶϵ���͸�Ƶϵ��
ca32=appcoef(c2,l1,'db4',3);
%cd32=detcoef(c2,l1,3);
%cd22=detcoef(c2,l1,2);
%cd12=detcoef(c2,l1,1);
x2=ca32;
%ˮӡ�ź���ȡ
z(i)=x2(i)-x(i);
s3=z(i)./x(i)';
s3=s3/0.02;
%����ȡ��ˮӡ�ź���Ϊfinal4.wav����
FILE6='final4.wav';
% ��һ����Ƶ����
s3 = s3 / max(abs(s3));
audiowrite(FILE6,s3,Fs,'BitsPerSample',16,...
'Comment','This is my new audio file.');
[mark_filter,Fs]=audioread(FILE6);
mark_filter_fft=fft(mark_filter);
% mark_filter_fft_f=2*sqrt(mark_filter_fft.*conj(mark_filter_fft));
axes(handles.axes1);
plot(mark_filter);
grid on;axis tight;
title('�����˲����������ȡ��ˮӡ��Ƶ�źŵ�ʱ����');
xlabel('time(s)');ylabel('����');
axes(handles.axes2);
plot(abs(mark_filter_fft));
grid on;axis tight;
title('�����˲����������ȡ��ˮӡ��Ƶ�źŵ�Ƶ����');
xlabel('f(Hz)');ylabel('����');
sound(mark_filter,Fs);


%fined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.


% --- Executes on button press in playButton.
