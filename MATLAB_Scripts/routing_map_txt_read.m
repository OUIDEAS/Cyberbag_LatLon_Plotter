%% routing_map_txt_read_export

% This exports each node's gps coordinates 

clear all
close all
clc

%% Options

%% Var Init

lane_count  = 1;

x           = [];
y           = [];
lat_all     = [];
lon_all     = [];

% proj        = projcrs(6346);
% proj        = projcrs(26917);
% proj = projcrs(3747);
proj = projcrs(3724);
% proj = projcrs();

%% Opening file and importing into workspace
import_route = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/Raw_Routes/ohio_athens_blue_v1/routing_map.txt';

routingmap = import_routing_map_txt(import_route);

n = size(routingmap);

%% Scanning for data

for line = 1:1:n(1)

    % If line contains x
    if contains(routingmap(line,1), 'x:')
        
        x = [x; str2double(routingmap(line,2))];
        
    elseif contains(routingmap(line,1), 'y:') % If line contains y
        
        y = [y; str2double(routingmap(line,2))];
        
    elseif contains(routingmap(line,1), 'start_position')
        
        line = line + 3;
    
    elseif contains(routingmap(line,1), 'node') % If line contains node
        
        segment_xy{lane_count} = [x y];
        
        [lat,lon] = projinv(proj, x, y);
        
        segment_latlon{lane_count} = [lat,lon];
    
        lane_count = lane_count + 1;
        
        x = [];
        y = [];
        
    end
    
end

%% Plots all segments

for seg_idx = 2:1:length(segment_latlon)

    lat_all = [lat_all; segment_latlon{seg_idx}(:,1)];
    lon_all = [lon_all; segment_latlon{seg_idx}(:,2)];
    
end

route_fig = figure('DefaultAxesFontSize', 14, 'Position', [10 10 500 1000]); 
geoscatter(lat_all, lon_all, 'Marker', '.')
geobasemap 'none'



%% Save data

lat_lon_data = [lat_all lon_all];

export_dir = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/Route_Export_Results';

route_data_filename = '/lat_lon_data_ohio_athens_blue_v1.csv';

full_export_name = string(export_dir) + string(route_data_filename);

writematrix(lat_lon_data, full_export_name)

% proj: "+proj=utm +zone=17 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"









