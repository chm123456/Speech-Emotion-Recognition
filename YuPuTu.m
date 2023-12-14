%% 将第一个信号生成语谱图
clear;clc;
[y,fs] = audioread('New Folder\recorded_audio.wav');
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
figure;
spectrogram(y, window, frame_shift*fs, NFFT, fs, 'yaxis');
title('第一个信号语谱图')


%% 批量生成语谱图
clear;clc;
% 创建文件夹
mkdir 语谱图;
mkdir 语谱图/angry; mkdir 语谱图/fear; mkdir 语谱图/happy; 
mkdir 语谱图/neutral; mkdir 语谱图/sad; mkdir 语谱图/surprise;
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

