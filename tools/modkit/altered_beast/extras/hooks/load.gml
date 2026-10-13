//Altered Beast's save data (see the save hook). A save made with the original Altered Insanity has it in ALPHA, with the
//game's own. The save file is open.
var s;
s="AlteredBeast"
if !ini_key_exists(s,"999ale") {s="ALPHA"}
global.alterEquip=ini_read_real(s,"999ale",0)
global.alterIntro=ini_read_real(s,"999ali",0)
global.TrueEnabled=ini_read_real(s,"999t1",0)
global.LinkSwordTrue=ini_read_real(s,"999t2",0)
global.LinkArrowTrue=ini_read_real(s,"999t3",0)
global.LinkBombTrue=ini_read_real(s,"999t4",0)
global.XBusterTrue=ini_read_real(s,"999t5",0)
global.XIceTrue=ini_read_real(s,"999t6",0)
global.XGravTrue=ini_read_real(s,"999t7",0)
global.BelmontWhipTrue=ini_read_real(s,"999t8",0)
global.BelmontKnifeTrue=ini_read_real(s,"999t9",0)
global.BelmontWaterTrue=ini_read_real(s,"999t10",0)
global.SamusCannonTrue=ini_read_real(s,"999t11",0)
global.SamusMissileTrue=ini_read_real(s,"999t12",0)
global.SamusBombTrue=ini_read_real(s,"999t13",0)
global.snakeLength=ini_read_real(s,"999s1",15)
global.snakeDelay=ini_read_real(s,"999s2",2)
global.snakeRed=ini_read_real(s,"999s3",1) //(the original saved this one but didn't read it back)
global.crouchOnly=ini_read_real(s,"999s4",0)
global.dashOnly=ini_read_real(s,"999s5",0)
global.amuletItem=ini_read_real(s,"999s6",0)
//no green health after loading (as the original)
global.pGreenLife=0
