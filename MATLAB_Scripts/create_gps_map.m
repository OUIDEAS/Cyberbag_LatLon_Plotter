%% create_gps_map.m

% Create Maps using GPS data gleefully gleaned from cyberbags generated by 
% the OU sensor van "Smort Wheels"

%% Var Init

gps_apphend_all = [];
figure_size = [10 10 1200 800];

%% Select the folder where all the gps data lives

% import_folder = uigetdir('','Grab GPS Import Folder');
import_folder = '/media/autobuntu/chonk/chonk/DATA/cyber_bags_gps_export/record_files_all_test';
addpath(import_folder)

gps_files = dir(fullfile(import_folder,'/*.txt'));

%% Select the export folder

% export_folder = uigetdir('','Grab GPS Export Folder');
export_folder = uigetdir('/media/autobuntu/chonk/chonk/DATA/cyber_bags_gps_export/','Grab GPS Export Folder');

if not(isfolder(export_folder))
    
    mkdir(export_folder)
    
end

addpath(export_folder)

%% Consecutively going through each gps file in the import folder

f                       = waitbar(0,'1','Name','Grabbing dat GPS');
num_loops               = length(gps_files);

for gps_file_idx = 1:num_loops

    % Creates the file name so that the function may then import the file
    gps_filename            = string(gps_files(gps_file_idx).folder) + string(gps_files(gps_file_idx).name);
    
    % Grabbing the data from the file
    [gps_header, gps_data]  = import_data_fun(gps_files(gps_file_idx).name);
    
    gps_apphend_all = [gps_apphend_all; gps_data'];
    
    % Weightbar
    waitbar(gps_file_idx/(num_loops),f,sprintf('%1.1f',(gps_file_idx/num_loops*100)))

end

close(f)

%% Exporting a nice table

% Creating the header
gps_header = gps_header';

% Creating the table
gps_table = array2table(gps_apphend_all, 'VariableNames', gps_header);

% Creating the filename
[~,import_folder_name,~] = fileparts(import_folder);
time_now = convertTo(datetime, 'epochtime');
filename = string(export_folder) + '/' + string(import_folder_name) + '_' + string(time_now) + '.csv';

% Saving the table to disk
writetable(gps_table, string(filename))

%% Grabbing lat lon alt height

lat = gps_apphend_all(:,9);
lon = gps_apphend_all(:,10);
alt = gps_apphend_all(:,11);
sat = gps_apphend_all(:,20);

%% Create Map

route_figure = figure('Position', figure_size, 'DefaultAxesFontSize', 14); 
geoscatter(lat,lon,75,'filled'); 
geobasemap 'satellite'

%% Create Map - With Satellites

sat_figure = figure('Position', figure_size, 'DefaultAxesFontSize', 14); 
geoscatter(lat,lon,75,sat,'filled'); 
geobasemap 'satellite'

% Initilizing the color
RGB = [0 0 0]; 

% Initilizing the tick marks
tm = [0];

for i = 1:max(sat)

    color = [(1 - (i * 1/max(sat))) (i * 1/max(sat)) abs(sin(pi * i/(max(sat))))];

    RGB    = [RGB; color];

    tm  = [tm; i];

end

colormap(RGB)
cbsat = colorbar();
caxis([0,numel(tm)])
cbsat.YTick = 0.5 : 1 : numel(tm);
labelChar = strsplit(sprintf('%i ',tm));
cbsat.TickLabels = labelChar(1:end-1);
cbsat.FontSize = 8; 
cbsat.TickDirection = 'out';
cbsat.Label.String = 'Num Satellites';

%% Create Map - With Altitude

alt_figure = figure('Position', figure_size, 'DefaultAxesFontSize', 14); 
geoscatter(lat,lon,75,alt,'filled'); 
geobasemap 'satellite'
colormap(parula)
cbalt = colorbar;
cbalt.Label.String = 'Elevation (m)';

%% Save Figures

saveas(route_figure, string(export_folder) + "/" + string(import_folder_name) + "_route_figure.png", 'png');
saveas(route_figure, string(export_folder) + "/" + string(import_folder_name) + "_route_figure.fig", 'fig');

saveas(alt_figure, string(export_folder) + "/" + string(import_folder_name) + "_alt_figure.png", 'png');
saveas(alt_figure, string(export_folder) + "/" + string(import_folder_name) + "_alt_figure.fig", 'png');

saveas(sat_figure, string(export_folder) + "/" + string(import_folder_name) + "_sat_figure.png", 'png');
saveas(sat_figure, string(export_folder) + "/" + string(import_folder_name) + "_sat_figure.fig", 'fig');

%% Distance Traveled

y = deg2km(lat); x = deg2km(lon);
dis = hypot(y,x); dis = dis-min(dis);
dis1 = fillmissing(dis,'previous');
dis1(isnan(dis1))=0;
% DisTrav = [0;cumsum(diff(dis1))];
DisTrav = 0;
for i=2:length(dis1)
    DisTrav(i) = DisTrav(i-1) + abs(dis1(i)-dis1(i-1)); 
end
DisIndx = find(DisTrav,1,'first');
DisTrav = DisTrav - DisTrav(DisIndx);

