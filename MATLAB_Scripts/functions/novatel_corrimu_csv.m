function novatel_corrimu_csv(novatel_corrimu_struct,bag_file)

%% Do Something
for i = 1:length(novatel_corrimu_struct)
    %
    %         novatel_corrimu_struct{1, 1}.VerticalAcc,
    %         novatel_corrimu_struct{1, 1}.ImuDataCount,
    %         novatel_corrimu_struct{1, 1}.PitchRate,
    %         novatel_corrimu_struct{1, 1}.RollRate,
    %         novatel_corrimu_struct{1, 1}.YawRate,
    %         novatel_corrimu_struct{1, 1}.,
    %         novatel_corrimu_struct{1, 1}.PitchRategitudinalAcc
    %novatel_corrimu_struct{1, 1}.ImuDataCount
    
    VerticalAcc(i)                                          = novatel_corrimu_struct{i}.VerticalAcc;
    ImuDataCount(i)                                              = novatel_corrimu_struct{i}.ImuDataCount;
    PitchRate(i)                                              = novatel_corrimu_struct{i}.PitchRate;
    RollRate(i)                                              = novatel_corrimu_struct{i}.RollRate;
    YawRate(i)                                       = novatel_corrimu_struct{i}.YawRate;
    
    
    
end

%% EXPORT CSV

T = table(VerticalAcc', ImuDataCount', PitchRate', RollRate', YawRate');
T.Properties.VariableNames = {'VerticalAcc', 'ImuDataCount', 'PitchRate', 'RollRate', 'YawRate'};
filename = string(bag_file)+'_corrimu'+'.csv';

writetable(T, filename)



end