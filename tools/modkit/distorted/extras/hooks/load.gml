//Distorted's save data (see the save hook). A save made with the original Distorted has it in ALPHA, with the game's
//own. The save file is open.
var s;
s="Distorted"
if !ini_key_exists(s,"701") {s="ALPHA"}
global.ddlcMain=ini_read_real(s,"701",0)
global.ddlcBoss=ini_read_real(s,"702",0)
global.hexMain=ini_read_real(s,"703",0)
global.hexSide=ini_read_real(s,"704",0)
global.hexWhy=ini_read_real(s,"705",0)
