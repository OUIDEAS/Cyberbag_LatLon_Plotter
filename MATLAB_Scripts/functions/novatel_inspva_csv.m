function novatel_inspva_csv(novatel_inspva_csv_struct,bag_file, bag_init)

%% Do Something
for i = 1:length(novatel_inspva_struct)
    
%     novatel_inspva_struct{1, 1}.Latitude, 
%     novatel_inspva_struct{1, 1}.Longitude, 
%     novatel_inspva_struct{1, 1}.Height, 
%     novatel_inspva_struct{1, 1}.NorthVelocity, 
%     novatel_inspva_struct{1, 1}.EastVelocity, 
%     novatel_inspva_struct{1, 1}.UpVelocity, 
%     novatel_inspva_struct{1, 1}.Roll, 
%     novatel_inspva_struct{1, 1}.Pitch, 
%     novatel_inspva_struct{1, 1}.Azimuth

        Time(i)                                                             = double(novatel_inspva_struct{i}.Header.Stamp.Sec) + double(novatel_inspva_struct{i}.Header.Stamp.Nsec)*(10^-9);
        Latitude(i)                                                         = novatel_inspva_struct{i}.Latitude;
        Longitude(i)                                                        = novatel_inspva_struct{i}.Longitude;
        Height(i)                                                           = novatel_inspva_struct{i}.Height;
        NorthVelocity(i)                                                    = novatel_inspva_struct{i}.NorthVelocity;
        EastVelocity(i)                                                     = novatel_inspva_struct{i}.EastVelocity;
        UpVelocity(i)                                                       = novatel_inspva_struct{i}.UpVelocity;
        Roll(i)                                                             = novatel_inspva_struct{i}.Roll;
        Pitch(i)                                                            = novatel_inspva_struct{i}.Pitch;
        Azimuth(i)                                                          = novatel_inspva_struct{i}.Azimuth;

    
    
end

%% EXPORT CSV

T = table(Time', Latitude', Longitude', Height', NorthVelocity', EastVelocity', UpVelocity', Roll', Pitch', Azimuth');
T.Properties.VariableNames = {'Time', 'Latitude', 'Longitude', 'Height', 'NorthVelocity', 'EastVelocity' 'UpVelocity', 'Roll', 'Pitch', 'Azimuth'};
filename = string(bag_file)+'_inspva_AAAA'+'.csv';

writetable(T, filename)



end