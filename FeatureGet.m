function [psd] = FeatureGet(sub,session,trial)

%[psd,psd_delta,psd_theta,psd_alpha,psd_beta] = FeatureGet(sub,session,trial)

data = read_data(sub,session,trial);

data = data.';

Fs=200; %采样频率 
s=size(data); 

nfft=512; 
window = hanning(nfft/2,'periodic');
noverlap = nfft/4;

[pxx,f]=pwelch(data,window,noverlap,nfft,Fs); %直接法 

% delta = find(f>=1 & f<=4); % 查找所需频段的频率索引
% psd_delta = pxx(delta,:).'; % 截取所需频段的功率谱估计结果
% psd_theta = pxx(find(f>=4 & f<=8),:).';
% psd_alpha = pxx(find(f>=8 & f<=14),:).';
% psd_beta = pxx(find(f>=14 & f<=30),:).';

power_delta = pxx(f(:,1)>=1 & f(:,1)<=4,:).';
power_theta = pxx(f(:,1)>=4 & f(:,1)<=8,:).';
power_alpha = pxx(f(:,1)>=8 & f(:,1)<=14,:).';
power_beta = pxx(f(:,1)>=14 & f(:,1)<=30,:).';
power_gamma = pxx(f(:,1)>=30 & f(:,1)<=45,:).';

psd=[power_delta,power_theta,power_alpha,power_beta,power_gamma];


function [data] = read_data(sub,session,trial)
%读取数据
% sub为被试序号
% session为实验轮次

filepath = strcat(['D:\专业学习\大四\论文\SEED数据集的研究\MNE_data\','sub',num2str(sub),'\']);
% filepath = strcat(['D:\专业学习\大四\论文\SEED数据集的研究\sub2_test','\']);
filename = strcat([filepath,'sub',num2str(sub),'_session',num2str(session),'.mat']);
file = load(filename);
data =eval(['file.trial',num2str(trial)]);
