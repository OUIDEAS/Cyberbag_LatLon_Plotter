# Cyberbag_LatLon_Plotter

Python scripts in the Apollo Files may directly replace files in the apollo directory [ROOT/apollo/modules/tools/record\_parse_save/] or be placed in a seperate directory.

Editing of the parser\_params.yaml indicate the directory with the cyber bags, which is the same directory that record\_parse\_save will export gps files. Each message interpreted will generate a single .txt file.

example usage:

There are two MATLAB scripts:

create\_gps\_map.m allows MATLAB to consecutively read each gps txt file and save the results as a csv to disk, as well as generate and save three plots.

area\_marker.m allows the user to plot areas unto the map that coorespond to trouble areas the van encountered during it's drive. Areas and a plot may be saved to disk.

![example_image](https://user-images.githubusercontent.com/64620392/210857412-ab001eb4-3da5-48ce-9fce-a36edd80ff9b.png)
