% Start EEGLAB
[ALLEEG, EEG, CURRENTSET] = eeglab; 

for sub=8:15  % 前7个我自己跑完了
    for session=1:3
        for trial=1:15
            filepath = strcat(['D:\专业学习\大四\论文\SEED数据集的研究\插值坏导后\','sub',num2str(sub),'\']);
            filename = strcat([filepath,'sub',num2str(sub),'_s',num2str(session),'t',num2str(trial),'.set']);
            EEG=pop_loadset('filename',filename);
            
            EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'pca',30,'interrupt','on');
           
            %make noise label
            %通过训练得到分量属于脑电和六类噪声的概率
            EEG=iclabel(EEG);
            noiselabel=round(EEG.etc.ic_classification.ICLabel.classifications(:,:)*100);
            %flag noise to reject
            %设定噪声概率的阈值用来之后进行噪声去除
            noisethreshold = [0 0.05;0 0; 0 0; 0 0; 0 0; 0 0; 0 0];
            %对应七个分量的可能性：脑电，眼电，肌电，心电，线性噪声，通道噪声，其他
            EEG = pop_icflag(EEG, noisethreshold);
            %低于设定阈值则删除
            %get clean data
            %得到含有干净信号的结构体
            OUTEEG=pop_subcomp(EEG);
            eval([strcat('trial',num2str(trial),'=','OUTEEG.data',';')]);
                    
        end
        savepath = strcat(['D:\专业学习\大四\论文\SEED数据集的研究\MNE_data\','sub',num2str(sub),'\']);
        % savepath = strcat(['D:\专业学习\大四\论文\SEED数据集的研究\sub2_test','\']);
        savename = strcat([savepath,'sub',num2str(sub),'_session',num2str(session),'.mat']);
        save(savename,'trial1','trial2','trial3','trial4','trial5','trial6','trial7','trial8','trial9',...
            'trial10','trial11','trial12','trial13','trial14','trial15');
    end
end
