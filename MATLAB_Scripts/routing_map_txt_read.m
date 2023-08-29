%% routing_map_txt_read_export

% This exports each node's gps coordinates 

clear all
% close all
clc

%% Options

save_data = 1;
save_png = 1;
save_fig = 1;

export_dir = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/Route_Export_Results/ohio_athens_blue_v2b_export';

mkdir(export_dir)
addpath(export_dir)


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

[~,export_name,~] = fileparts(export_dir);

%% Opening file and importing into workspace
import_route = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/Raw_Routes/ohio_athens_blue_v2b/routing_map.txt';

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

%% Scatter Plots all segments

for seg_idx = 2:1:length(segment_latlon)

    lat_all = [lat_all; segment_latlon{seg_idx}(:,1)];
    lon_all = [lon_all; segment_latlon{seg_idx}(:,2)];
    
end

route_fig = figure('DefaultAxesFontSize', 24, 'Position', [10 10 500 1200]); 
geoscatter(lat_all, lon_all, 'Marker', '.', 'LineWidth', 50)
geobasemap 'none'


%% Plots all segments as lines

route_line_fig3 = figure('DefaultAxesFontSize', 14, 'Position', [10 10 1200 600]); 

hold all

for seg_idx = 2:1:length(segment_latlon)

    plot(segment_latlon{seg_idx}(1:end-1,2), segment_latlon{seg_idx}(1:end-1,1), 'r', 'LineWidth', 3)
    
end

axis equal

legend("Routing Map")
grid on
xlabel("Longitude")
ylabel("Latitude")


%% Save data

if save_data
    
    lat_lon_data = table(lat_all, lon_all, 'VariableNames', ["Latitude", "Longitude"]);

    route_data_filename = '/' + string(export_name) + '_lat_lon.csv';

    full_export_name = string(export_dir) + string(route_data_filename);

    writetable(lat_lon_data, full_export_name)
    
    save(string(full_export_name + ".mat") , 'segment_latlon')
    
end


%% Save Figure
% 
if save_png
    
    disp('Re-size figures as needed then unpause')
    
    pause
    
    fig_filename = '/' + string(export_name) + '_png.png';

    full_fig_export_name = string(export_dir) + string(fig_filename);
    
    saveas(route_fig, string(full_fig_export_name), 'png');
    
end
% 
% % proj: "+proj=utm +zone=17 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
% 
% 
% 
% 
% 
% 



