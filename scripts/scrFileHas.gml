/*
saves folder change (added): 1 if a file is there and isn't empty, else 0. An empty file (0 bytes) is what reading a
save or options file that isn't there leaves behind, so it counts as not there.
argument0: file name
*/
var tF,tSize;
if !file_exists(argument0) {return 0}
tF=file_bin_open(argument0,0)
tSize=file_bin_size(tF)
file_bin_close(tF)
return (tSize>0)
