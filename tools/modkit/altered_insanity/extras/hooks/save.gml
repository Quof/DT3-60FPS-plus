//Altered Insanity's save data, in its own section of the save file (the original kept it with the game's own, in ALPHA:
//the load hook reads it from there for a save made with the original). The save file is open. (Altered Beast's data,
//which the original kept there too, is the Altered Beast mod's.)
var s,i;
s="AlteredInsanity"
ini_write_real(s,"cousinoer5Prog",global.cousinoer5Progress)
ini_write_real(s,"999x",global.Cousinoer5HUBX)
ini_write_real(s,"999y",global.Cousinoer5HUBY)
ini_write_string(s,"999z",global.c5Trials)
//the boss challenges' best times (the game's own boss gallery times are 0-64)
for(i=65;i<81;i+=1) {ini_write_real(s,"700"+string(i),global.bossGalleryTime[i])}
//(as the original did after saving)
global.Cousinoer5HUBY=0
