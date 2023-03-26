% Start EEGLAB
[ALLEEG, EEG, CURRENTSET] = eeglab; 

for sub=8:15  % 前7个我自己跑完了
    for session=1:3
        for trial=1:15
            filepath = strcat(['D:\专业学习\大四\论文\SEED数据集的研究\插值坏导后\','sub',num2str(sub),'\']);
            filename = strcat([filepath,'sub',num2str(sub),'_s',num2str(session),'t',num2str(trial),'.set']);
            EEG=pop_loadset('filename',filename);
            
            EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'pca',30,'interrupt','on');

      end
        savepath = strcat(['D:\专业学习\大四\论文\SEED数据集的研究\MNE_data\','sub',num2str(sub),'\']);
        savename = strcat([savepath,'sub',num2str(sub),'_session',num2str(session),'.mat']);
        save(savename,'trial1','trial2','trial3','trial4','trial5','trial6','trial7','trial8','trial9',...
            'trial10','trial11','trial12','trial13','trial14','trial15');
    end
end
