//Distorted's save data (DDLC progress), in its own section of the save file (the original kept it with the game's own,
//in ALPHA: the load hook reads it from there for a save made with the original). The save file is open.
var s;
s="Distorted"
ini_write_real(s,"701",global.ddlcMain)
ini_write_real(s,"702",global.ddlcBoss)
ini_write_real(s,"703",global.hexMain)
ini_write_real(s,"704",global.hexSide)
ini_write_real(s,"705",global.hexWhy)
