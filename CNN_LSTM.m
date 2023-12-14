clear;clc;

%% 加载所有语谱图
% 划分训练集测试集
allImages = imageDatastore("语谱图2", ... 
    'IncludeSubfolders' ,true, ... 
    'LabelSource' , 'foldernames' );% 将尺度图图像加载为图像数据存储
% imageDatastore函数会根据文件夹名称自动标记图像

rng default % 出于可重复性的目的，我们将随机种子设置为默认值。
% 将图像随机分为两组，一组用于训练（80%），另一组用于验证（剩余）。
[imgsTrain,imgsTest] = splitEachLabel(allImages,0.8,'randomized');

% 显示训练集、验证集、测试集的数量
disp(['Number of training images: ',num2str(numel(imgsTrain.Files))]);
disp(['Number of testing images: ',num2str(numel(imgsTest.Files))]);

countEachLabel(imgsTrain) % 输出训练集每类的数目
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

analyzeNetwork(layers);

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
% save trainedNet.mat CNN_LSTMnet;

%load('trainedNet.mat');

%% 测试
y_pred = classify(CNN_LSTMnet,imgsTest);
Accuracy = mean(y_pred == imgsTest.Labels);
disp(['测试集准确率： ',num2str(100*Accuracy),'%']);

%% 混淆矩阵
plotconfusion(imgsTest.Labels,y_pred,'CNN-LSTM');

