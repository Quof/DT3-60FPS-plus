newMapX=176
newMapY=288
toRoom=rExtGateA_6
type=3
bossName="Kamek"
award[0]=190
award[1]=160
award[2]=56
award[3]=29; hasPlat=1

var tCheckGameProgress;
tCheckGameProgress=string_char_at(global.eGateProg,1)
if tCheckGameProgress!="9" {instance_destroy()}
