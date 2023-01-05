# OU_Van_Apollo_GPS_Grab_n_Plot

Python scripts in the Apollo Files may directly replace files in the apollo directory:

ROOT/apollo/modules/tools/record\_parse_save/

Editing of the parser\_params.yaml indicate the directory with the cyber bags, which is the same directory that record\_parse\_save will export gps files. Each message interpreted will generate a single .txt file.

There are two MATLAB scripts:

create\_gps\_map.m allows MATLAB to consecutively read each gps txt file and save the results as a csv to disk, as well as generate and save three plots.

area\_marker.m allows the user to plot areas unto the map that coorespond to trouble areas the van encountered during it's drive. Areas and a plot may be saved to disk.
