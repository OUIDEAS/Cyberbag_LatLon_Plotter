function sensor_van_rosbag_gps_meter_return(gps_return)

    gps_meter_return_X = []; gps_meter_return_Y = [];

    for i = 1:10
        
        gps_meter_return_X(i)  = deg2km(gps_return(i,2)) * 1000;
        gps_meter_return_Y(i)  = deg2km(gps_return(i,1)) * 1000;
    
    end
    
    gps_meter_return    = [gps_meter_return_X gps_meter_return_Y];
    
end

