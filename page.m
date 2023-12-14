function varargout = page(varargin)
% PAGE MATLAB code for page.fig
%      PAGE, by itself, creates a new PAGE or raises the existing
%      singleton*.
%
%      H = PAGE returns the handle to a new PAGE or the handle to
%      the existing singleton*.
%
%      PAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAGE.M with the given input arguments.
%
%      PAGE('Property','Value',...) creates a new PAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before page_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to page_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help page

% Last Modified by GUIDE v2.5 30-Mar-2023 10:11:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @page_OpeningFcn, ...
                   'gui_OutputFcn',  @page_OutputFcn, ...
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


% --- Executes just before page is made visible.
function page_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to page (see VARARGIN)

% Choose default command line output for page
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes page wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = page_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles) % 生成语谱图
%% 将第一个信号生成语谱图
% clear;clc;
% 
% [y,fs] = audioread('CASIA数据集\angry\angry (1).wav');
% frame_size = 0.025; % 25 ms frame
% frame_shift = 0.01; % 10 ms shift
% frame_matrix = buffer(y, frame_size*fs, frame_shift*fs);
% % 汉明窗
% window = hamming(size(frame_matrix, 1));
% frame_matrix = frame_matrix.*window;
% % STFT
% NFFT = 2^nextpow2(frame_size*fs);
% STFT = fft(frame_matrix, NFFT, 1);
% STFT = abs(STFT(1:NFFT/2+1,:));
% % 画语谱图
% figure;
% spectrogram(y, window, frame_shift*fs, NFFT, fs, 'yaxis');
% title('信号语谱图');

%% 批量生成语谱图
f = msgbox('语谱图生成中，请等待.....', '提示');
clear;clc;
mkdir '语谱图';
mkdir '语谱图/angry'; mkdir '语谱图/fear'; mkdir '语谱图/happy'; mkdir '语谱图/neutral';
mkdir '语谱图/sad'; mkdir '语谱图/surprise';
% 设置参数
fs = 16000;  % 采样率
window = hann(256);  % 窗函数
noverlap = 128;  % 重叠窗口长度
nfft = 512;  % FFT长度
min_freq = 0;  % 最低频率
max_freq = fs/2;  % 最高频率
color_map = jet(256);  % 色图
%% angry
file_list = dir('CASIA数据集/angry/*.wav');
num_files = length(file_list);
% 循环处理每个文件
for i = 1:num_files
    % 读取语音文件
    [x, fs] = audioread(file_list(i).name);
    % 生成语谱图
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    S = ind2rgb(round(S), color_map);

    % 保存为224*224*3的彩色图像
    S = imresize(S, [224, 224]);
    mulu = "语谱图\angry\";
    imwrite(S, fullfile(mulu,['angry' num2str(i) '.png']));
end

%% fear
file_list = dir('CASIA数据集/fear/*.wav');
num_files = length(file_list);

% 循环处理每个文件
for i = 1:num_files
    % 读取语音文件
    [x, fs] = audioread(file_list(i).name);

    % 生成语谱图
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    S = ind2rgb(round(S), color_map);

    % 保存为224*224*3的彩色图像
    S = imresize(S, [224, 224]);
    mulu = "语谱图\fear\";
    imwrite(S, fullfile(mulu,['fear' num2str(i) '.png']));
end

%% happy
file_list = dir('CASIA数据集/happy/*.wav');
num_files = length(file_list);

% 循环处理每个文件
for i = 1:num_files
    % 读取语音文件
    [x, fs] = audioread(file_list(i).name);

    % 生成语谱图
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    S = ind2rgb(round(S), color_map);

    % 保存为224*224*3的彩色图像
    S = imresize(S, [224, 224]);
    mulu = "语谱图\happy\";
    imwrite(S, fullfile(mulu,['happy' num2str(i) '.png']));
end

%% neutral
file_list = dir('CASIA数据集/neutral/*.wav');
num_files = length(file_list);

% 循环处理每个文件
for i = 1:num_files
    % 读取语音文件
    [x, fs] = audioread(file_list(i).name);

    % 生成语谱图
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    S = ind2rgb(round(S), color_map);

    % 保存为224*224*3的彩色图像
    S = imresize(S, [224, 224]);
    mulu = "语谱图\neutral\";
    imwrite(S, fullfile(mulu,['neutral' num2str(i) '.png']));
end

%% sad
file_list = dir('CASIA数据集/sad/*.wav');
num_files = length(file_list);

% 循环处理每个文件
for i = 1:num_files
    % 读取语音文件
    [x, fs] = audioread(file_list(i).name);

    % 生成语谱图
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    S = ind2rgb(round(S), color_map);

    % 保存为224*224*3的彩色图像
    S = imresize(S, [224, 224]);
    mulu = "语谱图\sad\";
    imwrite(S, fullfile(mulu,['sad' num2str(i) '.png']));
end

%% surprise
file_list = dir('CASIA数据集/surprise/*.wav');
num_files = length(file_list);

% 循环处理每个文件
for i = 1:num_files
    % 读取语音文件
    [x, fs] = audioread(file_list(i).name);

    % 生成语谱图
    [S, F, T] = spectrogram(x, window, noverlap, nfft, fs);
    S = abs(S);
    S = S(max_freq>=F & F>=min_freq, :);
    S = 20*log10(S+eps);
    S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
    S = ind2rgb(round(S), color_map);

    % 保存为224*224*3的彩色图像
    S = imresize(S, [224, 224]);
    mulu = "语谱图\surprise\";
    imwrite(S, fullfile(mulu,['surprise' num2str(i) '.png']));
end
f = msgbox('语谱图生成完成', '提示');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles) % 训练
f = msgbox('即将开始训练......', '提示');
%% 加载所有语谱图
% 划分训练集测试集
allImages = imageDatastore("语谱图", ... 
    'IncludeSubfolders' ,true, ... 
    'LabelSource' , 'foldernames' );% 将尺度图图像加载为图像数据存储
% imageDatastore函数会根据文件夹名称自动标记图像

rng default % 出于可重复性的目的，我们将随机种子设置为默认值。
% 将图像随机分为两组，一组用于训练（80%），另一组用于验证（剩余）。
[imgsTrain,imgsRest] = splitEachLabel(allImages,0.7,'randomized');
[imgsValidation,imgsTest] = splitEachLabel(imgsRest,1/3);
countEachLabel(imgsTrain) % 输出训练集每类的数目

% 显示训练集、验证集、测试集的数量
disp(['Number of training images: ',num2str(numel(imgsTrain.Files))]);
disp(['Number of validation images: ',num2str(numel(imgsValidation.Files))]);
disp(['Number of testing images: ',num2str(numel(imgsTest.Files))]);

countEachLabel(imgsTrain) % 输出训练集每类的数目
countEachLabel(imgsValidation) % 输出训练集每类的数目
countEachLabel(imgsTest) % 输出训练集每类的数目

%% 搭建CNN-LSTM
layers = [
    imageInputLayer([224 224 3],"Name","imageinput")
    convolution2dLayer([5 5],8,"Name","卷积层1","Padding","same")
    reluLayer("Name","relu")
    maxPooling2dLayer([3 3],"Name","maxpool","Stride",[2 2])
    convolution2dLayer([3 3],16,"Name","卷积层2")
    reluLayer("Name","relu_1")
    maxPooling2dLayer([3 3],"Name","maxpool_1","Stride",[2 2])
    convolution2dLayer([3 3],8,"Name","卷积层3","Padding","same")
    reluLayer("Name","relu_2")
    maxPooling2dLayer([3 3],"Name","maxpool_2","Stride",[2 2])
    flattenLayer("Name","flatten")
    lstmLayer(200,"Name","LSTM层")
    lstmLayer(50,'Name','LSTM层2')
    fullyConnectedLayer(6,"Name","fc")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];
% analyzeNetwork(layers);
options = trainingOptions('sgdm', ... % 使用随机梯度下降法
    'ExecutionEnvironment','cpu', ... % 在cpu上训练，有GPU的话也可以改为gpu
    'MaxEpochs',30,...% 轮数
    'MiniBatchSize',10, ... % 每小批的数据量
    'Shuffle','once',... % 只打乱一次数据样本顺序
    'GradientThreshold',1, ...% 梯度阈值
    'InitialLearnRate',0.001,...% 初始学习率
    'Verbose',1, ... % 在命令行窗口显示学习情况
    'Plots','training-progress'); % 绘图显示学习情况
%% 开始训练
CNN_LSTMnet = trainNetwork(imgsTrain,layers,options); % 网络训练

% 保存模型
save trainedNet.mat CNN_LSTMnet;

%% 测试
y_pred = classify(CNN_LSTMnet,imgsTest);
Accuracy = mean(y_pred == imgsTest.Labels);
disp(['Test set accuracy： ',num2str(100*Accuracy),'%']);

f = msgbox('训练完成！', '提示');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles) % 加载语音信号
[fn,pn,~]=uigetfile('*.wav','Please select a voice signal');
[y,fs] = audioread([pn fn]);
N = length(y);
n = 0:N-1;
axes(handles.axes1);
plot(n/fs,y);title('Speech signal waveform diagram'); xlabel('Time / s');
handles.y = y; handles.fs = fs;
guidata(gcbo,handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles) % 生成语谱图
y = handles.y; fs = handles.fs;
fs = 16000;  % 采样率
window = hann(256);  % 窗函数
noverlap = 128;  % 重叠窗口长度
nfft = 512;  % FFT长度
min_freq = 0;  % 最低频率
max_freq = fs/2;  % 最高频率
color_map = jet(256);  % 色图
frame_size = 0.025; % 25 ms frame
frame_shift = 0.01; % 10 ms shift
frame_matrix = buffer(y, frame_size*fs, frame_shift*fs);
% 汉明窗
window = hamming(size(frame_matrix, 1));
frame_matrix = frame_matrix.*window;
% STFT
NFFT = 2^nextpow2(frame_size*fs);
STFT = fft(frame_matrix, NFFT, 1);
STFT = abs(STFT(1:NFFT/2+1,:));
% 画语谱图
axes(handles.axes1);
spectrogram(y, window, frame_shift*fs, NFFT, fs, 'yaxis');
title('Signal spectrogram');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles) % 识别、显示识别结果
y = handles.y; fs = handles.fs;
window = hann(256);  % 窗函数
noverlap = 128;  % 重叠窗口长度
nfft = 512;  % FFT长度
min_freq = 0;  % 最低频率
max_freq = fs/2;  % 最高频率
color_map = jet(256);  % 色图
frame_size = 0.025; % 25 ms frame
frame_shift = 0.01; % 10 ms shift
frame_matrix = buffer(y, frame_size*fs, frame_shift*fs);
% 汉明窗
window = hamming(size(frame_matrix, 1));
frame_matrix = frame_matrix.*window;
% STFT
NFFT = 2^nextpow2(frame_size*fs);
STFT = fft(frame_matrix, NFFT, 1);
STFT = abs(STFT(1:NFFT/2+1,:));
[S, F, T] = spectrogram(y, window, noverlap, nfft, fs);
S = abs(S);
S = S(max_freq>=F & F>=min_freq, :);
S = 20*log10(S+eps);
S = (S - min(S(:))) / (max(S(:)) - min(S(:))) * 255;
S = ind2rgb(round(S), color_map);
% 保存为224*224*3的彩色图像
S = imresize(S, [224, 224]);
load('trainedNet.mat');
y_pred = classify(CNN_LSTMnet,S);
% disp(y_pred);
set(handles.edit1,'string',y_pred);


function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
