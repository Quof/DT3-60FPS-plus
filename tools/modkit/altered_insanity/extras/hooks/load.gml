//Altered Insanity's save data (see the save hook). A save made with the original Altered Insanity has it in ALPHA, with
//the game's own. The save file is open.
var s,i;
s="AlteredInsanity"
if !ini_key_exists(s,"cousinoer5Prog") {s="ALPHA"}
global.cousinoer5Progress=ini_read_real(s,"cousinoer5Prog",0)
global.Cousinoer5HUBX=ini_read_real(s,"999x",0)
global.Cousinoer5HUBY=ini_read_real(s,"999y",0)
global.c5Trials=ini_read_string(s,"999z","0000000000000000000000000000")
for(i=65;i<81;i+=1) {global.bossGalleryTime[i]=ini_read_real(s,"700"+string(i),99999)}
//(as the original: older saves had a shorter c5Trials)
if string_length(global.c5Trials)=8 {global.c5Trials+="00000000000000000000"}
//two more locked doors (51 and 52): the saved strings have 50
while string_length(global.doorKey)<52 {global.doorKey+="0"}
while string_length(global.lockedDoor)<52 {global.lockedDoor+="0"}
