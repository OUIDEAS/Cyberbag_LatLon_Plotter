%% routing_map_txt_read_export

% This exports each node's gps coordinates 

clear all
close all
clc

%% Var Init

lane_count  = 1;
lane_count_2 = 1;

x           = [];
y           = [];
lat_all     = [];
lon_all     = [];

% proj        = projcrs(6346);
% proj        = projcrs(26917);
% proj = projcrs(3747);
proj = projcrs(3724);
% proj = projcrs();

% [~,export_name,~] = fileparts(export_dir);

%% Opening file and importing into workspace
import_route = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/Raw_Routes/ohio_ridges_v1/routing_map.txt';
import_route_2 = '/media/autobuntu/chonk/chonk/git_repos/Van_Apollo_GPS_Handler/MATLAB_Scripts/Raw_Routes/ohio_ridges_v2/routing_map.txt';

routingmap = import_routing_map_txt(import_route);
routingmap_2 = import_routing_map_txt(import_route_2);


n = size(routingmap);
m = size(routingmap_2);

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

x = [];
y = [];

for line = 1:1:m(1)

    % If line contains x
    if contains(routingmap_2(line,1), 'x:')
        
        x = [x; str2double(routingmap_2(line,2))];
        
    elseif contains(routingmap_2(line,1), 'y:') % If line contains y
        
        y = [y; str2double(routingmap_2(line,2))];
        
    elseif contains(routingmap_2(line,1), 'start_position')
        
        line = line + 3;
    
    elseif contains(routingmap_2(line,1), 'node') % If line contains node
        
        segment_xy_2{lane_count_2} = [x y];
        
        [lat_2,lon_2] = projinv(proj, x, y);
        
        segment_latlon_2{lane_count_2} = [lat_2,lon_2];
    
        lane_count_2 = lane_count_2 + 1;
        
        x = [];
        y = [];
        
    end
    
end

%% Plots all segments as lines

route_line_fig3 = figure('DefaultAxesFontSize', 14, 'Position', [10 10 500 1000]); 

hold all

for seg_idx = 2:1:length(segment_latlon)

    plot(segment_latlon{seg_idx}(1:end-1,1), segment_latlon{seg_idx}(1:end-1,2), 'r')
    
end

hold on
hold all

for seg_idx = 2:1:length(segment_latlon_2)

    plot(segment_latlon_2{seg_idx}(1:end-1,1), segment_latlon_2{seg_idx}(1:end-1,2), 'b')
    
end

axis equal

%% Save data
% 
% if save_data
%     
%     lat_lon_data = [lat_all lon_all];
% 
%     route_data_filename = '/' + string(export_name) + '_lat_lon.csv';
% 
%     full_export_name = string(export_dir) + string(route_data_filename);
% 
%     writematrix(lat_lon_data, full_export_name)
%     
%     
%     
% end
% 
% save(full_export_name + ".mat" , segment_latlon)

%% Save Figure
% 
% if save_png
%     
%     disp('Re-size figures as needed then unpause')
%     
%     pause
%     
%     fig_filename = '/' + string(export_name) + '_png.png';
% 
%     full_fig_export_name = string(export_dir) + string(fig_filename);
%     
%     saveas(route_fig, string(full_fig_export_name), 'png');
%     
% end
% 
% % proj: "+proj=utm +zone=17 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
% 
% 
% 
% 





